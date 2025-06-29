// uvm_classic/riscv_uvm_pkg.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

package riscv_uvm_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"


    `include "config/riscv_dut_config.sv"

    `include "transactions/riscv_commit_transaction.sv"
    `include "transactions/riscv_flow_transaction.sv"
    `include "transactions/riscv_instruction_transaction.sv"

    `include "sequencers/cpu_instruction_sequencer.sv"

    `include "sequences/riscv_instruction_sequences.sv"

    `include "drivers/cpu_instruction_driver.sv"

    `include "monitors/cpu_commit_monitor.sv"
    `include "monitors/cpu_flow_monitor.sv"

    `include "predictors/cpu_flow_predictor.sv"
    
    `include "subscribers/cpu_commit_scoreboard.sv"
    `include "subscribers/cpu_flow_scoreboard.sv"
    
    `include "agents/cpu_commit_agent.sv"
    `include "agents/cpu_flow_agent.sv"
    
    `include "cpu_env.sv"
    `include "tests/riscv_base_test.sv"

endpackage 