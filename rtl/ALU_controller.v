`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module ALU_controller(
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire [1:0] ALU_op,
    output reg [2:0] ALU_opcode
    );

    // Internal ALU operation codes
    parameter ALU_ADD = 3'b001;
    parameter ALU_SUB = 3'b010;
    parameter ALU_AND = 3'b011;
    parameter ALU_OR  = 3'b100;
    parameter ALU_SLL = 3'b101;
    parameter ALU_SRL = 3'b110;
    parameter ALU_XOR = 3'b111; 
    parameter ALU_SLT = 3'b000; 

    always @* begin
        case (ALU_op)
            // R-type or I-type (immediate arithmetic)
            2'b10: begin
                case (funct3)
                    3'b000: // ADD or SUB
                        if (funct7 == 7'b0100000) ALU_opcode = ALU_SUB;
                        else ALU_opcode = ALU_ADD;
                    3'b111: // AND
                        ALU_opcode = ALU_AND;
                    3'b110: // OR
                        ALU_opcode = ALU_OR;
                    3'b001: // SLL
                        ALU_opcode = ALU_SLL;
                    3'b101: // SRL Note: For simplicity, only SRL. SRA requires more logic.
                        ALU_opcode = ALU_SRL;
                    default: ALU_opcode = 3'b000; // Default to no-op
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
            default: ALU_opcode = 3'b000; // Default to no-op
        endcase
    end
endmodule
