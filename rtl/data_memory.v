`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module data_memory(
    input wire mem_read,
    input wire mem_write,
    input wire [31:0] address,
    input wire [31:0] write_data,   
    output [31:0] read_data,
    input wire clk,
    input wire rst
   );
    
    reg [31:0] memory [16383:0];
    integer i;
    
    assign read_data = (mem_read) ? memory[address[15:2]]: 0 ;
    
    always @(posedge clk or posedge rst)
         if (rst) begin
            for (i=0; i<16384; i=i+1) begin
                memory[i] <= 0;
            end
        end
        else if (mem_write) memory[address[15:2]] <= write_data; 
    
endmodule
