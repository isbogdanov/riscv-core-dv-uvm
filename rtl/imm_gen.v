`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////



module imm_gen(
    
    input wire [31:0] instruction, 
    
    output wire [31:0] IMM_value

    );
    
    
    wire [6:0] opcode;
    assign opcode = instruction[6:0];
    
    wire [31:0] jtype_imm;
    wire [31:0] stype_imm;
    wire [31:0] itype_imm;
    wire [31:0] btype_imm;
    assign itype_imm = {{20{instruction[31]}},instruction[31:20]};
    assign jtype_imm = {{12{1'b0}},instruction[31],instruction[19:12],instruction[20],instruction[30:21]};
    assign stype_imm = {{20{1'b0}},instruction[31:25],instruction[11:7]};
    assign btype_imm = {{20{1'b0}},instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
    
    parameter J=7'b1101111, I1=7'b0000011, I2=7'b0010011,  S=7'b0100011, B=7'b1100011;
    
    
    assign IMM_value =  (opcode == J)? itype_imm : 
                        (((opcode == I1)||(opcode == I2))? itype_imm : 
                        ((opcode == S)? stype_imm : 
                        ((opcode == B)? btype_imm*2 : 0)));

    
endmodule
