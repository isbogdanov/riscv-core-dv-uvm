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
    output [3:0]  address,
    
    output [31:0] mem_write_data, 
    input [31:0] mem_read_data
    
    );
    
    
                           
    wire branch;
    wire [1:0] ALU_op;
   
    wire [31:0] from_increment_adder;
    wire [31:0] from_branch_adder;
    
    wire [31:0] next_PC;
    wire PC_src_control;
    wire ALU_zero;
    
    wire ALU_src;
      
    wire [31:0] PC_increment = (rst)? 0 : 1;
    
    wire mem_to_reg;
  
     
    wire reg_write;
    
    wire [31:0] from_ALU;
    wire [31:0] from_MEM;
    wire [31:0] to_REG_WRITE_DATA;
    
    assign address = from_ALU[3:0];
  
    assign PC_src_control = branch && ALU_zero;
    
    CPU_controller CPU_control (.opcode(instruction[6:0]),
                                 .branch(branch),
                                 .mem_read(mem_read),
                                 .mem_to_reg(mem_to_reg),
                                 .ALU_op(ALU_op),
                                 .mem_write(mem_write),
                                 .ALU_src(ALU_src),
                                 .register_write(reg_write),
                                 .get_counter(get_counter)
                                    ); 
    
    program_counter PC (.next_PC(next_PC), .current_PC(current_PC), .clk(clock), .rst(rst));
    
    // updatin PC counter
    multiplexor PC_value(.control(PC_src_control),
                         .inA(from_increment_adder), 
                         .inB(from_branch_adder),
                         .out(next_PC));
      
    adder increment_adder(.inA(PC_increment),
                          .inB(current_PC),
                          .out(from_increment_adder)
                          );
    
  
    wire [31:0] operand_2;
    wire [31:0] rs2_value;
    
    wire [31:0] IMM_value;
    // deciding on ALU input
    multiplexor ALU_operand_2 (.control(ALU_src),
                           .inA(rs2_value), 
                           .inB(IMM_value),
                           .out(operand_2)
                           );
    

    
    
    multiplexor REG_WRITE_DATA_input (.control(mem_to_reg),
                                      .inA(from_ALU),
                                      .inB(mem_read_data),
                                      .out(to_REG_WRITE_DATA));
   
    
   wire [4:0] rs1;
   assign rs1 =  instruction[19:15];
   
   wire [4:0] rs2;
   assign rs2 =  instruction[24:20];
   
   wire [4:0] rd;
   assign rd =  instruction[11:7];
   
   wire [6:0] opcode;
   assign opcode = instruction[6:0];
   
   wire [31:0] rs1_value;
   
   wire get_counter;
   
   register_file RF (.rs1(rs1),
                     .rs2(rs2),
                     .rd(rd),
                     .rd_value(to_REG_WRITE_DATA),
                     .register_write(reg_write),    
                     .rs1_value(rs1_value),
                     .rs2_value(rs2_value),
                     .get_counter(get_counter),
                     .current_PC(current_PC),
                     .clk(clock), .rst(rst));
    
   assign mem_write_data = rs2_value;

    adder branch_adder(.inA(current_PC),
                        .inB(IMM_value),
                        .out(from_branch_adder)
                        //.overflow(overflow)
                        );
      
   
    imm_gen IMM (.instruction(instruction), .IMM_value(IMM_value));
    
    
    
    wire [2:0] ALU_opcode;
    
    ALU ALU_instance (.opcode(ALU_opcode),
                      .operand_1(rs1_value),
                      .operand_2(operand_2),
                      .ALU_result(from_ALU),
                       .zero(ALU_zero),
                       .rst(rst));    

    wire subtraction_valid = (instruction[30]==1&& instruction[5]==1)? 1:0;
    wire [3:0] ALU_controller_opcode;
    assign ALU_controller_opcode = {subtraction_valid, instruction[14:12]};                                
    
    ALU_controller ALU_control (.opcode(ALU_controller_opcode),
                                .ALU_op(ALU_op),
                                .ALU_opcode(ALU_opcode)
                                   );

endmodule
