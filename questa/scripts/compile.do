# This script compiles the design for simulation.

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

# Compile all source files with coverage if enabled
echo "--- Compiling RTL files ---"
eval "vlog -work work -sv -mfcu $COVERAGE_FLAGS rtl/*.v"

# vlog -work work -sv -mfcu /AI/hardware/projects/xilinx/SYSC4310/verilog/lab3/lab3.srcs/sources_1/new/*.v

echo "--- Compiling UVM scripted flow files ---"
eval "vlog -work work -sv +incdir+$UVM_HOME/src $COVERAGE_FLAGS uvm_scripted_flow/cpu_top.sv"
eval "vlog -work work -sv +incdir+$UVM_HOME/src $COVERAGE_FLAGS uvm_scripted_flow/cpu_checker_if.sv"
eval "vlog -work work -sv +incdir+$UVM_HOME/src $COVERAGE_FLAGS uvm_scripted_flow/tb_top.sv"

echo "--- Compilation finished ---"
quit 