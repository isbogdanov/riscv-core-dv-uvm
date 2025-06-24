// uvm_refactored/cpu_interface.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

`timescale 1ns / 1ps
`include "uvm_macros.svh"

interface cpu_interface(input logic clock, input logic rst);
    
    // Core I/O
    logic [31:0] instruction;
    logic [31:0] current_PC;
    
    // Memory Interface Signals
    logic        mem_read;
    logic        mem_write;
    logic [31:0] address;
    logic [31:0] mem_write_data;
    logic [31:0] mem_read_data;

    // Signals for Verification (Commit Stage)
    logic        reg_write_o;
    logic [4:0]  rd_o;
    logic [31:0] rf_rd_value_o;

    // Clocking block for robust testbench synchronization
    clocking cb @(posedge clock);
        default input #1step;
        input instruction;
        output #1ps mem_read_data;
        input current_PC;
        input mem_read;
        input mem_write;
        input address;
        input mem_write_data;
        input reg_write_o;
        input rd_o;
        input rf_rd_value_o;
    endclocking

endinterface 