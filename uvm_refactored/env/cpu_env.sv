// uvm_refactored/env/cpu_env.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class cpu_env extends uvm_env;

    `uvm_component_utils(cpu_env)

    cpu_agent agent;
    cpu_scoreboard scoreboard;
    
    // Standard UVM component for synchronized communication
    uvm_tlm_analysis_fifo#(riscv_commit_transaction) checker_fifo;

    function new(string name = "cpu_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Create components - no memory model or driver needed
        agent = cpu_agent::type_id::create("agent", this);
        scoreboard = cpu_scoreboard::type_id::create("scoreboard", this);
        checker_fifo = new("checker_fifo", this);

        // Pass the FIFO handle to the scoreboard
        uvm_config_db#(uvm_tlm_analysis_fifo#(riscv_commit_transaction))::set(this, 
            "scoreboard", "checker_fifo", checker_fifo);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // Connect the monitor's output to the FIFO's input
        agent.ap.connect(checker_fifo.analysis_export);
    endfunction

endclass 