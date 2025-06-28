// uvm_refactored/agents/cpu_agent.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Passive-only agent for monitoring processor commit stage
// No driver or sequencer - stimulus comes from pre-loaded programs
class cpu_agent extends uvm_agent;

    `uvm_component_utils(cpu_agent)

    cpu_monitor monitor;

    uvm_analysis_port#(riscv_commit_transaction) ap;

    function new(string name = "cpu_agent", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor = cpu_monitor::type_id::create("monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        monitor.item_collected_port.connect(this.ap);
    endfunction

endclass 