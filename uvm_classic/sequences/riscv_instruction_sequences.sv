// uvm_classic/sequences/riscv_instruction_sequences.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Memory-file sequence that reads the entire memory file and sends each instruction as a transaction
// This demonstrates proper UVM sequence-to-driver communication
class riscv_memory_file_sequence extends uvm_sequence#(riscv_instruction_transaction);
    `uvm_object_utils(riscv_memory_file_sequence)

    // Configuration
    string memory_file_path;
    logic [31:0] memory_data[0:16383]; // 16K instruction memory
    int num_instructions;

    function new(string name = "riscv_memory_file_sequence");
        super.new(name);
    endfunction

    virtual task body();
        riscv_instruction_transaction txn;
        
        `uvm_info(get_type_name(), $sformatf("Loading memory file: %s", memory_file_path), UVM_MEDIUM)
        
        if (memory_file_path == "") begin
            `uvm_fatal(get_type_name(), "Memory file path not set")
        end
        
        $readmemb(memory_file_path, memory_data);
        
        num_instructions = 0;
        for (int i = 16383; i >= 0; i--) begin
            if (memory_data[i] != 0) begin
                num_instructions = i + 1;
                break;
            end
        end
        
        `uvm_info(get_type_name(), $sformatf("Found %0d instructions in memory file", num_instructions), UVM_MEDIUM)
        
        for (int i = 0; i < num_instructions; i++) begin
            txn = riscv_instruction_transaction::create_from_memory_line(i, memory_data[i]);
            
            start_item(txn);
            finish_item(txn);
            
            `uvm_info(get_type_name(), $sformatf("Sent instruction %0d: PC=0x%h, INSTR=0x%h", 
                                                i, txn.pc_address, txn.instruction), UVM_HIGH)
        end
        
        `uvm_info(get_type_name(), "Memory file sequence completed", UVM_MEDIUM)
    endtask
endclass

// Base sequence for the instruction driver.
// This sequence allows the driver to run without sending sequence items,
// which is appropriate for our memory-file-driven approach.
class riscv_driving_base_sequence extends uvm_sequence#(riscv_instruction_transaction);
    `uvm_object_utils(riscv_driving_base_sequence)

    function new(string name = "riscv_driving_base_sequence");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), "Base sequence started - driver will operate autonomously", UVM_MEDIUM)
        
        #1us;
        
        `uvm_info(get_type_name(), "Base sequence completed", UVM_MEDIUM)
    endtask
endclass

// Advanced sequence that demonstrates sequence item generation and control
class riscv_instruction_stall_sequence extends uvm_sequence#(riscv_instruction_transaction);
    `uvm_object_utils(riscv_instruction_stall_sequence)

    // Sequence parameters
    rand int num_stalls;
    rand int stall_duration;
    
    constraint c_stalls {
        num_stalls inside {[1:5]};
        stall_duration inside {[1:10]};
    }

    function new(string name = "riscv_instruction_stall_sequence");
        super.new(name);
    endfunction

    virtual task body();
        riscv_instruction_transaction item;
        
        `uvm_info(get_type_name(), $sformatf("Stall sequence started - %0d stalls of %0d cycles each", 
                                            num_stalls, stall_duration), UVM_MEDIUM)
        
        for (int i = 0; i < num_stalls; i++) begin
            item = riscv_instruction_transaction::type_id::create("stall_item");
            
            start_item(item);
            
            if (!item.randomize() with { 
                instruction_delay == stall_duration;
                instr_type == riscv_instruction_transaction::STALL_INSTR;
            }) begin
                `uvm_error(get_type_name(), "Failed to randomize stall item")
            end
            
            `uvm_info(get_type_name(), $sformatf("Sending stall item %0d with delay %0d", 
                                                i+1, item.instruction_delay), UVM_HIGH)
            
            finish_item(item);
            
            #(10ns);
        end
        
        `uvm_info(get_type_name(), "Stall sequence completed", UVM_MEDIUM)
    endtask
endclass

// Performance-oriented sequence for rapid instruction delivery testing
class riscv_burst_sequence extends uvm_sequence#(riscv_instruction_transaction);
    `uvm_object_utils(riscv_burst_sequence)

    rand int burst_length;
    
    constraint c_burst {
        burst_length inside {[10:50]};
    }

    function new(string name = "riscv_burst_sequence");
        super.new(name);
    endfunction

    virtual task body();
        riscv_instruction_transaction item;
        
        `uvm_info(get_type_name(), $sformatf("Burst sequence started - %0d rapid transactions", 
                                            burst_length), UVM_MEDIUM)
        
        for (int i = 0; i < burst_length; i++) begin
            item = riscv_instruction_transaction::type_id::create($sformatf("burst_item_%0d", i));
            
            start_item(item);
            
            if (!item.randomize() with { 
                instruction_delay == 0;
                instr_type == riscv_instruction_transaction::BURST_INSTR;
            }) begin
                `uvm_error(get_type_name(), "Failed to randomize burst item")
            end
            
            finish_item(item);
            
        end
        
        `uvm_info(get_type_name(), "Burst sequence completed", UVM_MEDIUM)
    endtask
endclass 