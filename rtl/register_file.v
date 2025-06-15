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
    input wire rst,
    input get_counter,
    input [31:0] current_PC
   
    );
    
    reg [31:0] registers [20:0];
    
   
    assign rs1_value = registers[rs1];
    assign rs2_value = registers[rs2];
    
    always @(posedge clk or posedge rst) 
        if (rst) begin
            registers[0] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[1] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[2] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[3] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[4] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[5] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[6] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[7] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[8] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[9] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[10] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[11] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[12] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[13] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[14] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[15] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[16] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[17] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[18] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[19] <= 32'b0_000_00000000_00000000_00000000_0000;
            registers[20] <= 32'b0_000_00000000_00000000_00000000_0000;
                              
        end
        else if (register_write && (rst == 0)) begin
            if (get_counter) begin 
                registers[rd] <= current_PC+1;
            end
            else begin  
                registers[rd] <= rd_value;
            end 
        end
endmodule
