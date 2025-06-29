// uvm_classic/transactions/riscv_commit_transaction.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class riscv_commit_transaction extends uvm_sequence_item;

    rand bit [31:0] pc;
    rand bit [31:0] instr;
    rand bit         gpr_write_enable;
    rand bit [4:0]  rd_addr;
    rand bit [31:0] rd_data;

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

    function bit do_compare (uvm_object rhs, uvm_comparer comparer);
        riscv_commit_transaction cast_rhs;
        
        if (!$cast(cast_rhs, rhs)) return 0;

        if (gpr_write_enable && cast_rhs.gpr_write_enable) begin
            return super.do_compare(rhs, comparer);
        end else begin
            return (pc == cast_rhs.pc) &&
                   (instr == cast_rhs.instr) &&
                   (gpr_write_enable == cast_rhs.gpr_write_enable);
        end
    endfunction

endclass 