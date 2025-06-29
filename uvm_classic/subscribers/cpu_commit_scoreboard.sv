// uvm_classic/subscribers/cpu_commit_scoreboard.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class cpu_commit_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(cpu_commit_scoreboard)

    uvm_tlm_analysis_fifo#(riscv_commit_transaction) checker_fifo;
    
    string spike_log_path;
    integer spike_log_fh;
    uvm_event test_done_event;
    bit ecall_detected = 0;

    function new(string name = "cpu_commit_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(string)::get(this, "", "SPIKE_LOG", spike_log_path))
           `uvm_fatal(get_type_name(), "Could not get SPIKE_LOG path");
        if(!uvm_config_db#(uvm_event)::get(this, "", "test_done_event", test_done_event))
           `uvm_fatal(get_type_name(), "Could not get test_done_event");
        if(!uvm_config_db#(uvm_tlm_analysis_fifo#(riscv_commit_transaction))::get(this, 
            "", "checker_fifo", checker_fifo))
           `uvm_fatal(get_type_name(), "Could not get checker_fifo handle");
    endfunction

    task run_phase(uvm_phase phase);
        riscv_commit_transaction actual_tx;
        
        forever begin
            checker_fifo.get(actual_tx);
            if (ecall_detected) begin
                `uvm_info(get_type_name(), "ECALL already detected, ignoring remaining transactions", UVM_HIGH);
                continue;
            end
            check_transaction(actual_tx);
        end
    endtask

    riscv_commit_transaction expected_q[$];
    
    task get_next_expected();
        string spike_line;
        
        if (expected_q.size() > 0) return;

        while(expected_q.size() == 0) begin
            if ($feof(spike_log_fh)) begin
                `uvm_info(get_type_name(), "End of Spike log reached.", UVM_MEDIUM)
                test_done_event.trigger();
                return;
            end
            void'($fgets(spike_line, spike_log_fh));
            process_spike_line(spike_line);
        end
    endtask

    function void process_spike_line(string spike_line);
        int match_count;
        riscv_commit_transaction expected_tx;
        bit [31:0] pc_exp, instr_exp, rd_data_exp;
        bit [4:0]  rd_addr_exp;
        bit gpr_write_enable_exp;

        match_count = $sscanf(spike_line, "core   0: 3 0x%h (0x%h) x%d 0x%h", 
                              pc_exp, instr_exp, rd_addr_exp, rd_data_exp);

        if (match_count == 4) begin
            gpr_write_enable_exp = 1;
        end else begin
            match_count = $sscanf(spike_line, "core   0: 3 0x%h (0x%h)", pc_exp, instr_exp);
            if (match_count == 2) begin
                gpr_write_enable_exp = 0;
            end else begin
                `uvm_info(get_type_name(), $sformatf("Ignoring non-commit Spike log line: %s", spike_line), UVM_HIGH);
                return;
            end
        end

        expected_tx = riscv_commit_transaction::type_id::create("expected_tx");
        expected_tx.pc = pc_exp;
        expected_tx.instr = instr_exp;
        expected_tx.gpr_write_enable = gpr_write_enable_exp;

        if (gpr_write_enable_exp) begin
            expected_tx.rd_addr = rd_addr_exp;
            expected_tx.rd_data = rd_data_exp;
        end
        
        expected_q.push_back(expected_tx);
    endfunction

    task check_transaction(riscv_commit_transaction actual_tx);
        riscv_commit_transaction expected_tx;

        if (actual_tx.instr == 32'h00000073) begin
            `uvm_info(get_type_name(), $sformatf("ECALL detected at PC 0x%h - stopping comparison", actual_tx.pc), UVM_MEDIUM);
            ecall_detected = 1;
            test_done_event.trigger();
            return;
        end

        get_next_expected();
        
        if (expected_q.size() == 0) begin
            `uvm_error(get_type_name(), "Ran out of expected transactions from Spike log!");
            return;
        end
        
        expected_tx = expected_q.pop_front();

        if (!actual_tx.compare(expected_tx)) begin
            `uvm_error(get_type_name(), $sformatf("SCOREBOARD MISMATCH!\\nExpected: %s\\nActual:   %s", 
                       expected_tx.sprint(), actual_tx.sprint()));
        end else begin
            `uvm_info(get_type_name(), $sformatf("PC 0x%h MATCH", actual_tx.pc), UVM_HIGH);
        end
    endtask

    function void start_of_simulation_phase(uvm_phase phase);
        spike_log_fh = $fopen(spike_log_path, "r");
        if (spike_log_fh == 0) begin
            `uvm_fatal(get_type_name(), $sformatf("Could not open Spike log: %s", spike_log_path))
        end
        
        begin
            string line;
            int pc;
            int count;
            do begin
                void'($fgets(line, spike_log_fh));
                count = $sscanf(line, "core   0: 3 0x%h", pc);
            end while(pc != 32'h80000000 && !$feof(spike_log_fh));

            if ($feof(spike_log_fh)) begin
                `uvm_fatal(get_type_name(), "Did not find PC=0x80000000 in Spike log.")
            end

            process_spike_line(line);
        end
    endfunction

endclass