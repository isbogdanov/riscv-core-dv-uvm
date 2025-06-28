// uvm_refactored/riscv_uvm_pkg.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

package riscv_uvm_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Include UVM component files (passive monitoring only)
    `include "transactions/riscv_commit_transaction.sv"
    `include "monitors/cpu_monitor.sv"
    `include "subscribers/cpu_scoreboard.sv"
    `include "agents/cpu_agent.sv"
    `include "env/cpu_env.sv"
    `include "tests/riscv_base_test.sv"

endpackage 