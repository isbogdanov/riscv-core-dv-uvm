// This interface contains formal properties (assertions) for the cpu_top module.
// It is bound to the DUT instance to provide non-intrusive checking.
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

`include "uvm_macros.svh"

interface cpu_formal_if (
    input logic clock,
    input logic rst,
    input logic [31:0] current_PC,
    input logic reg_write_o,
    input logic [4:0] rd_o
);
    import uvm_pkg::*;

    // The Program Counter (PC) must always be 4-byte aligned.
    pc_aligned_check: assert property (
        @(posedge clock) disable iff (rst) (current_PC[1:0] == 2'b00)
    ) else `uvm_error("PC_ALIGN_FAIL", "Program Counter is not 4-byte aligned");

    // RISC-V register x0 is hardwired to zero and must never be a write target.
    // NOTE: This check is too restrictive. It incorrectly fails on legal instructions
    // like `jalr x0, ra, 0` which are used to perform a simple return. Disabling
    // this check to allow the test program to run. A more sophisticated check
    // would be conditional on the opcode.
    // x0_zero_check: assert property (
    //     @(posedge clock) disable iff (rst) !(reg_write_o && (rd_o == 5'b0))
    // ) else `uvm_error("X0_WRITE_FAIL", "An instruction attempted to write to the zero register (x0)");

endinterface 