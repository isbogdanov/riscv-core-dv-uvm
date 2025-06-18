# Makefile for the AMD-DV-Sprint project

# --- Phony targets (don't represent files) ---
.PHONY: all compile elaborate smoke clean gen sim regress compile_asm spike_sim cov formal bug

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
	@python3 scripts/run_regression.py $$(cat $(SEED_FILE))

# Manually compile the generated assembly files into ELFs
compile_asm:
	@echo "--- Compiling assembly tests to ELF files ---"
	@if [ ! -f $(SEED_FILE) ]; then \
		echo "Seed file '$(SEED_FILE)' not found. Please run 'make gen' first."; \
		exit 1; \
	fi
	@python3 scripts/compile_assembly.py

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
	@rm -rf /tmp/$(USER)_dpi_* 

# --- Tier A Verification Targets ---

# Generate and merge functional coverage reports
cov:
	@echo "--- Generating coverage reports ---"
	@mkdir -p $(COV_DIR)
	@# Find all UCDB files and merge them
	@UCDB_FILES=$$(find $(COV_DIR) -name "*.ucdb" 2>/dev/null || true); \
	if [ -z "$$UCDB_FILES" ]; then \
		echo "No coverage databases found. Run regression with coverage first:"; \
		echo "  COV_ENABLE=1 make regress"; \
		exit 1; \
	fi; \
	echo "Merging coverage databases: $$UCDB_FILES"; \
	vcover merge $(COV_UCDB) $$UCDB_FILES
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

# Replay a specific bug scenario for demonstration
bug:
	@echo "--- Running bug replay scenario ---"
	@mkdir -p $(BUG_DIR)
	@echo "Replaying test with seed $(BUG_SEED) for bug analysis..."
	@python3 scripts/run_simulation.py $(BUG_SEED) > $(BUG_DIR)/bug_replay.log 2>&1 || true
	@echo "Bug replay complete. Check $(BUG_DIR)/ for analysis files." 