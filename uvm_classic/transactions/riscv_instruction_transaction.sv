// uvm_classic/transactions/riscv_instruction_transaction.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class riscv_instruction_transaction extends uvm_sequence_item;

    rand logic [31:0] pc_address;
    
    rand logic [31:0] instruction;
    
    rand int unsigned instruction_delay;
    
    typedef enum {
        NORMAL_INSTR,
        STALL_INSTR, 
        BURST_INSTR,
        NOP_INSTR
    } instruction_type_e;
    
    rand instruction_type_e instr_type;

    `uvm_object_utils_begin(riscv_instruction_transaction)
        `uvm_field_int(pc_address, UVM_ALL_ON)
        `uvm_field_int(instruction, UVM_ALL_ON)
        `uvm_field_int(instruction_delay, UVM_ALL_ON)
        `uvm_field_enum(instruction_type_e, instr_type, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "riscv_instruction_transaction");
        super.new(name);
    endfunction

    constraint c_delay {
        instruction_delay inside {[0:10]};
    }
    
    constraint c_pc_alignment {
        pc_address[1:0] == 2'b00; // PC must be word-aligned
    }
    
    constraint c_instruction_type {
        instr_type dist {
            NORMAL_INSTR := 90,
            STALL_INSTR  := 5,
            BURST_INSTR  := 4,
            NOP_INSTR    := 1
        };
    }

    static function riscv_instruction_transaction create_from_memory_line(
        int line_number, 
        logic [31:0] instruction_data
    );
        riscv_instruction_transaction txn;
        txn = riscv_instruction_transaction::type_id::create($sformatf("mem_line_%0d", line_number));
        txn.pc_address = 32'h80000000 + (line_number * 4);
        txn.instruction = instruction_data;
        txn.instr_type = NORMAL_INSTR;
        txn.instruction_delay = 0;
        return txn;
    endfunction

endclass