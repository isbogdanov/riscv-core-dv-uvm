# Makefile for the AMD-DV-Sprint project

# --- Phony targets (don't represent files) ---
.PHONY: all compile elaborate smoke clean gen sim regress compile_asm spike_sim cov formal bug uvm_compile uvm_smoke uvm_regress

# --- Environment Variables ---
# Load environment variables from .env file if it exists.
-include .env
export

# --- Variables ---
VSIM = $(QUESTA_HOME)/bin/vsim

NUM_SEEDS ?= 1
LOG_DIR   ?= logs
SEED_FILE ?= $(LOG_DIR)/seeds.txt
RUN_LOG   ?= $(LOG_DIR)/run.log

# Coverage variables
COV_DIR   ?= coverage
COV_UCDB  ?= $(COV_DIR)/merged.ucdb
COV_JSON  ?= $(COV_DIR)/coverage.json

# Formal verification variables
FORMAL_DIR ?= formal_proof
FORMAL_SBY ?= $(FORMAL_DIR)/pc_x0.sby
FORMAL_LOG ?= $(FORMAL_DIR)/pc_x0.log

# Bug story variables
BUG_DIR   ?= bug_story
BUG_SEED  ?= 12345

# PRESERVE_SEEDS: Set to 1 to skip seed generation and log directory cleaning
PRESERVE_SEEDS ?=

# Test configuration variables (set via command line or .env file)
# Example: TEST_NAME=riscv_rand_instr_test make regress

# --- Main Targets ---

# Default target
all: regress

# Run a full, clean regression. This is the main entry point.
regress: clean elaborate gen compile_asm spike_sim sim
#regress: compile gen compile_asm spike_sim sim

	@echo "--- Regression Complete ---"

# Generate assembly tests and the golden spike log
gen:
	@echo "--- Generating tests and Spike reference log ---"
	@mkdir -p $(LOG_DIR)
	@if [ -z "$(PRESERVE_SEEDS)" ]; then python3 scripts/gen_seeds.py $(NUM_SEEDS) > $(SEED_FILE); fi
	@if [ -f "$(SEED_FILE)" ]; then \
		python3 scripts/run_regression.py $$(cat $(SEED_FILE)); \
	else \
		echo "Error: Seed file '$(SEED_FILE)' not found. Cannot preserve non-existent seeds."; \
		echo "Either run without PRESERVE_SEEDS=1 or create $(SEED_FILE) first."; \
		exit 1; \
	fi

# Manually compile the generated assembly files into ELFs
compile_asm:
	@echo "--- Compiling assembly tests to ELF files ---"
	@if [ ! -f $(SEED_FILE) ]; then \
		echo "Seed file '$(SEED_FILE)' not found. Please run 'make gen' first."; \
		exit 1; \
	fi
	@python3 scripts/compile_assembly.py

# Convert compiled ELF files to Verilog memory format
mem_convert:
	@echo "--- Converting ELF files to memory format ---"
	@python3 scripts/mem_convert.py

# Run the reference Spike simulation to generate the golden trace log
spike_sim: compile_asm
	@echo "--- Running Spike reference simulation ---"
	@if [ ! -f $(SEED_FILE) ]; then \
		echo "Seed file '$(SEED_FILE)' not found. Please run 'make gen' first."; \
		exit 1; \
	fi
	@python3 scripts/run_spike.py $$(cat $(SEED_FILE))

# Simulate previously generated tests and compare results
sim:
	@echo "--- Simulating generated tests and comparing results ---"
	@if [ ! -f $(SEED_FILE) ]; then \
		echo "Seed file '$(SEED_FILE)' not found. Please run 'make gen' first."; \
		exit 1; \
	fi
	@python3 scripts/run_simulation.py $$(cat $(SEED_FILE)) | tee $(RUN_LOG)

# --- Build Prerequisite Targets ---

# Compile RTL and testbench
compile:
	@echo "--- Compiling all source files ---"
	@$(VSIM) -c -do "do questa/scripts/compile.do"

# Elaborate the design for simulation
elaborate: clean compile
	@echo "--- Elaborating the design ---"
	@if [ "$(COV_ENABLE)" = "1" ]; then \
		$(VSIM) -c -do "vopt +acc +cover=sbfec -o smoke_top -work work tb_top; quit"; \
	else \
		$(VSIM) -c -do "vopt +acc -o smoke_top -work work tb_top; quit"; \
	fi

# --- Utility Targets ---

# Run a simple smoke test to ensure the base environment is set up
smoke: clean elaborate
	@echo "--- Running smoke test ---"
	@mkdir -p $(LOG_DIR)
	@rm -rf "/tmp/$(USER)_dpi_*"
	@$(VSIM) -c -sv_lib $(QUESTA_HOME)/uvm-1.2/linux_x86_64/uvm_dpi -cpppath $(HOST_CC_PATH) smoke_top -do "run -all; quit"

# Compile UVM refactored implementation only
uvm_compile:
	@echo "--- Compiling UVM Classic implementation ---"
	@$(VSIM) -c -do "do questa/scripts/compile_uvm_classic.do"

# Run a smoke test on the new UVM refactored environment
uvm_smoke: clean uvm_compile
	@echo "--- Running UVM smoke test ---"
	@$(VSIM) -c -sv_lib $(QUESTA_HOME)/uvm-1.2/linux_x86_64/uvm_dpi \
		-cpppath $(HOST_CC_PATH) \
		-do "run -all; quit" \
		uvm_top \
		+UVM_TESTNAME=riscv_base_test

# Elaborate the UVM design for simulation
uvm_elaborate: clean uvm_compile
	@echo "--- Elaborating the UVM design ---"
	@if [ "$(COV_ENABLE)" = "1" ]; then \
		echo "Coverage is enabled"; \
		$(VSIM) -c -do "vopt +acc +cover=sbfec -o uvm_regress_top -work work uvm_top; quit"; \
	else \
		echo "Coverage is disabled"; \
		$(VSIM) -c -do "vopt +acc -o uvm_regress_top -work work uvm_top; quit"; \
	fi

# Run a UVM regression using a generated test program
uvm_regress: uvm_elaborate gen compile_asm mem_convert spike_sim
	@echo "--- Running UVM regression ---"; \
	if [ ! -f "$(SEED_FILE)" ]; then \
		echo "Seed file '$(SEED_FILE)' not found. Please run 'make gen' first."; \
		exit 1; \
	fi; \
	SEEDS=$$(cat $(SEED_FILE)); \
	for SEED in $$SEEDS; do \
		echo "--- Running test for SEED=$$SEED ---"; \
		MEM_FILE=$$(find out_*/asm_test -name "*_$$SEED.o.mem" -print -quit); \
		SPIKE_LOG=$$(find out_*/spike_sim -name "*_$$SEED.log" -print -quit); \
		if [ -z "$$MEM_FILE" ] || [ -z "$$SPIKE_LOG" ]; then \
			echo "Error: Could not find files for SEED=$$SEED. Please check previous steps."; \
			exit 1; \
		fi; \
		echo "Found memory file: $$MEM_FILE"; \
		echo "Found spike log: $$SPIKE_LOG"; \
		VSIM_CMD="$(VSIM) -c -sv_lib $(QUESTA_HOME)/uvm-1.2/linux_x86_64/uvm_dpi "; \
		DO_FILE_CONTENT=""; \
		if [ "$(COV_ENABLE)" = "1" ]; then \
			echo "Coverage enabled for simulation run."; \
			mkdir -p $(COV_DIR); \
			VSIM_CMD="$$VSIM_CMD -coverage"; \
			DO_FILE_CONTENT="coverage save -onexit -testname uvm_test_$$SEED $(COV_DIR)/sim_$$SEED.ucdb; "; \
		fi; \
		DO_FILE_CONTENT="$$DO_FILE_CONTENT run -all; quit"; \
		VSIM_CMD="$$VSIM_CMD -cpppath $(HOST_CC_PATH) uvm_regress_top -do \"$$DO_FILE_CONTENT\" +UVM_TESTNAME=riscv_base_test +MEM_FILE=$$MEM_FILE +SPIKE_LOG=$$SPIKE_LOG"; \
		echo "Executing: $$VSIM_CMD"; \
		eval "$$VSIM_CMD" | tee -a $(LOG_DIR)/uvm_run.log; \
	done
	@echo "--- Moving simulator logs ---"; \
	for f in vsim_stacktrace.vstf tr_db.log transcript; do \
		if [ -f "$$f" ]; then mv -f "$$f" "$(LOG_DIR)/"; fi; \
	done

# Run a debug simulation using a fixed RAM file
debug_ram: clean elaborate
	@echo "--- Running debug simulation with RAM_data_test.txt ---"
	@mkdir -p $(LOG_DIR)
	@rm -f debug_ram_trace.log
	@$(VSIM) -c -do "run -all; quit" \
	    -sv_lib $(QUESTA_HOME)/uvm-1.2/linux_x86_64/uvm_dpi \
	    -cpppath $(HOST_CC_PATH) \
	    smoke_top \
	    +trace_log="debug_ram_trace.log" \
	    +ram_init_file="RAM_data_test.txt"

# Clean up simulation files
clean:
	@echo "--- Cleaning up ---"
	@rm -rf work/ transcript vsim.wlf smoke_top* out_* 
	@if [ -z "$(PRESERVE_SEEDS)" ]; then rm -rf $(LOG_DIR)/*; fi
	@if [ "$(COV_ENABLE)" = "1" ]; then \
		echo "Coverage enabled - cleaning old coverage data"; \
		rm -rf $(COV_DIR)/*; \
	fi
	@rm -rf /tmp/$(USER)_dpi_* 

# --- Tier A Verification Targets ---

# Generate and merge functional coverage reports
cov:
	@echo "--- Generating coverage reports ---"
	@mkdir -p $(COV_DIR)
	@# Find all UCDB files and merge them
	@UCDB_FILES=$$(find $(COV_DIR) -name "sim_*.ucdb" 2>/dev/null || true); \
	if [ -z "$$UCDB_FILES" ]; then \
		echo "No coverage databases found. Run regression with coverage first:"; \
		echo "  COV_ENABLE=1 make regress"; \
		exit 1; \
	fi; \
	echo "Merging coverage databases: $$UCDB_FILES"; \
	rm -f $(COV_UCDB); \
	vcover merge -64 -suppress 6854 $(COV_UCDB) $$UCDB_FILES
	@# Generate HTML report
	@vcover report -html -details -output $(COV_DIR)/html $(COV_UCDB)
	@# Generate JSON summary
	@python3 scripts/merge_cov.py $(COV_UCDB) -o $(COV_JSON)
	@echo "Coverage reports generated:"
	@echo "  JSON: $(COV_JSON)"
	@echo "  HTML: $(COV_DIR)/html/index.html"

# Run formal verification using SymbiYosys
formal:
	@echo "--- Running formal verification ---"
	@mkdir -p $(FORMAL_DIR)
	@if [ ! -f $(FORMAL_SBY) ]; then \
		echo "Formal script not found: $(FORMAL_SBY)"; \
		echo "Please create the SymbiYosys script first."; \
		exit 1; \
	fi
	@cd $(FORMAL_DIR) && sby -f pc_x0.sby | tee pc_x0.log
	@echo "Formal verification complete. Check $(FORMAL_LOG) for results."

# Automated demonstration of RISC-V ADDI bug discovery and fix
bug:
	@echo "--- Automated RISC-V ADDI Bug Demonstration ---"
	@echo "Demonstrating real bug discovered in ALU_controller.v"
	@echo ""
	
	@# Start with completely clean state
	@echo "Cleaning workspace for demonstration..."
	@make clean
	
	@# Save current state
	@echo "Saving current git state..."
	@git stash push -m "Temporary stash for automated bug demo" || true
	@CURRENT_BRANCH=$$(git branch --show-current); \
	\
	echo ""; \
	echo "1. Running BUGGY version (branch: bug_demo_addi_controller)..."; \
	git checkout bug_demo_addi_controller; \
	mkdir -p logs; \
	echo "695998" > logs/seeds.txt; \
	echo "   Testing ADDI with large immediate - expecting FAILURE..."; \
	echo ""; \
	PRESERVE_SEEDS=1 make regress || echo "   ✓ Bug reproduced - ADDI fails as expected"; \
	\
	echo ""; \
	echo "2. Running FIXED version (branch: $$CURRENT_BRANCH)..."; \
	git checkout $$CURRENT_BRANCH; \
	git stash pop || true; \
	make clean; \
	mkdir -p logs; \
	echo "695998" > logs/seeds.txt; \
	echo "   Testing same instruction with fix - expecting PASS..."; \
	echo ""; \
	PRESERVE_SEEDS=1 make regress && echo "   ✓ Fix verified - ADDI now works correctly" || echo "   ✗ Unexpected failure"; \
	\
	echo ""; \
	echo "Bug demonstration complete!"; \
	echo "See $(BUG_DIR)/BUG.md for detailed technical analysis." 