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
    
    // Memory Interface Signals (prepared for future driver control)
    logic        mem_read;
    logic        mem_write;
    logic [31:0] address;
    logic [31:0] mem_write_data;
    logic [31:0] mem_read_data;

    // Signals for Verification (Commit Stage)
    logic        reg_write_o;
    logic [4:0]  rd_o;
    logic [31:0] rf_rd_value_o;

    // Clocking block for UVM components (monitors and future drivers)
    // This provides consistent timing discipline across all UVM components
    clocking cb @(posedge clock);
        default input #1step output #1ps;
        
        // Instruction interface (read-only for monitors)
        input instruction;
        input current_PC;
        
        // Memory interface (read by monitor, will be driven by future driver)
        input mem_read;
        input mem_write;
        input address;
        input mem_write_data;
        input mem_read_data;
        
        // Commit stage monitoring (read-only)
        input reg_write_o;
        input rd_o;
        input rf_rd_value_o;
    endclocking

    // Modport for monitor (passive observation only)
    modport monitor_mp (
        clocking cb,
        input rst
    );
    
    // Modport for future driver (active stimulus generation)
    modport driver_mp (
        clocking cb,
        input rst
    );

endinterface 