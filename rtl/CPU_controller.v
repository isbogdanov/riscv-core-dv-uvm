`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////



module CPU_controller(input [6:0]opcode,
                       output wire branch,
                       output wire mem_read,
                       output wire mem_to_reg,
                       output wire [1:0] ALU_op,
                       output wire  mem_write,
                       output wire ALU_src,
                       output wire  register_write,
                       output wire get_counter

    );

assign branch = (opcode[6])? 1:0;
assign mem_read = (opcode == 7'b0000011)? 1:0;
assign mem_to_reg = (opcode == 7'b0000011)? 1:0;

assign ALU_op = (opcode == 7'b0110011 || opcode == 7'b0010011)? 2'b10 : 
                (((opcode == 7'b1100011)||(opcode==7'b1101111))? 2'b01 : 2'b00);

assign mem_write = (opcode == 7'b0100011)? 1:0;
assign ALU_src = ((opcode == 7'b0010011)||(opcode == 7'b0100011)||(opcode == 7'b0000011))? 1:0;
assign register_write = ((opcode==7'b1100011)||(opcode==7'b0100011))?0:1;

assign get_counter =  (opcode == 7'b1101111)? 1:0; 
  
    
endmodule
