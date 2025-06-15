`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module instruction_memory(
    input [31:0] address,
    output [31:0] instruction 
    );
    
   reg [31:0] RAM [127:0];
   integer i;
     
    assign instruction = RAM[address[31:2]];

    // Initialize the entire memory to 0 to prevent executing 'x'
    // if the PC runs past the end of the loaded program.
    initial begin
        for (i=0; i<128; i=i+1) begin
            RAM[i] <= 32'b0;
        end
    end

    // loading contents from file on disk. The end address '27' is inclusive,
    // so this loads 28 instructions into addresses 0 through 27.
    initial $readmemb ("RAM_data.txt",RAM,0,27); 
endmodule
