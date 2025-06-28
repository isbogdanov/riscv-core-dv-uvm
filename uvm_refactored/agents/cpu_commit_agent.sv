// uvm_refactored/agents/cpu_commit_agent.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Passive-only agent for monitoring processor commit stage
// No driver or sequencer - stimulus comes from pre-loaded programs
class cpu_commit_agent extends uvm_agent;

    `uvm_component_utils(cpu_commit_agent)

    cpu_commit_monitor monitor;
    riscv_dut_config cfg;

    uvm_analysis_port#(riscv_commit_transaction) ap;

    function new(string name = "cpu_commit_agent", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Get configuration object (backwards compatible - optional)
        if (!uvm_config_db#(riscv_dut_config)::get(this, "", "cfg", cfg)) begin
            `uvm_info("AGENT", "No configuration object found, using defaults", UVM_LOW)
            cfg = riscv_dut_config::type_id::create("cfg");
        end else begin
            `uvm_info("AGENT", "Configuration object received in cpu_commit_agent", UVM_MEDIUM)
            `uvm_info("AGENT", $sformatf("  Agent mode: %s", cfg.is_active.name()), UVM_MEDIUM)
            `uvm_info("AGENT", $sformatf("  Enable commit checking: %0b", cfg.enable_commit_checking), UVM_MEDIUM)
        end
        
        // Pass configuration to monitor
        uvm_config_db#(riscv_dut_config)::set(this, "monitor", "cfg", cfg);
        
        monitor = cpu_commit_monitor::type_id::create("monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        monitor.item_collected_port.connect(this.ap);
    endfunction

endclass 