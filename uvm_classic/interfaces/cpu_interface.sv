// uvm_classic/cpu_interface.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

`timescale 1ns / 1ps
`include "uvm_macros.svh"

interface cpu_interface(input logic clock, input logic rst);
    
    logic [31:0] instruction;
    logic [31:0] current_PC;
    
    logic        mem_read;
    logic        mem_write;
    logic [31:0] address;
    logic [31:0] mem_write_data;
    logic [31:0] mem_read_data;

    logic        reg_write_o;
    logic [4:0]  rd_o;
    logic [31:0] rf_rd_value_o;

    clocking monitor_cb @(posedge clock);
        default input #1step output #1ps;
        
        input instruction;
        input current_PC;
        input mem_read;
        input mem_write;
        input address;
        input mem_write_data;
        input mem_read_data;
        input reg_write_o;
        input rd_o;
        input rf_rd_value_o;
    endclocking

    clocking driver_cb @(posedge clock);
        default input #1step output #1ps;
        
        output instruction;
        input  current_PC;
    endclocking

    modport monitor_mp (
        clocking monitor_cb,
        input rst
    );
    
    modport driver_mp (
        clocking driver_cb,
        input rst,
        input current_PC,
        output instruction
    );

endinterface