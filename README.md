# RISC-V Processor and Verification Environment

This repository contains the implementation of a 32-bit RISC-V processor and a comprehensive UVM-based verification environment designed to ensure its correctness.

## Core Architecture

The processor is a single-cycle implementation of the **RV32I base integer instruction set**. It is composed of the following key modules located in the `rtl/` directory:

- **`processor.v`**: The top-level module that integrates all components.
- **`CPU_controller.v`**: Decodes instructions and generates control signals.
- **`ALU.v`**: Performs arithmetic and logical operations.
- **`ALU_controller.v`**: Generates the specific opcode for the ALU.
- **`imm_gen.v`**: Extracts and sign-extends immediate values from instructions.
- **`register_file.v`**: Manages the 32 general-purpose registers and basic CSRs.
- **`program_counter.v`**: Manages the program counter.
- **`instruction_memory.v` / `data_memory.v`**: Models the memory system.

## Project Structure

The repository is organized to support a complete verification workflow, from simulation and coverage analysis to formal verification and bug tracking, as outlined below:

```
riscv-core-dv-uvm/
├── rtl/              # All processor RTL files (processor.v, ALU.v, etc.)
├── uvm_env/          # UVM verification environment (tb_top.sv, sequences)
├── coverage/         # Coverage reports (merged.ucdb, HTML reports)
├── formal_proof/     # Formal property verification files
├── bug_story/        # Bug report and analysis
├── scripts/          # Helper scripts for automation (e.g., seed generation)
├── docs/             # Verification plan and other documentation
├── Makefile          # Automates compiling, simulation, and other tasks
└── README.md         # This file
```

## Getting Started

To compile the RTL and run simulations, you will need a SystemVerilog simulator that supports UVM, such as QuestaSim.

### Running a Regression

To execute the full UVM-based regression with constrained-random tests:

```bash
make regress
```

### Preserving Seeds

To run a regression without regenerating test seeds, which is useful for debugging a specific failing seed:

```bash
make PRESERVE_SEEDS=1 regress
```

## Toolchain and Workflow

This project leverages a suite of standard EDA tools and an automated flow to perform robust verification.

### Core Tools

*   **QuestaSim**: Used for compiling and simulating the SystemVerilog and Verilog code, including the DUT and the UVM testbench.
*   **RISC-V DV Generator (`riscv-dv`)**: Generates constrained-random RISC-V assembly programs, which serve as the stimuli for the verification environment.
*   **RISC-V GCC Toolchain**: Compiles the generated assembly tests into ELF files that can be executed on both the RTL model and the reference model.
*   **Spike (RISC-V ISA Simulator)**: Acts as the "golden reference." It executes the same ELF files as the DUT to produce a trusted instruction trace log.
*   **Python**: Drives the automation flow, including generating test seeds, converting log files, and comparing the results between the DUT and Spike.

### Regression Workflow

The entire regression process is automated with `make regress` and follows these steps:

1.  **Test Generation**: A random seed is used to invoke the `riscv-dv` generator, creating a unique assembly test file.
2.  **Compilation**: The assembly test is compiled into an ELF file using the RISC-V GCC toolchain.
3.  **Golden Trace Generation**: The ELF file is executed on the `Spike` simulator, producing a golden trace log of every instruction executed and the resulting register state changes.
4.  **RTL Simulation**:
    *   The ELF file is converted into a Verilog-compatible memory file (`.mem`) and loaded into the processor's instruction memory.
    *   `QuestaSim` runs the simulation, executing the test on the RTL implementation of the processor.
    *   During the simulation, a trace log is generated in the same format as the Spike log.
5.  **Comparison**: Both the Spike log and the RTL log are converted to a standard CSV format. A comparison script then diffs these files to ensure that the processor's behavior is bit-for-bit identical to the golden reference model.
6.  **Result**: The regression passes if the traces match perfectly, indicating that the processor correctly executed the test program. 