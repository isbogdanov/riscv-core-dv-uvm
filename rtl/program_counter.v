`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module program_counter(

    input [31:0] next_PC,
    output [31:0] current_PC,
    input clk,
    input rst
   );
    
    reg [31:0] inst_address = 32'h80000000;
    
    assign current_PC = inst_address;
        
    always @(posedge clk or posedge rst)
       if (rst) begin 
            inst_address <= 32'h80000000; 
       end
       else begin
            inst_address <= next_PC;
       end;
       
endmodule
