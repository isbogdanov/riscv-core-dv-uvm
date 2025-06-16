// Wrapper for the RISC-V processor core, adding formal properties
// and preparing it for integration into a larger test environment.

`include "uvm_macros.svh"

module cpu_top(
    input clock,
    input rst,
    input [31:0] instruction,
    output [31:0] current_PC, 
    
    output mem_read,
    output mem_write,
    output [3:0]  address,
    
    output [31:0] mem_write_data, 
    input [31:0] mem_read_data,

    // Expose verification signals
    output wire reg_write_o,
    output wire [4:0] rd_o,
    output [31:0] rf_rd_value_o
);

    processor processor_inst (
        .clock(clock),
        .rst(rst),
        .instruction(instruction),
        .current_PC(current_PC),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .mem_write_data(mem_write_data),
        .mem_read_data(mem_read_data),
        .reg_write(reg_write_o),
        .rd(rd_o),
        .to_REG_WRITE_DATA(rf_rd_value_o)
    );

endmodule 