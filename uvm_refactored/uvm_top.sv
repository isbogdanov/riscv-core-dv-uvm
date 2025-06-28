// uvm_refactored/uvm_top.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

`timescale 1ns/1ps;
`include "uvm_macros.svh"

module uvm_top;
    import uvm_pkg::*;
    import riscv_uvm_pkg::*;

    logic clock;
    logic rst;

    // Instantiate the interface
    cpu_interface cpu_if_inst(clock, rst);

    // Instruction memory - combinational for processor performance
    // This will remain hardware-driven even with future driver implementation
    instruction_memory instr_mem (
        .address(cpu_if_inst.current_PC[31:0]),
        .instruction(cpu_if_inst.instruction)
    );

    // Data memory - synchronous interface, prepared for future driver control
    // Currently hardware-driven, but interface is ready for UVM driver
    data_memory data_mem (
        .mem_read(cpu_if_inst.mem_read),
        .mem_write(cpu_if_inst.mem_write),
        .address(cpu_if_inst.address),
        .write_data(cpu_if_inst.mem_write_data),
        .read_data(cpu_if_inst.mem_read_data),
        .clk(clock),
        .rst(rst)
    );

    // Memory initialization exactly like tb_top.sv
    initial begin
        string ram_init_file;
        
        // Get ELF file from simulator arguments
        if ($value$plusargs("MEM_FILE=%s", ram_init_file)) begin
            $display("[UVM_TOP] Loading RAM init file: %s", ram_init_file);
            $readmemb(ram_init_file, instr_mem.RAM);
        end else begin
            $display("[UVM_TOP] No MEM_FILE specified");
        end
    end

    // Instantiate the DUT and connect it to the interface
    // All connections go through interface for consistent timing discipline
    cpu_top dut (
        .clock(clock),
        .rst(rst),
        .instruction(cpu_if_inst.instruction),
        .current_PC(cpu_if_inst.current_PC),
        .mem_read(cpu_if_inst.mem_read),
        .mem_write(cpu_if_inst.mem_write),
        .address(cpu_if_inst.address),
        .mem_write_data(cpu_if_inst.mem_write_data),
        .mem_read_data(cpu_if_inst.mem_read_data),
        .reg_write_o(cpu_if_inst.reg_write_o),
        .rd_o(cpu_if_inst.rd_o),
        .rf_rd_value_o(cpu_if_inst.rf_rd_value_o)
    );

    // Clock and Reset Generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    // UVM Test Execution
    initial begin
        // Place the interface into the UVM configuration database for all components
        uvm_config_db#(virtual cpu_interface.monitor_mp)::set(null, "uvm_test_top.*", "vif", cpu_if_inst.monitor_mp);
        
        // Start the UVM test. The test name can be overridden from the command line.
        run_test(); 
    end

    // ECALL detection using interface signals for consistency
    always @(posedge clock) begin
        if (!rst && cpu_if_inst.instruction == 32'h00000073) begin
            $display("ECALL instruction detected at PC=0x%h. Test will complete via UVM.", cpu_if_inst.current_PC);
        end
    end

    // TEMPORARY DEBUG: Combinational check to see if mem_read/mem_write are ever asserted.
    always @(*) begin
        if (cpu_if_inst.mem_read) begin
            $display("[DEBUGGER] mem_read asserted at time %t", $time);
        end
        if (cpu_if_inst.mem_write) begin
            $display("[DEBUGGER] mem_write asserted at time %t", $time);
        end
    end

endmodule 