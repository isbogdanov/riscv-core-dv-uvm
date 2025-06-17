`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////



module CPU_controller(input [6:0]opcode,
                       output wire branch,
                       output wire mem_read,
                       output wire [1:0] ALU_op,
                       output wire  mem_write,
                       output wire ALU_src,
                       output wire  register_write,
                       output reg [1:0] writeback_src,
                       output wire jump,
                       output wire jalr_select,
                       output wire csr_read,
                       output wire alu_src1_is_pc
    );

assign alu_src1_is_pc = (opcode == 7'b0010111); // Assert only for AUIPC
assign csr_read = (opcode == 7'b1110011); // SYSTEM instructions (incl. CSRRW, CSRRS, etc.)
assign jalr_select = (opcode == 7'b1100111) ? 1:0;
assign jump = (opcode == 7'b1101111 || opcode == 7'b1100111) ? 1:0;
assign branch = (opcode == 7'b1100011) ? 1:0;
assign mem_read = (opcode == 7'b0000011)? 1:0;

// The writeback_src signal determines what data is written back to the register file.
// Using a case statement for clarity and to ensure correct priority.
always @* begin
    case (opcode)
        7'b0000011: writeback_src = 2'b01; // LW
        7'b1101111: writeback_src = 2'b10; // JAL
        7'b1100111: writeback_src = 2'b10; // JALR
        7'b0110111: writeback_src = 2'b11; // LUI
        7'b1110011: writeback_src = 2'b11; // SYSTEM/CSR
        default:    writeback_src = 2'b00; // R-type, I-type, AUIPC
    endcase
end

assign ALU_op = (opcode == 7'b0110011 || opcode == 7'b0010011) ? 2'b10 :
                (opcode == 7'b1100011) ? 2'b01 :
                2'b00; // Default to ADD for LW/SW/JAL/JALR

assign mem_write = (opcode == 7'b0100011)? 1:0;
assign ALU_src = (opcode == 7'b0110011 || opcode == 7'b1100011) ? 0 : 1;

// A register write is performed for R, I, U, J, and SYSTEM types.
// It is NOT performed for stores and branches.
wire is_r_type = (opcode == 7'b0110011);
wire is_i_type = (opcode == 7'b0010011) || (opcode == 7'b0000011) || (opcode == 7'b1100111);
wire is_u_type = (opcode == 7'b0110111) || (opcode == 7'b0010111);
wire is_j_type = (opcode == 7'b1101111);
wire is_csr_type = (opcode == 7'b1110011);

assign register_write = is_r_type || is_i_type || is_u_type || is_j_type || is_csr_type;

endmodule
