// This file is the central configuration for the riscv-dv test generator.
// It defines the capabilities of the target processor.

parameter string supported_isa = "RV32IM_Zicsr";
parameter bit    disable_compressed_instr = 1;
parameter bit    check_misa_init = 1; 