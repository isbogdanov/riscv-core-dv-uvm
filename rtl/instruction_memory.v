`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module instruction_memory(
    input [31:0] address,
    output [31:0] instruction 
    );
    
   reg [31:0] RAM [5242879:0];
   integer i;
     
    wire [31:0] physical_address = address - 32'h80000000;
    assign instruction = RAM[physical_address[31:2]];

    // Initialize the entire memory to 0. The testbench is responsible for loading a program.
    initial begin
        for (i=0; i<5242880; i=i+1) begin
            RAM[i] = 32'b0;
        end
    end

endmodule