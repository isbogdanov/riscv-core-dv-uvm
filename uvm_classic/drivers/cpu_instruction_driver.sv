// uvm_classic/drivers/cpu_instruction_driver.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class cpu_instruction_driver extends uvm_driver#(riscv_instruction_transaction);
    `uvm_component_utils(cpu_instruction_driver)

    riscv_dut_config cfg;

    logic [31:0] instruction_memory[logic [31:0]];
    bit memory_loaded = 0;

    function new(string name = "cpu_instruction_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(riscv_dut_config)::get(this, "", "cfg", cfg))
            `uvm_fatal("DRIVER", "Failed to get configuration object")
    endfunction

    virtual task run_phase(uvm_phase phase);
        
        cfg.driver_vif.instruction = 32'h00000013; // NOP
        
        wait(!cfg.driver_vif.rst);
        `uvm_info("DRIVER", "Reset released, starting transaction-based instruction driving", UVM_MEDIUM)
        
        fork
            forever begin
                riscv_instruction_transaction txn;
                
                seq_item_port.get_next_item(txn);
                
                instruction_memory[txn.pc_address] = txn.instruction;
                `uvm_info("DRIVER", $sformatf("Received transaction: PC=0x%h, INSTR=0x%h, TYPE=%s", 
                                             txn.pc_address, txn.instruction, txn.instr_type.name()), UVM_HIGH)
                
                if (txn.pc_address == 32'h80000000) begin
                    cfg.driver_vif.instruction = txn.instruction;
                    `uvm_info("DRIVER", $sformatf("Driving first instruction immediately: PC=0x%h, INSTR=0x%h", 
                                                 txn.pc_address, txn.instruction), UVM_MEDIUM)
                end
                
                if (txn.instruction_delay > 0) begin
                    `uvm_info("DRIVER", $sformatf("Applying delay of %0d cycles", txn.instruction_delay), UVM_HIGH)
                    repeat(txn.instruction_delay) @(posedge cfg.driver_vif.driver_cb);
                end
                
                seq_item_port.item_done();
                
                memory_loaded = 1;
            end
            
            forever begin
                logic [31:0] current_pc;
                logic [31:0] instruction;
                
                @(cfg.driver_vif.current_PC);
                current_pc = cfg.driver_vif.current_PC;
                
                if (current_pc === 32'hxxxxxxxx || $isunknown(current_pc)) begin
                    `uvm_warning("DRIVER", $sformatf("PC is X/Z: %h, driving NOP during unknown state", current_pc))
                    cfg.driver_vif.instruction = 32'h00000013; // NOP
                    continue;
                end
                
                if (!cfg.driver_vif.rst) begin
                    if (instruction_memory.exists(current_pc)) begin
                        instruction = instruction_memory[current_pc];
                        `uvm_info("DRIVER", $sformatf("PC 0x%h found in transaction memory: 0x%h", current_pc, instruction), UVM_HIGH)
                        
                        cfg.driver_vif.instruction = instruction;
                        
                    end else if (memory_loaded) begin
                        instruction = 32'h00000013; // NOP instruction
                        `uvm_info("DRIVER", $sformatf("PC 0x%h not found in transaction memory, driving NOP", current_pc), UVM_MEDIUM)
                        cfg.driver_vif.instruction = instruction;
                    end else begin
                        instruction = 32'h00000013; // NOP instruction
                        `uvm_info("DRIVER", $sformatf("PC 0x%h - memory not loaded yet, driving NOP", current_pc), UVM_HIGH)
                        cfg.driver_vif.instruction = instruction;
                    end
                    
                end else begin
                    cfg.driver_vif.instruction = 32'h00000013;
                    `uvm_info("DRIVER", "Reset active, driving NOP", UVM_HIGH)
                end
            end
        join_none
    endtask

endclass