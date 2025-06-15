# Makefile for the AMD-DV-Sprint project

# --- Variables ---
export QUESTA_HOME = /home/bogdanov/altera/24.1std/questa_fse
VSIM = $(QUESTA_HOME)/bin/vsim

# Set C/C++ compilers for Questa to use system's toolchain
export CC = /usr/bin/gcc
export CXX = /usr/bin/g++

# Phony targets don't represent files
.PHONY: all compile elaborate smoke clean

# --- Targets ---

# Default target
all: smoke

# Compile the design and testbench
compile:
	@echo "--- Compiling all source files ---"
	@$(VSIM) -c -do "do questa/scripts/compile.do"

# Elaborate the design
elaborate: compile
	@echo "--- Elaborating the design ---"
	@$(VSIM) -c -do "vopt +acc -o smoke_top -work work tb_top; quit"

# Run a simple smoke test to ensure the environment is set up correctly
smoke: clean elaborate
	@echo "--- Running smoke test ---"
	@rm -rf "/tmp/$(USER)_dpi_*"
	@$(VSIM) -c -sv_lib $(QUESTA_HOME)/uvm-1.2/linux_x86_64/uvm_dpi -cpppath /usr/bin/gcc smoke_top -do "run -all; quit"

# Clean up simulation files
clean:
	@echo "--- Cleaning up ---"
	@rm -rf work/ transcript vsim.wlf smoke_top* 

# Always clean before running the smoke test to ensure fresh compilation
smoke: clean elaborate 