`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module instruction_memory(
    input [31:0] address,
    output [31:0] instruction 
    );
    
   reg [31:0] RAM [64:0];
     
    assign instruction = RAM[address];
    // loading contents from file on disk
    initial $readmemb ("/AI/hardware/projects/xilinx/SYSC4310/verilog/lab3/RAM_data.txt",RAM,0,30); 
endmodule
