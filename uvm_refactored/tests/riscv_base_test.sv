// uvm_refactored/tests/riscv_base_test.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class riscv_base_test extends uvm_test;

    `uvm_component_utils(riscv_base_test)

    cpu_env env;
    uvm_event test_done_event;

    function new(string name = "riscv_base_test", uvm_component parent = null);
        super.new(name, parent);
        test_done_event = new("test_done_event");
    endfunction

    virtual function void build_phase(uvm_phase phase);
        string spike_log_path;
        super.build_phase(phase);
        
        env = cpu_env::type_id::create("env", this);

        // Get Spike log path from the command line plusargs
        if (!$value$plusargs("SPIKE_LOG=%s", spike_log_path))
            `uvm_fatal(get_type_name(), "SPIKE_LOG plusarg not provided")
        
        // Set file paths and event in the config DB for components to retrieve
        uvm_config_db#(string)::set(this, "env.scoreboard", "SPIKE_LOG", spike_log_path);
        uvm_config_db#(uvm_event)::set(this, "env.scoreboard", "test_done_event", test_done_event);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        // Set the verbosity for the scoreboard specifically to see MATCH messages.
        env.scoreboard.set_report_verbosity_level(UVM_HIGH);
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this, "Starting RISC-V Test");
        test_done_event.wait_on();
        #100ns; // Add a small delay for final transactions to settle
        phase.drop_objection(this, "Test finished (ECALL or Spike log end)");
    endtask

endclass 