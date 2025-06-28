// uvm_refactored/transactions/riscv_flow_transaction.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Represents a change in the program flow, captured by the flow monitor.
// This is used to verify that the processor's branches, jumps, and
// sequential instruction fetching are all working correctly.
class riscv_flow_transaction extends uvm_sequence_item;

    // The Program Counter for the current instruction.
    rand bit [31:0] current_pc;

    // The Program Counter for the next instruction.
    rand bit [31:0] next_pc;

    `uvm_object_utils_begin(riscv_flow_transaction)
        `uvm_field_int(current_pc, UVM_DEFAULT | UVM_COMPARE)
        `uvm_field_int(next_pc, UVM_DEFAULT | UVM_COMPARE)
    `uvm_object_utils_end

    function new(string name = "riscv_flow_transaction");
        super.new(name);
    endfunction

endclass 