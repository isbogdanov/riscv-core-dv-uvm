`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module multiplexor(
    input control,
    input [31:0] inA,
    input [31:0] inB,
    output wire [31:0] out

    );
    
   assign out = (control) ? inB: inA;
    
endmodule
