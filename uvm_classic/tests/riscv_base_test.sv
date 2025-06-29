// uvm_classic/tests/riscv_base_test.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class riscv_base_test extends uvm_test;

    `uvm_component_utils(riscv_base_test)

    cpu_env env;
    riscv_dut_config cfg;
    uvm_event test_done_event;

    function new(string name = "riscv_base_test", uvm_component parent = null);
        super.new(name, parent);
        test_done_event = new("test_done_event");
    endfunction

    virtual function void build_phase(uvm_phase phase);
        string spike_log_path;
        string mem_file_path;
        super.build_phase(phase);
        
        cfg = riscv_dut_config::type_id::create("cfg");
        `uvm_info("TEST", "Configuration object created successfully", UVM_MEDIUM)
        
        env = cpu_env::type_id::create("env", this);

        if (!$value$plusargs("SPIKE_LOG=%s", spike_log_path))
            `uvm_fatal(get_type_name(), "SPIKE_LOG plusarg not provided")
        
        if (!$value$plusargs("MEM_FILE=%s", mem_file_path))
            `uvm_fatal(get_type_name(), "MEM_FILE plusarg not provided")

        cfg.spike_log_path = spike_log_path;
        cfg.mem_file_path = mem_file_path;
        `uvm_info("TEST", "Configuration paths set successfully", UVM_MEDIUM)
        
        if (!uvm_config_db#(virtual cpu_interface.monitor_mp)::get(this, "*", "monitor_vif", cfg.monitor_vif))
            `uvm_fatal(get_type_name(), "Monitor virtual interface not found in config DB")
        if(!uvm_config_db#(virtual cpu_interface.driver_mp)::get(this, "*", "driver_vif", cfg.driver_vif))
            `uvm_fatal(get_type_name(), "Driver virtual interface not found in config DB")
        `uvm_info("TEST", "Virtual interfaces retrieved and assigned to config", UVM_MEDIUM)

        if (!cfg.is_valid()) begin
            `uvm_fatal(get_type_name(), "Invalid DUT configuration")
        end else begin
            `uvm_info("TEST", "Configuration object validated successfully", UVM_MEDIUM)
        end
        
        uvm_config_db#(riscv_dut_config)::set(this, "env*", "cfg", cfg);
        `uvm_info("TEST", "Configuration object distributed to environment components", UVM_MEDIUM)
        
        cfg.print_config();
        
        // Backwards compatibility
        uvm_config_db#(string)::set(this, "env.commit_scoreboard", "SPIKE_LOG", spike_log_path);
        uvm_config_db#(string)::set(this, "env.flow_predictor", "MEM_FILE", mem_file_path);
        uvm_config_db#(uvm_event)::set(this, "env.commit_scoreboard", "test_done_event", test_done_event);
        uvm_config_db#(uvm_event)::set(this, "env.flow_scoreboard", "test_done_event", test_done_event);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        env.commit_scoreboard.set_report_verbosity_level(UVM_HIGH);
        env.flow_scoreboard.set_report_verbosity_level(UVM_HIGH);
    endfunction

    virtual task run_phase(uvm_phase phase);
        riscv_memory_file_sequence memory_seq;

        phase.raise_objection(this, "Starting RISC-V Test");
        
        memory_seq = riscv_memory_file_sequence::type_id::create("memory_seq");
        memory_seq.memory_file_path = cfg.mem_file_path;
        
        `uvm_info("TEST", $sformatf("Starting memory file sequence with file: %s", cfg.mem_file_path), UVM_MEDIUM)
        
        memory_seq.start(env.flow_agent.sequencer);
        
        `uvm_info("TEST", "Memory file sequence completed, waiting for test completion", UVM_MEDIUM)

        test_done_event.wait_on();
        #100ns;
        phase.drop_objection(this, "Test finished (ECALL or Spike log end)");
    endtask

endclass 