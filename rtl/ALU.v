`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////

module ALU(
    input wire [3:0] opcode,
    input wire [31:0] operand_1,
    input wire [31:0] operand_2,
    output reg [31:0] ALU_result,
    output wire zero,
    input rst
    
    );

    parameter ADD=4'b0001, SUB=4'b0010, AND=4'b0011, OR=4'b0100, SLL=4'b0101, SRL=4'b0110, XOR=4'b0111, SLT=4'b0000, SRA=4'b1010, SLTU=4'b1011;

    wire [4:0] shift_amount = operand_2[4:0];

    always @* begin
        if (rst) begin
            ALU_result = 32'b0;
        end else begin
            case (opcode)
                ADD:  ALU_result = operand_1 + operand_2;
                SUB:  ALU_result = operand_1 - operand_2;
                AND:  ALU_result = operand_1 & operand_2;
                OR:   ALU_result = operand_1 | operand_2;
                SLL:  ALU_result = operand_1 << shift_amount;
                SRL:  ALU_result = operand_1 >> shift_amount;
                XOR:  ALU_result = operand_1 ^ operand_2;
                SRA:  ALU_result = $signed(operand_1) >>> shift_amount;
                SLT:  ALU_result = ($signed(operand_1) < $signed(operand_2)) ? 1 : 0;
                SLTU: ALU_result = (operand_1 < operand_2) ? 1 : 0;
                default: ALU_result = 32'b0;
            endcase
        end
    end
      
    assign zero = (ALU_result==0)? 1:0;                     
    
endmodule

	
