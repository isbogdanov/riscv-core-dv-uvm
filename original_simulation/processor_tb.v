`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module processor_tb;
        
    reg clk;
    reg rst;
    
    wire [31:0] current_PC;
    wire [31:0] instruction;
    
    wire mem_read;
    wire mem_write;
    wire [3:0] mem_address;
   wire [31:0] mem_read_data;
    wire [31:0] mem_write_data;
    

instruction_memory DUT1 (.address(current_PC), .instruction(instruction));

data_memory DUT2 (.mem_read(mem_read),
                     .mem_write(mem_write),
                     .address(mem_address), 
                     .write_data(mem_write_data), 
                     .read_data(mem_read_data),
                     .clk(clk ),
                     .rst(rst));

processor DUT3 (
    .clock(clk),
    .rst(rst),
    .instruction(instruction),
    .current_PC(current_PC),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(mem_address),
     .mem_write_data(mem_write_data), 
    .mem_read_data(mem_read_data)
);
   
initial
begin
    
    clk = 0;
    rst = 1;
    @(posedge clk);
    rst = 0;
    #8;
end

always clk = #16 ~clk;

    
endmodule
