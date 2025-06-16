`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////



module imm_gen(
    
    input wire [31:0] instruction, 
    
    output wire [31:0] IMM_value

    );
    
    
    wire [6:0] opcode;
    assign opcode = instruction[6:0];
    
    wire [31:0] stype_imm;
    wire [31:0] itype_imm;
    wire [31:0] btype_imm;
    wire [31:0] utype_imm;

    assign itype_imm = {{20{instruction[31]}},instruction[31:20]};
    assign stype_imm = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};
    // Correcting the B-type immediate construction according to the RISC-V spec.
    assign btype_imm = {{19{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
    
    // Added U-type for LUI and AUIPC
    assign utype_imm = {instruction[31:12], 12'h0};
    
    // Explicitly construct the 21-bit J-type immediate from the instruction's fields to fix a bug.
    wire [20:0] j_imm_val = {instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
    
    parameter J=7'b1101111, I1=7'b0000011, I2=7'b0010011, S=7'b0100011, B=7'b1100011, JALR=7'b1100111, LUI=7'b0110111, AUIPC=7'b0010111;
    
    
    assign IMM_value =  (opcode == J) ? {{11{j_imm_val[20]}}, j_imm_val} :
                        (opcode == B) ? btype_imm :
                        (opcode == S) ? stype_imm :
                        (opcode == LUI || opcode == AUIPC) ? utype_imm :
                        ((opcode == I1) || (opcode == I2) || (opcode == JALR)) ? itype_imm :
                        0;

    
endmodule
