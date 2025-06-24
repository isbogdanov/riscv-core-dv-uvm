// uvm_refactored/transactions/riscv_commit_transaction.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class riscv_commit_transaction extends uvm_sequence_item;

    // Declare properties first
    rand bit [31:0] pc;
    rand bit [31:0] instr;
    rand bit         gpr_write_enable;
    rand bit [4:0]  rd_addr;
    rand bit [31:0] rd_data;

    // Then, register them with the factory
    `uvm_object_utils_begin(riscv_commit_transaction)
        `uvm_field_int(pc, UVM_DEFAULT | UVM_COMPARE)
        `uvm_field_int(instr, UVM_DEFAULT | UVM_COMPARE)
        `uvm_field_int(gpr_write_enable, UVM_DEFAULT | UVM_COMPARE)
        `uvm_field_int(rd_addr, UVM_DEFAULT | UVM_COMPARE)
        `uvm_field_int(rd_data, UVM_DEFAULT | UVM_COMPARE)
    `uvm_object_utils_end

    function new(string name = "riscv_commit_transaction");
        super.new(name);
    endfunction

    // Custom function to model the Spike log's behavior where
    // rd_addr and rd_data are only valid if a GPR write occurs.
    function bit do_compare (uvm_object rhs, uvm_comparer comparer);
        riscv_commit_transaction cast_rhs;
        
        if (!$cast(cast_rhs, rhs)) return 0;

        // Only compare register data if a write actually happened in both transactions.
        if (gpr_write_enable && cast_rhs.gpr_write_enable) begin
            return super.do_compare(rhs, comparer);
        end else begin
            // If one or both didn't have a GPR write, just compare the other fields.
            return (pc == cast_rhs.pc) &&
                   (instr == cast_rhs.instr) &&
                   (gpr_write_enable == cast_rhs.gpr_write_enable);
        end
    endfunction

endclass 