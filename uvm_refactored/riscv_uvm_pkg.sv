// uvm_refactored/riscv_uvm_pkg.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

package riscv_uvm_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Configuration
    `include "config/riscv_dut_config.sv"

    // Transactions
    `include "transactions/riscv_commit_transaction.sv"
    `include "transactions/riscv_flow_transaction.sv"

    // Monitors
    `include "monitors/cpu_commit_monitor.sv"
    `include "monitors/cpu_flow_monitor.sv"

    // Predictor
    `include "predictors/cpu_flow_predictor.sv"
    
    // Scoreboards
    `include "subscribers/cpu_commit_scoreboard.sv"
    `include "subscribers/cpu_flow_scoreboard.sv"
    
    // Agents
    `include "agents/cpu_commit_agent.sv"
    `include "agents/cpu_flow_agent.sv"
    
    // Environment and Test
    `include "env/cpu_env.sv"
    `include "tests/riscv_base_test.sv"

endpackage 