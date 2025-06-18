`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////



module CPU_controller(input [6:0]opcode,
                       output wire branch,
                       output wire mem_read,
                       output wire [1:0] ALU_op,
                       output wire  mem_write,
                       output wire ALU_src,
                       output wire  register_write,
                       output wire [1:0] writeback_src,
                       output wire jump,
                       output wire jalr_select
    );

assign jalr_select = (opcode == 7'b1100111) ? 1:0;
assign jump = (opcode == 7'b1101111 || opcode == 7'b1100111) ? 1:0;
assign branch = (opcode == 7'b1100011) ? 1:0;
assign mem_read = (opcode == 7'b0000011)? 1:0;

// The writeback_src signal determines what data is written back to the register file.
// 2'b00: The result from the ALU
// 2'b01: Data loaded from memory
// 2'b10: The return address (PC+4) for JAL/JALR instructions
assign writeback_src = (opcode == 7'b0000011) ? 2'b01 : 
                       ((opcode == 7'b1101111 || opcode == 7'b1100111)) ? 2'b10 : 
                       2'b00; // Default to ALU result

assign ALU_op = (opcode == 7'b0110011 || opcode == 7'b0010011)? 2'b10 : 
                (((opcode == 7'b1100011)||(opcode==7'b1101111))? 2'b01 : 2'b00);

assign mem_write = (opcode == 7'b0100011)? 1:0;
assign ALU_src = ((opcode == 7'b0010011)||(opcode == 7'b0100011)||(opcode == 7'b0000011))? 1:0;
assign register_write = ((opcode==7'b1100011)||(opcode==7'b0100011)) ? 0:1;

endmodule
