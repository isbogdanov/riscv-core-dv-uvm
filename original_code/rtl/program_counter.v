`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module program_counter(

    input [31:0] next_PC,
    output [31:0] current_PC,
    input clk,
    input rst
   );
    
    // The program is linked to run at 0x8000_0000.
    // The PC must be reset to this address.
    localparam BOOT_ADDRESS = 32'h00000000;
    reg [31:0] inst_address = BOOT_ADDRESS;
    
    assign current_PC = inst_address;
        
    always @(posedge clk or posedge rst)
       if (rst) begin 
            inst_address <= BOOT_ADDRESS; 
       end
       else begin
            inst_address <= next_PC;
       end;
       
endmodule
