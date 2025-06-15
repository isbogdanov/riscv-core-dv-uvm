`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module ALU_controller(
    input wire [3:0] opcode,
    input wire [1:0] ALU_op,
    output [2:0] ALU_opcode
    );

    parameter ADD=4'b0000, SUB=4'b1000, AND=4'b0111, OR=4'b0110, SLL=4'b0001, SRL=4'b0101;

    assign ALU_opcode = (((opcode == ADD)&&(ALU_op!=2'b01) )|| (ALU_op==2'b00) )? 3'b001 : 
                        (((opcode == SUB) || (ALU_op==2'b01))? 3'b010 : 
                        ((opcode == AND)? 3'b011 :
                        ((opcode == OR)?  3'b100 : 
                        ((opcode == SLL)? 3'b101 : 
                        ((opcode == SRL)? 3'b110 : 3'b000 )))));
   
endmodule
