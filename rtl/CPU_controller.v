`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////



module CPU_controller(input [6:0]opcode,
                       output wire branch,
                       output wire mem_read,
                       output wire [1:0] ALU_op,
                       output wire  mem_write,
                       output wire ALU_src,
                       output wire  register_write,
                       output wire [1:0] writeback_src,
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
// 2'b00: The result from the ALU (R-type, I-type arithmetic)
// 2'b01: Data loaded from memory (LW)
// 2'b10: The return address (PC+4) for JAL/JALR instructions
// 2'b11: From Immediate (LUI) or CSR read data
assign writeback_src = (opcode == 7'b0000011) ? 2'b01 :                          // LW
                       (opcode == 7'b1101111 || opcode == 7'b1100111) ? 2'b10 :  // JAL, JALR
                       (opcode == 7'b0110111 || opcode == 7'b1110011) ? 2'b11 :  // LUI, CSR
                       2'b00;                                                    // Default to ALU result (AUIPC now falls here)

assign ALU_op = (opcode == 7'b0110011 || opcode == 7'b0010011) ? 2'b10 :
                (opcode == 7'b1100011) ? 2'b01 :
                2'b00; // Default to ADD for LW/SW/JAL/JALR

assign mem_write = (opcode == 7'b0100011)? 1:0;
assign ALU_src = (opcode == 7'b0110011 || opcode == 7'b1100011) ? 0 : 1;
// A register write is performed for all instructions except stores and branches.
assign register_write = (opcode != 7'b0100011 && opcode != 7'b1100011);

endmodule
