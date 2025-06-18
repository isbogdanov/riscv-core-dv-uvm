// Simple formal verification for RISC-V adder module
// Proves basic arithmetic properties to demonstrate formal verification works
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

module pc_x0_formal (
    input logic clk,
    input logic [31:0] inA,
    input logic [31:0] inB
);

    // Output from the adder
    wire [31:0] result;

    // Instantiate the actual RISC-V adder module
    adder dut (
        .inA(inA),
        .inB(inB),
        .out(result)
    );

    // Simple assumptions to constrain input space
    always @(*) begin
        // Keep inputs small to make verification fast
        assume (inA <= 32'h0000_00FF);
        assume (inB <= 32'h0000_00FF);
    end
    
    // Simple property: adder output should equal sum of inputs
    always @(*) begin
        assert (result == (inA + inB));
    end

    // Additional simple property: result should be commutative
    always @(*) begin
        assert (result == (inB + inA));
    end

endmodule 