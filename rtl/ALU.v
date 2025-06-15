`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////



module ALU(
    input wire [2:0] opcode,
    input wire [31:0] operand_1,
    input wire [31:0] operand_2,
    output wire [31:0] ALU_result,
    output zero,
    input rst
    
    );

    parameter ADD=3'b001, SUB=3'b010, AND=3'b011, OR=3'b100, SLL=3'b101, SRL=3'b110;

    assign ALU_result = rst ? 0 : ((opcode == ADD )? operand_1 + operand_2 : 
                        ((opcode == SUB)? operand_1 - operand_2 : 
                        ((opcode == AND)? operand_1 && operand_2 :
                        ((opcode == OR)? operand_1 || operand_2 : 
                        ((opcode == SLL) ? operand_1 << operand_2 : 
                        ((opcode == SRL)? operand_1 >> operand_2 : 0 ))))));
      
    assign zero = (ALU_result==0)? 1:0;                     
    
endmodule

	
