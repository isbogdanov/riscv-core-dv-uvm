`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////



module imm_gen(
    
    input wire [31:0] instruction, 
    
    output reg [31:0] IMM_value

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
    
    // Define opcodes for clarity
    parameter J=7'b1101111;
    parameter I_LOAD=7'b0000011;
    parameter I_ARITH=7'b0010011;
    // Added I_ARITH_SHIFT for immediate shifts
    parameter I_ARITH_SHIFT=7'b0010011; 
    parameter S=7'b0100011;
    parameter B=7'b1100011;
    parameter JALR=7'b1100111;
    parameter LUI=7'b0110111;
    parameter AUIPC=7'b0010111;

    // Use a case statement for clarity and to ensure correct immediate selection.
    // This fixes the bug where ADDI was using the wrong immediate format.
    always @* begin
        case (opcode)
            J:       IMM_value = {{11{j_imm_val[20]}}, j_imm_val};
            B:       IMM_value = btype_imm;
            S:       IMM_value = stype_imm;
            LUI:     IMM_value = utype_imm;
            AUIPC:   IMM_value = utype_imm;
            // Differentiate between I-type arithmetic and shifts
            I_ARITH: begin
                if (instruction[14:12] == 3'b001 || instruction[14:12] == 3'b101) begin // SLLI, SRLI, SRAI
                    IMM_value = {{27{1'b0}}, instruction[24:20]}; // 5-bit shamt
                end else begin
                    IMM_value = itype_imm; // Other I-type (ADDI, etc.)
                end
            end
            I_LOAD:  IMM_value = itype_imm; // Correct for LW
            JALR:    IMM_value = itype_imm; // Correct for JALR
            default: IMM_value = 32'b0;
        endcase
    end

endmodule
