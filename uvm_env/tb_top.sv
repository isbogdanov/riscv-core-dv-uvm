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
    wire [31:0]  address;
    wire [31:0] mem_write_data;
    wire [31:0] mem_read_data;
    wire  reg_write_o;
    wire [4:0]  rd_o;
    wire [31:0] rf_rd_value_o;

    integer trace_file;

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
        string elf_file;
        string trace_log;
        string ram_init_file;

        // Get ELF file and trace log path from simulator arguments
        if ($value$plusargs("ram_init_file=%s", ram_init_file)) begin
            $display("[TB] Loading RAM init file: %s", ram_init_file);
            $readmemb(ram_init_file, instr_mem.RAM);
        end

        if ($value$plusargs("trace_log=%s", trace_log)) begin
            $display("[TB] Opening trace log for writing: %s", trace_log);
            trace_file = $fopen(trace_log, "w");
        end else begin
            trace_file = $fopen("rtl_trace.log", "w");
        end

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
        @(posedge clock);
        rst = 0;
        #40000; // Increased simulation time for longer tests
        $fclose(trace_file);
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
        .mem_read_data(mem_read_data),
        .reg_write_o(reg_write_o),
        .rd_o(rd_o),
        .rf_rd_value_o(rf_rd_value_o)
    );

    // This block will write the trace of retired instructions to the log file
    // This must match the format of the Spike log for comparison.
    always @(posedge clock) begin
        if (!rst) begin
            if (reg_write_o) begin
                // Log instructions that have a GPR write
                $fdisplay(trace_file, "core   0: 0x%08h (0x%08h) x%02d 0x%08h",
                          current_PC, instruction, rd_o, rf_rd_value_o);
            end else begin
                // Log instructions that do not write to a GPR (branches, stores, etc.)
                $fdisplay(trace_file, "core   0: 0x%08h (0x%08h)",
                          current_PC, instruction);
            end
        end
    end

    // Bind the formal interface to the DUT instance's internal signals
    bind cpu_top cpu_formal_if formal_if_inst (
        .clock(clock),
        .rst(rst),
        .current_PC(current_PC),
        .reg_write_o(reg_write_o),
        .rd_o(rd_o)
    );

endmodule 