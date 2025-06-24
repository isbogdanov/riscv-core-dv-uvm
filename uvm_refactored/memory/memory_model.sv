// uvm_refactored/memory/memory_model.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class memory_model extends uvm_component;

    `uvm_component_utils(memory_model)

    // Memory is modeled as an associative array of 32-bit words,
    // matching the working RTL memory and the format of the .mem file.
    logic [31:0] mem[bit [31:0]];

    string mem_init_file = "";

    function new(string name = "memory_model", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(string)::get(this, "", "mem_init_file", mem_init_file)) begin
            `uvm_fatal(get_type_name(), "Memory model init file not provided via config_db")
        end
    endfunction

    task run_phase(uvm_phase phase);
        if (mem_init_file != "") begin
            `uvm_info(get_type_name(), $sformatf("Loading memory from file: %s", mem_init_file), UVM_MEDIUM)
            // Use $readmemb to load 32-bit binary words into our 32-bit memory.
            $readmemb(mem_init_file, mem);
        end
    endtask

    // Task to read a 32-bit word from a word-aligned address.
    task read(input bit [31:0] word_addr, output logic [31:0] data);
        if (!mem.exists(word_addr)) begin
            data = 32'hDEADBEEF;
        end else begin
            data = mem[word_addr];
        end
    endtask

    // Task to write a 32-bit word to a word-aligned address.
    task write(input bit [31:0] word_addr, input logic [31:0] data);
        mem[word_addr] = data;
        `uvm_info(get_type_name(), $sformatf("Wrote 0x%h to word address 0x%h", data, word_addr), UVM_FULL)
    endtask

endclass 