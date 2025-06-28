// uvm_refactored/predictors/cpu_flow_predictor.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Predicts the next program counter (PC) based on the current PC and instruction.
class cpu_flow_predictor extends uvm_component;
    `uvm_component_utils(cpu_flow_predictor)

    // Receives actual flow transactions from the flow monitor
    uvm_analysis_imp #(riscv_flow_transaction, cpu_flow_predictor) item_from_monitor_port;
    
    // Sends predicted flow transactions to the flow scoreboard
    uvm_analysis_port #(riscv_flow_transaction) predicted_item_port;

    // Internal "golden" instruction memory model
    logic [31:0] instr_mem[bit[31:0]];
    string mem_init_file;

    function new(string name = "cpu_flow_predictor", uvm_component parent = null);
        super.new(name, parent);
        item_from_monitor_port = new("item_from_monitor_port", this);
        predicted_item_port = new("predicted_item_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Get the memory initialization file path from the test
        if (!uvm_config_db#(string)::get(this, "", "MEM_FILE", mem_init_file)) begin
            `uvm_fatal(get_type_name(), "Memory init file not provided via config_db")
        end
    endfunction
    
    task automatic run_phase(uvm_phase phase);
        // Initialize the internal instruction memory model by reading the .mem file
        `uvm_info(get_type_name(), $sformatf("Loading instruction memory for predictor from file: %s", mem_init_file), UVM_MEDIUM)
        $readmemb(mem_init_file, instr_mem);
    endtask

    // This is the core prediction logic
    virtual function automatic void write(riscv_flow_transaction tx);
        riscv_flow_transaction predicted_tx;
        logic [31:0] current_instr;
        bit [31:0] word_addr;

        // Convert the byte-addressed PC to a word-address for our memory model
        word_addr = (tx.current_pc - 32'h80000000) >> 2;

        // Get the instruction at the current PC from our internal memory
        if (instr_mem.exists(word_addr)) begin
            current_instr = instr_mem[word_addr];
        end else begin
            `uvm_warning("PREDICTOR", $sformatf("PC 0x%h (Word Addr: 0x%h) not found in predictor's memory.", tx.current_pc, word_addr))
            return; // Cannot predict if we don't know the instruction
        end
        
        predicted_tx = riscv_flow_transaction::type_id::create("predicted_tx");
        predicted_tx.current_pc = tx.current_pc;

        // ** Basic Prediction Logic (To be expanded later) **
        // For now, assume all instructions are sequential.
        // TODO: Add logic to decode JAL, JALR, and BRANCH instructions.
        predicted_tx.next_pc = tx.current_pc + 4;
            
        `uvm_info(get_type_name(), $sformatf("Predicted FLOW tx: %s", predicted_tx.sprint()), UVM_HIGH)
        predicted_item_port.write(predicted_tx);

    endfunction

endclass 