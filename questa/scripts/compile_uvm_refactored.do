# This script compiles the UVM Refactored implementation for simulation.

# Create the work library
vlib work

# Set the search path for UVM
if { [info exists env(UVM_HOME)] } {
    set UVM_HOME $env(UVM_HOME)
} else {
    echo "ERROR: UVM_HOME environment variable not set."
    exit -1
}

# Check if coverage is enabled
set COVERAGE_FLAGS ""
if { [info exists env(COV_ENABLE)] && $env(COV_ENABLE) == "1" } {
    set COVERAGE_FLAGS "+cover=sbfec +acc"
    echo "--- Coverage enabled ---"
}

# Compile UVM package
echo "--- Compiling UVM library ---"
vlog -L mtiUvm -work work -sv +incdir+$UVM_HOME/src $UVM_HOME/src/uvm_pkg.sv
vlog -L mtiUvm -work work -sv +define+QUESTA_UVM_DPI_DISABLE +incdir+$UVM_HOME/src $env(QUESTA_HOME)/verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv

# Compile all RTL files with coverage if enabled
echo "--- Compiling RTL files ---"
eval "vlog -work work -sv -mfcu $COVERAGE_FLAGS rtl/*.v"

# --- UVM Refactored Environment ---
echo "--- Compiling UVM Refactored environment files ---"
eval "vlog -work work -sv +incdir+$UVM_HOME/src $COVERAGE_FLAGS uvm_refactored/cpu_top.sv"
eval "vlog -work work -sv +incdir+$UVM_HOME/src $COVERAGE_FLAGS uvm_refactored/cpu_interface.sv"
eval "vlog -work work -sv +incdir+$UVM_HOME/src $COVERAGE_FLAGS uvm_refactored/riscv_uvm_pkg.sv"
eval "vlog -work work -sv +incdir+$UVM_HOME/src $COVERAGE_FLAGS uvm_refactored/uvm_top.sv"

echo "--- UVM Refactored compilation finished ---"
quit 