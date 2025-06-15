`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module data_memory(
    input wire mem_read,
    input wire mem_write,
    input wire [3:0] address,
    input wire [31:0] write_data,   
    output [31:0] read_data,
    input wire clk,
    input wire rst
   );
    
    reg [31:0] memory [9:0];
    
    assign read_data = (mem_read) ? memory[address]: 0 ;
    
    always @(posedge clk or posedge rst)
         if (rst) begin
            memory[0] <= 32'b0_000_00000000_00000000_00000000_0000;
            memory[1] <= 32'b0_000_00000000_00000000_00000000_0000;
            memory[2] <= 32'b0_000_00000000_00000000_00000000_0000;
            memory[3] <= 32'b0_000_00000000_00000000_00000000_0000;
            memory[4] <= 32'b0_000_00000000_00000000_00000000_0000;
            memory[5] <= 32'b0_000_00000000_00000000_00000000_0000;
            memory[6] <= 32'b0_000_00000000_00000000_00000000_0000;
            memory[7] <= 32'b0_000_00000000_00000000_00000000_0000;
            memory[8] <= 32'b0_000_00000000_00000000_00000000_0000;
            memory[9] <= 32'b0_000_00000000_00000000_00000000_0000;
           
        end
        else if (mem_write) memory[address] <= write_data; 
    
endmodule
