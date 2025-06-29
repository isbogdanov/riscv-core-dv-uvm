// uvm_classic/agents/cpu_flow_agent.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class cpu_flow_agent extends uvm_agent;
    `uvm_component_utils(cpu_flow_agent)

    riscv_dut_config cfg;

    cpu_flow_monitor monitor;
    cpu_instruction_driver driver;
    cpu_instruction_sequencer sequencer;

    uvm_analysis_port#(riscv_flow_transaction) ap;

    function new(string name = "cpu_flow_agent", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(riscv_dut_config)::get(this, "", "cfg", cfg))
            `uvm_fatal("AGENT", "Failed to get configuration object")
        
        monitor = cpu_flow_monitor::type_id::create("monitor", this);
        
        `uvm_info("AGENT", "cpu_flow_agent is ACTIVE", UVM_MEDIUM);
        driver = cpu_instruction_driver::type_id::create("driver", this);
        sequencer = cpu_instruction_sequencer::type_id::create("sequencer", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        monitor.item_collected_port.connect(this.ap);

        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

endclass