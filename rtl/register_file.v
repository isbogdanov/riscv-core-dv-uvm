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
    input [31:0] current_PC,
    // New CSR ports
    input csr_read,
    input [11:0] csr_addr,
    output reg [31:0] csr_read_data
   
    );
    
    reg [31:0] registers [31:0];
    integer i;
    
    // --- CSR Implementation (Read-Only) ---
    // For this project, we only need to support reading mhartid (Core ID)
    parameter CSR_MHARTID = 12'hF14;
    reg [31:0] mhartid = 0; // Hart ID is 0

    always @* begin
        if (csr_read && (csr_addr == CSR_MHARTID)) begin
            csr_read_data = mhartid;
        end else begin
            csr_read_data = 32'h0; // Default for unsupported CSRs
        end
    end

    // --- GPR Implementation ---
    assign rs1_value = registers[rs1];
    assign rs2_value = registers[rs2];
    
    always @(posedge clk or posedge rst) 
        if (rst) begin
            for (i=0; i<32; i=i+1) begin
                registers[i] <= 0;
            end
        end
        else if (register_write && (rd != 0)) begin
            if (get_counter) begin 
                registers[rd] <= current_PC+1;
            end
            else begin  
                registers[rd] <= rd_value;
            end 
        end
endmodule
