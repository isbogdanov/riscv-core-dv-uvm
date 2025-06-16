`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module processor(
    input clock,
    input rst,
    input [31:0] instruction,
    output [31:0] current_PC, 
    
    output mem_read,
    output mem_write,
    output [31:0]  address,
    
    output [31:0] mem_write_data, 
    input [31:0] mem_read_data,
    
    // Verification outputs
    output reg_write,
    output [4:0] rd,
    output reg [31:0] to_REG_WRITE_DATA
    
    );
    
    wire branch;
    wire [1:0] ALU_op;
    wire jump;
    wire jalr_select;
    wire [1:0] writeback_src;
    wire csr_read;
    wire alu_src1_is_pc;
   
    wire [31:0] from_increment_adder;
    wire [31:0] from_branch_adder;
    
    wire [31:0] next_PC;
    wire PC_src_control;
    wire ALU_zero;
    
    wire ALU_src;
    wire [31:0] IMM_value;
    wire [31:0] rs1_value;
    wire [31:0] rs2_value;
    wire [31:0] csr_read_data;
      
    wire [31:0] PC_increment = 4;
    
    wire [31:0] from_ALU;
    
    assign address = from_ALU;
  
    assign PC_src_control = (branch && ALU_zero) || jump;
    
    CPU_controller CPU_control (.opcode(instruction[6:0]),
                                 .branch(branch),
                                 .mem_read(mem_read),
                                 .ALU_op(ALU_op),
                                 .mem_write(mem_write),
                                 .ALU_src(ALU_src),
                                 .register_write(reg_write),
                                 .writeback_src(writeback_src),
                                 .jump(jump),
                                 .jalr_select(jalr_select),
                                 .csr_read(csr_read),
                                 .alu_src1_is_pc(alu_src1_is_pc)
                                    ); 
    
    program_counter PC (.next_PC(next_PC), .current_PC(current_PC), .clk(clock), .rst(rst));
    
    // updatin PC counter
    wire [31:0] next_PC_branch_src;
    wire [31:0] branch_adder_inA;

    multiplexor JALR_PC_source_select(.control(jalr_select),
                                      .inA(current_PC),
                                      .inB(rs1_value),
                                      .out(branch_adder_inA));

    adder branch_adder(.inA(branch_adder_inA),
                        .inB(IMM_value),
                        .out(from_branch_adder)
                        );
      
    // The calculated branch/jump address may not be 4-byte aligned.
    // For this processor, all instructions must be 4-byte aligned, so
    // we force the two LSBs of the next PC to zero for all branches and jumps.
    assign next_PC_branch_src = {from_branch_adder[31:2], 2'b00};

    multiplexor PC_value(.control(PC_src_control),
                         .inA(from_increment_adder), 
                         .inB(next_PC_branch_src),
                         .out(next_PC));
      
    adder increment_adder(.inA(PC_increment),
                          .inB(current_PC),
                          .out(from_increment_adder)
                          );
    
  
    wire [31:0] operand_2;
    
    // deciding on ALU input
    multiplexor ALU_operand_2 (.control(ALU_src),
                           .inA(rs2_value), 
                           .inB(IMM_value),
                           .out(operand_2)
                           );
    
    wire [31:0] alu_op1;
    multiplexor alu_op1_mux (
        .control(alu_src1_is_pc),
        .inA(rs1_value),
        .inB(current_PC),
        .out(alu_op1)
    );
    
    // This mux selects the final value to be written back to the register file.
    // It is controlled by the writeback_src signal from the CPU controller.
    always @* begin
        case (writeback_src)
            2'b00:  to_REG_WRITE_DATA = from_ALU;           // Result from ALU
            2'b01:  to_REG_WRITE_DATA = mem_read_data;      // Data from memory
            2'b10:  to_REG_WRITE_DATA = from_increment_adder; // PC+4 for JAL/JALR
            2'b11:  to_REG_WRITE_DATA = csr_read ? csr_read_data : IMM_value; // CSR data or Immediate
            default: to_REG_WRITE_DATA = 32'hdeadbeef;     // Should not happen
        endcase
    end

   
   wire [4:0] rs1;
   assign rs1 =  instruction[19:15];
   
   wire [4:0] rs2;
   assign rs2 =  instruction[24:20];
   
   assign rd =  instruction[11:7];
   
   wire [6:0] opcode;
   assign opcode = instruction[6:0];
   
   wire get_counter_wire = 0;
   
   wire [11:0] csr_addr = instruction[31:20];
   
   register_file RF (.rs1(rs1),
                     .rs2(rs2),
                     .rd(rd),
                     .rd_value(to_REG_WRITE_DATA),
                     .register_write(reg_write),    
                     .rs1_value(rs1_value),
                     .rs2_value(rs2_value),
                     .clk(clock), 
                     .rst(rst),
                     .get_counter(get_counter_wire),
                     .current_PC(current_PC),
                     .csr_read(csr_read),
                     .csr_addr(csr_addr),
                     .csr_read_data(csr_read_data));
    
   assign mem_write_data = rs2_value;

    imm_gen IMM (.instruction(instruction), .IMM_value(IMM_value));
    
    
    
    wire [2:0] ALU_opcode;
    
    ALU ALU_instance (.opcode(ALU_opcode),
                      .operand_1(alu_op1),
                      .operand_2(operand_2),
                      .ALU_result(from_ALU),
                       .zero(ALU_zero),
                       .rst(rst));    

    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction[31:25];

    ALU_controller ALU_control (.funct3(funct3),
                                .funct7(funct7),
                                .ALU_op(ALU_op),
                                .ALU_opcode(ALU_opcode)
                                   );

endmodule
