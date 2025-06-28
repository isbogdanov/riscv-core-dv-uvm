// uvm_refactored/agents/cpu_flow_agent.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Passive agent for monitoring the processor's program flow.
class cpu_flow_agent extends uvm_agent;

    `uvm_component_utils(cpu_flow_agent)

    // This agent only contains a monitor, as it's purely passive.
    cpu_flow_monitor monitor;

    // Analysis port to broadcast flow transactions to the environment
    uvm_analysis_port#(riscv_flow_transaction) ap;

    function new(string name = "cpu_flow_agent", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // The is_active flag is set by the instantiating environment.
        if (is_active == UVM_PASSIVE) begin
            monitor = cpu_flow_monitor::type_id::create("monitor", this);
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_PASSIVE) begin
            monitor.item_collected_port.connect(this.ap);
        end
    endfunction

endclass 