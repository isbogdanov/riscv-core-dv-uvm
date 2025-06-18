# Makefile for the AMD-DV-Sprint project

# --- Phony targets (don't represent files) ---
.PHONY: all compile elaborate smoke clean gen sim regress compile_asm spike_sim

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
	@$(VSIM) -c -do "vopt +acc -o smoke_top -work work tb_top; quit"

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