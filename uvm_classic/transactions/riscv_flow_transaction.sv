// uvm_classic/transactions/riscv_flow_transaction.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class riscv_flow_transaction extends uvm_sequence_item;

    rand bit [31:0] current_pc;

    rand bit [31:0] next_pc;

    `uvm_object_utils_begin(riscv_flow_transaction)
        `uvm_field_int(current_pc, UVM_DEFAULT | UVM_COMPARE)
        `uvm_field_int(next_pc, UVM_DEFAULT | UVM_COMPARE)
    `uvm_object_utils_end

    function new(string name = "riscv_flow_transaction");
        super.new(name);
    endfunction

endclass