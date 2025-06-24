// uvm_refactored/drivers/cpu_driver.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class cpu_driver extends uvm_driver;

    `uvm_component_utils(cpu_driver)

    virtual cpu_interface vif;
    memory_model mem_model;

    function new(string name = "cpu_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual cpu_interface)::get(this, "", "vif", vif))
           `uvm_fatal(get_type_name(), "Could not get virtual interface");
        if(!uvm_config_db#(memory_model)::get(this, "", "mem_model", mem_model))
           `uvm_fatal(get_type_name(), "Could not get memory model handle");
    endfunction

    task run_phase(uvm_phase phase);
        // Fork separate, parallel threads for the combinational instruction fetch
        // and the clocked data memory access.
        fork
            // Instruction Fetch Thread (Truly Combinational)
            begin
                logic [31:0] phys_addr;
                logic [31:0] word_addr;
                logic [31:0] instruction_data;
                
                forever begin
                    // Wait for any change in PC to update instruction immediately
                    @(vif.current_PC);
                    
                    // Combinational logic - exactly like hardware instruction memory
                    phys_addr = vif.current_PC - 32'h80000000;
                    word_addr = phys_addr >> 2;
                    mem_model.read(word_addr, instruction_data);
                    
                    // Drive instruction immediately (combinational)
                    vif.instruction = instruction_data;
                end
            end

            // Data Access Thread (Synchronous)
            begin
                logic [31:0] read_data;
                logic [31:0] word_addr;
                forever begin
                    @(vif.cb); // Use clocking block for safe sampling and driving
                    if (!vif.rst) begin
                        if (vif.cb.mem_read) begin
                            word_addr = vif.cb.address >> 2;
                            mem_model.read(word_addr, vif.cb.mem_read_data);
                        end else if (vif.cb.mem_write) begin
                            word_addr = vif.cb.address >> 2;
                            mem_model.write(word_addr, vif.cb.mem_write_data);
                        end
                    end
                end
            end
        join
    endtask

endclass 