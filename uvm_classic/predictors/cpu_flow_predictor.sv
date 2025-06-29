// uvm_classic/predictors/cpu_flow_predictor.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class cpu_flow_predictor extends uvm_component;
    `uvm_component_utils(cpu_flow_predictor)

    uvm_analysis_imp #(riscv_flow_transaction, cpu_flow_predictor) item_from_monitor_port;
    
    uvm_analysis_port #(riscv_flow_transaction) predicted_item_port;

    logic [31:0] instr_mem[bit[31:0]];
    string mem_init_file;

    function new(string name = "cpu_flow_predictor", uvm_component parent = null);
        super.new(name, parent);
        item_from_monitor_port = new("item_from_monitor_port", this);
        predicted_item_port = new("predicted_item_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(string)::get(this, "", "MEM_FILE", mem_init_file)) begin
            `uvm_fatal(get_type_name(), "Memory init file not provided via config_db")
        end
    endfunction
    
    task automatic run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Loading instruction memory for predictor from file: %s", mem_init_file), UVM_MEDIUM)
        $readmemb(mem_init_file, instr_mem);
    endtask

    virtual function automatic void write(riscv_flow_transaction tx);
        riscv_flow_transaction predicted_tx;
        logic [31:0] current_instr;
        bit [31:0] word_addr;

        word_addr = (tx.current_pc - 32'h80000000) >> 2;

        if (instr_mem.exists(word_addr)) begin
            current_instr = instr_mem[word_addr];
        end else begin
            `uvm_warning("PREDICTOR", $sformatf("PC 0x%h (Word Addr: 0x%h) not found in predictor's memory.", tx.current_pc, word_addr))
            return;
        end
        
        predicted_tx = riscv_flow_transaction::type_id::create("predicted_tx");
        predicted_tx.current_pc = tx.current_pc;

        predicted_tx.next_pc = tx.current_pc + 4;
            
        `uvm_info(get_type_name(), $sformatf("Predicted FLOW tx: %s", predicted_tx.sprint()), UVM_HIGH)
        predicted_item_port.write(predicted_tx);

    endfunction

endclass