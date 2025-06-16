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

# Compile UVM package
echo "--- Compiling UVM library ---"
vlog -L mtiUvm -work work -sv +incdir+$UVM_HOME/src $UVM_HOME/src/uvm_pkg.sv
vlog -L mtiUvm -work work -sv +define+QUESTA_UVM_DPI_DISABLE +incdir+$UVM_HOME/src $env(QUESTA_HOME)/verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv

# Compile all source files
echo "--- Compiling RTL files ---"
vlog -work work -sv -mfcu rtl/*.v

# vlog -work work -sv -mfcu /AI/hardware/projects/xilinx/SYSC4310/verilog/lab3/lab3.srcs/sources_1/new/*.v

echo "--- Compiling UVM environment files ---"
vlog -work work -sv +incdir+$UVM_HOME/src uvm_env/cpu_top.sv
vlog -work work -sv +incdir+$UVM_HOME/src uvm_env/cpu_formal_if.sv
vlog -work work -sv +incdir+$UVM_HOME/src uvm_env/tb_top.sv

echo "--- Compilation finished ---"
quit 