# Makefile for the AMD-DV-Sprint project

# --- Phony targets (don't represent files) ---
.PHONY: all compile elaborate smoke clean gen sim regress compile_asm spike_sim

# --- Variables ---
export QUESTA_HOME = /home/bogdanov/altera/24.1std/questa_fse
export SPIKE_HOME =
VSIM = $(QUESTA_HOME)/bin/vsim
export CC = /usr/bin/gcc
export CXX = /usr/bin/g++

NUM_SEEDS ?= 1
SEED_FILE ?= seeds.txt

# --- Main Targets ---

# Default target
all: regress

# Run a full, clean regression. This is the main entry point.
regress: clean elaborate gen compile_asm spike_sim sim
	@echo "--- Regression Complete ---"

# Generate assembly tests and the golden spike log
gen:
	@echo "--- Generating tests and Spike reference log ---"
	@python3 scripts/gen_seeds.py $(NUM_SEEDS) > $(SEED_FILE)
	@chmod +x scripts/run_regression.sh
	@./scripts/run_regression.sh --steps gen $$(cat $(SEED_FILE))

# Manually compile the generated assembly files into ELFs
compile_asm:
	@echo "--- Compiling assembly tests to ELF files ---"
	@if [ ! -f $(SEED_FILE) ]; then \
		echo "Seed file '$(SEED_FILE)' not found. Please run 'make gen' first."; \
		exit 1; \
	fi
	@chmod +x scripts/compile_assembly.sh
	@./scripts/compile_assembly.sh

# Run the reference Spike simulation to generate the golden trace log
spike_sim:
	@echo "--- Running Spike reference simulation ---"
	@if [ ! -f $(SEED_FILE) ]; then \
		echo "Seed file '$(SEED_FILE)' not found. Please run 'make gen' first."; \
		exit 1; \
	fi
	@./scripts/run_regression.sh --steps iss_sim $$(cat $(SEED_FILE))

# Simulate previously generated tests and compare results
sim:
	@echo "--- Simulating generated tests and comparing results ---"
	@if [ ! -f $(SEED_FILE) ]; then \
		echo "Seed file '$(SEED_FILE)' not found. Please run 'make gen' first."; \
		exit 1; \
	fi
	@chmod +x scripts/run_simulation.sh
	@./scripts/run_simulation.sh $$(cat $(SEED_FILE)) | tee run.log

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
	@rm -rf "/tmp/$(USER)_dpi_*"
	@$(VSIM) -c -sv_lib $(QUESTA_HOME)/uvm-1.2/linux_x86_64/uvm_dpi -cpppath /usr/bin/gcc smoke_top -do "run -all; quit"

# Run a debug simulation using a fixed RAM file
debug_ram: clean elaborate
	@echo "--- Running debug simulation with RAM_data_test.txt ---"
	@rm -f debug_ram_trace.log
	@$(VSIM) -c -do "run -all; quit" \
	    -sv_lib $(QUESTA_HOME)/uvm-1.2/linux_x86_64/uvm_dpi \
	    -cpppath /usr/bin/gcc \
	    smoke_top \
	    +trace_log="debug_ram_trace.log" \
	    +ram_init_file="RAM_data_test.txt"

# Clean up simulation files
clean:
	@echo "--- Cleaning up ---"
	@rm -rf work/ transcript vsim.wlf smoke_top* out_* $(SEED_FILE) *.log 