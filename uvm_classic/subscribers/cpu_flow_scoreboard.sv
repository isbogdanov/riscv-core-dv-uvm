// uvm_classic/subscribers/cpu_flow_scoreboard.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Compares actual program flow transactions from the monitor against
// predicted transactions from the flow predictor.
class cpu_flow_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(cpu_flow_scoreboard)

    `uvm_analysis_imp_decl(_expected)
    `uvm_analysis_imp_decl(_actual)

    uvm_analysis_imp_expected #(riscv_flow_transaction, cpu_flow_scoreboard) expected_export;
    uvm_analysis_imp_actual   #(riscv_flow_transaction, cpu_flow_scoreboard) actual_export;

    uvm_tlm_analysis_fifo #(riscv_flow_transaction) expected_fifo;
    uvm_tlm_analysis_fifo #(riscv_flow_transaction) actual_fifo;

    uvm_event test_done_event;
    bit ecall_detected = 0;

    function new(string name = "cpu_flow_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        expected_export = new("expected_export", this);
        actual_export   = new("actual_export", this);
        expected_fifo = new("expected_fifo", this);
        actual_fifo   = new("actual_fifo", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(uvm_event)::get(this, "", "test_done_event", test_done_event))
           `uvm_fatal(get_type_name(), "Could not get test_done_event");
    endfunction

    function void write_expected(riscv_flow_transaction t);
        expected_fifo.write(t);
    endfunction

    function void write_actual(riscv_flow_transaction t);
        actual_fifo.write(t);
    endfunction

    virtual task automatic run_phase(uvm_phase phase);
        riscv_flow_transaction expected_tx;
        riscv_flow_transaction actual_tx;

        fork
            begin
                test_done_event.wait_on();
                ecall_detected = 1;
            end
        join_none

        forever begin
            actual_fifo.get(actual_tx);

            if (ecall_detected) begin
                `uvm_info(get_type_name(), "Test is done, ignoring remaining flow transactions.", UVM_HIGH)
                continue;
            end

            expected_fifo.get(expected_tx);

            if (!actual_tx.compare(expected_tx)) begin
                `uvm_error("FLOW_SCOREBOARD_MISMATCH", $sformatf("Program flow mismatch!\\nExpected: %s\\nActual:   %s", 
                           expected_tx.sprint(), actual_tx.sprint()));
            end else begin
                `uvm_info(get_type_name(), $sformatf("Program Flow MATCH for PC 0x%h", actual_tx.current_pc), UVM_HIGH);
            end
        end
    endtask

endclass 