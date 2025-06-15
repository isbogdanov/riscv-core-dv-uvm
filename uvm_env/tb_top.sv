`timescale 1ns / 1ps
`include "uvm_macros.svh"

// This is the main UVM testbench top module. It instantiates the DUT
// and the interface that connects it to the UVM verification components.
module tb_top;

    import uvm_pkg::*;

    // Simple clock and reset logic
    logic clock;
    logic rst;

    // DUT signals
    wire [31:0] instruction;
    wire [31:0] current_PC;
    wire  mem_read;
    wire  mem_write;
    wire [3:0]  address;
    wire [31:0] mem_write_data;
    wire [31:0] mem_read_data;
    wire  reg_write_o;
    wire [4:0]  rd_o;

    // Instantiate the memories
    instruction_memory instr_mem (
        .address(current_PC[31:0]),
        .instruction(instruction)
    );

    data_memory data_mem (
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .write_data(mem_write_data),
        .read_data(mem_read_data),
        .clk(clock),
        .rst(rst)
    );

    initial begin
        // Enable waveform dumping for debug using standard Verilog commands
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_top);
    end

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        rst = 1;
        repeat(5) @(posedge clock);
        rst = 0;
        #1000;
        $finish;
    end

    // DUT instantiation
    cpu_top dut (
        .clock(clock),
        .rst(rst),
        .instruction(instruction),
        .current_PC(current_PC),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .mem_write_data(mem_write_data),
        .mem_read_data(mem_read_data)
    );

    // Bind the formal interface to the DUT instance's internal signals
    bind cpu_top cpu_formal_if formal_if_inst (
        .clock(clock),
        .rst(rst),
        .current_PC(current_PC),
        .reg_write_o(dut.reg_write_o),
        .rd_o(dut.rd_o)
    );

endmodule
