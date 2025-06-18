`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Carleton University  
// Student: Igor Bogdanov 
//////////////////////////////////////////////////////////////////////////////////


module instruction_memory(
    input [31:0] address,
    output [31:0] instruction 
    );
    
   // 128KB of instruction memory (32768 x 32-bit words)
   localparam BOOT_ADDRESS = 32'h00000000;
   reg [31:0] RAM [32767:0];
   integer i;
     
    // The processor asks for addresses starting at 0x80000000.
    // We must subtract this offset to map it to our RAM array (0-indexed).
    assign instruction = RAM[(address - BOOT_ADDRESS) >> 2];

    // Initialize the entire memory to 0 to prevent executing 'x'
    // if the PC runs past the end of the loaded program.
    initial begin
        for (i=0; i<32768; i=i+1) begin
            RAM[i] <= 32'b0;
        end
    end

    // The testbench will load the memory from an ELF file.
    // initial $readmemb ("RAM_data.txt",RAM,0,27); 
endmodule
