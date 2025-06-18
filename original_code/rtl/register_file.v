`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////



module register_file(
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,
    input wire [31:0] rd_value,
    
    input register_write,    
    
    output [31:0] rs1_value,
    output [31:0] rs2_value,
    input  wire clk,
    input wire rst
   
    );
    
    reg [31:0] registers [31:0];
    integer i;
    
   
    assign rs1_value = (rs1 == 0) ? 0 : registers[rs1];
    assign rs2_value = (rs2 == 0) ? 0 : registers[rs2];
    
    always @(posedge clk or posedge rst) 
        if (rst) begin
            for (i=0; i<32; i=i+1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (register_write && (rd != 0)) begin
            registers[rd] <= rd_value;
        end
endmodule
