// uvm_classic/env/cpu_env.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class cpu_env extends uvm_env;

    `uvm_component_utils(cpu_env)

    riscv_dut_config cfg;

    cpu_commit_agent commit_agent;
    cpu_commit_scoreboard commit_scoreboard;
    uvm_tlm_analysis_fifo#(riscv_commit_transaction) commit_fifo;

    cpu_flow_agent flow_agent;
    uvm_analysis_port #(riscv_flow_transaction) flow_ap_broadcaster;
    cpu_flow_predictor flow_predictor;
    cpu_flow_scoreboard flow_scoreboard;

    function new(string name = "cpu_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        if (!uvm_config_db#(riscv_dut_config)::get(this, "", "cfg", cfg)) begin
            `uvm_info("ENV", "No configuration object found, using defaults", UVM_LOW)
            cfg = riscv_dut_config::type_id::create("cfg");
        end else begin
            `uvm_info("ENV", "Configuration object received successfully", UVM_MEDIUM)
            `uvm_info("ENV", $sformatf("  Spike log path: %s", cfg.spike_log_path), UVM_MEDIUM)
        end
        
        uvm_config_db#(riscv_dut_config)::set(this, "*_agent", "cfg", cfg);
        
        commit_agent = cpu_commit_agent::type_id::create("commit_agent", this);
        commit_scoreboard = cpu_commit_scoreboard::type_id::create("commit_scoreboard", this);
        commit_fifo = new("commit_fifo", this);
        uvm_config_db#(uvm_tlm_analysis_fifo#(riscv_commit_transaction))::set(this, 
            "commit_scoreboard", "checker_fifo", commit_fifo);

        flow_agent = cpu_flow_agent::type_id::create("flow_agent", this);
        flow_ap_broadcaster = new("flow_ap_broadcaster", this);
        flow_predictor = cpu_flow_predictor::type_id::create("flow_predictor", this);
        flow_scoreboard = cpu_flow_scoreboard::type_id::create("flow_scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        commit_agent.ap.connect(commit_fifo.analysis_export);
        
        flow_agent.ap.connect(flow_ap_broadcaster);
        
        flow_ap_broadcaster.connect(flow_predictor.item_from_monitor_port);
        flow_ap_broadcaster.connect(flow_scoreboard.actual_export);
        
        flow_predictor.predicted_item_port.connect(flow_scoreboard.expected_export);
    endfunction

endclass 