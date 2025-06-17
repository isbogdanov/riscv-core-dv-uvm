`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module ALU_controller(
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire [1:0] ALU_op,
    output reg [3:0] ALU_opcode
    );

    // Opcodes expanded to 4 bits to match ALU
    parameter ALU_ADD = 4'b0001;
    parameter ALU_SUB = 4'b0010;
    parameter ALU_AND = 4'b0011;
    parameter ALU_OR  = 4'b0100;
    parameter ALU_SLL = 4'b0101;
    parameter ALU_SRL = 4'b0110;
    parameter ALU_XOR = 4'b0111;
    parameter ALU_SLT = 4'b0000;
    parameter ALU_SRA = 4'b1010; // New unique opcode
    parameter ALU_SLTU= 4'b1011; // New opcode for unsigned comparison

    always @* begin
        case (ALU_op)
            // R-type or I-type (immediate arithmetic)
            2'b10: begin
                case (funct3)
                    3'b000: // ADD or SUB
                        if (funct7 == 7'b0100000) ALU_opcode = ALU_SUB;
                        else ALU_opcode = ALU_ADD;
                    3'b001: // SLL / SLLI
                        ALU_opcode = ALU_SLL;
                    3'b010: // SLT / SLTI
                        ALU_opcode = ALU_SLT;
                    3'b011: // SLTU / SLTIU
                        ALU_opcode = ALU_SLTU; // Correctly map to SLTU
                    3'b100: // XOR / XORI
                        ALU_opcode = ALU_XOR;
                    3'b101: // SRL, SRA, SRLI, SRAI
                        if (funct7 == 7'b0100000) ALU_opcode = ALU_SRA; // SRA or SRAI
                        else ALU_opcode = ALU_SRL;                     // SRL or SRLI
                    3'b110: // OR / ORI
                        ALU_opcode = ALU_OR;
                    3'b111: // AND / ANDI
                        ALU_opcode = ALU_AND;
                    default: ALU_opcode = 4'b0000; // Default to no-op
                endcase
            end
            // Branch (BEQ, BNE etc.) -> Needs subtraction for comparison
            2'b01: begin
                ALU_opcode = ALU_SUB;
            end
            // Load/Store/JALR -> Needs addition for address calculation
            2'b00: begin
                ALU_opcode = ALU_ADD;
            end
            default: ALU_opcode = 4'b0000; // Default to no-op
        endcase
    end
endmodule
