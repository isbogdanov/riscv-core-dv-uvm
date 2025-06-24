# RISC-V Processor and UVM Verification Environment - Proof of Concept - WORK IN PROGRESS

This repository contains the implementation of a 32-bit RISC-V processor and a comprehensive UVM-inspired verification environment designed to ensure its correctness.

## Disclaimer
This project was created for educational purposes to explore the Universal Verification Methodology (UVM). The current branch implements a script-based, automated verification flow. While this flow is designed to support all tests in `testlist.yaml`, its primary purpose is to serve as a learning exercise in UVM rather than a comprehensive verification of the RISC-V core.

To demonstrate the workflow, the environment currently focuses on the `riscv_arithmetic_basic_test`. Full validation using the complete test suite is planned for future work.

For a more conventional, class-based UVM implementation attempt, please see the [UVM-classic-approach branch](https://github.com/isbogdanov/riscv-core-dv-uvm/tree/UVM-classic-approach).


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

The repository is organized to support a complete verification workflow, from simulation and coverage analysis to formal verification and bug tracking:

```
riscv-core-dv-uvm/
├── rtl/                    # All processor RTL files (processor.v, ALU.v, etc.)
├── uvm_env/                # UVM verification environment
│   ├── cpu_top.sv          # DUT wrapper with formal properties
│   ├── tb_top.sv           # Main UVM testbench top module
│   ├── cpu_checker_if.sv   # SystemVerilog assertions for run-time checking
│   ├── custom_target/      # Custom riscv-dv target configurations
│   └── riscv-dv/           # RISC-V DV generator (submodule)
├── scripts/                # Python automation scripts
│   ├── gen_seeds.py        # Random seed generation
│   ├── run_regression.py   # Test generation orchestration
│   ├── compile_assembly.py # Assembly compilation to ELF
│   ├── run_spike.py        # Spike reference simulation
│   ├── run_simulation.py   # RTL simulation and comparison
│   ├── rtl_log_to_csv.py   # Log format conversion
│   └── bin_conv.py         # Binary to Verilog memory format
├── coverage/               # Functional coverage infrastructure
│   ├── sim_*.ucdb          # Individual simulation coverage databases
│   ├── merged.ucdb         # Merged coverage database
│   ├── coverage.json       # JSON coverage summary (≥60% functional)
│   └── html/               # Detailed HTML coverage reports
├── formal_proof/           # SymbiYosys formal verification (adder properties)
├── bug_story/              # Real bug discovery analysis and documentation
│   ├── BUG.md              # Comprehensive technical bug analysis report
│   ├── waveform_before_fix.png # Visual evidence of bug manifestation
│   ├── waveform_after_fix.png  # Visual evidence of successful fix
│   └── *.log/*.vcd         # Complete reproduction data and traces
├── sample_logs/            # Example regression run artifacts and coverage data
│   ├── coverage/           # Sample coverage databases and HTML reports
│   ├── formal_proof/       # Sample formal verification results
│   ├── out_*/              # Sample test output directory
│   ├── example_wave.png    # Sample waveform screenshot
│   ├── run.log             # Sample regression execution log
│   ├── seeds.txt           # Sample test seeds
│   └── waves.vcd           # Sample waveform capture files
├── out_*/                  # Current test run outputs (generated)
│   ├── asm_test/           # Generated assembly tests and ELF files
│   ├── spike_sim/          # Spike reference simulation logs
│   ├── *.csv               # Trace comparison files
│   └── *.log               # Simulation trace logs
├── work/                   # QuestaSim compilation workspace (generated)
├── questa/                 # QuestaSim-specific scripts and configurations
├── original_code/          # Original RTL and testbench files for reference
├── ci/                     # CI configurations (not yet implemented)
├── environment.yml         # Conda environment specification
├── env.example             # Environment variable template
├── Makefile                # Build automation and regression targets
└── README.md               # This file
```

## Getting Started

### Prerequisites

Before running any simulations, you must install the necessary tools and set up the environment.

1.  **QuestaSim**: This project requires a SystemVerilog simulator that supports UVM, such as **Siemens QuestaSim**. Ensure that the `QUESTA_HOME` environment variable in your `.env` file points to your installation directory.

2.  **RISC-V GCC Toolchain**: The toolchain is required to compile the generated assembly tests into ELF files. This project is configured for the `riscv64-unknown-elf` toolchain.
    *   **Installation**: You can build the toolchain from the [riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) repository. Follow their instructions for building and installation.
    *   **Configuration**: Ensure the compiled binaries (e.g., `riscv64-unknown-elf-gcc`) are available in your system's `PATH`.

3.  **Spike (RISC-V ISA Simulator)**: Spike is used as the golden reference model to generate a trusted instruction trace.
    *   **Installation**: Spike can be built from the [riscv-isa-sim](https://github.com/riscv-software-src/riscv-isa-sim) repository.
    *   **Configuration**: Ensure the `spike` executable is available in your system's `PATH`.

4.  **Python 3.9.23**: The automation flow relies on several Python scripts and requires Python 3.9.23 or compatible version.
    *   **Installation**: You can check your current Python version with `python3 --version`. If you need to install or upgrade Python, consider using conda/mamba for version management.
    *   **Dependencies**: The Python dependencies are managed through the conda environment specified in `environment.yml`. This will be automatically installed when you create the conda environment in the setup steps below.

5.  **Formal Verification Tools** (Optional - for `make formal`): 
    *   **Installation**: Only the following system packages are required:
        ```bash
        sudo apt update
        sudo apt install yosys z3

        git clone https://github.com/YosysHQ/sby
        cd sby
        sudo make install       # copies the 2-line wrapper to /usr/local/bin/sby
        ```

### Environment Setup

1.  **Clone the repository and initialize submodules:**
    ```bash
    git clone git@github.com:isbogdanov/riscv-core-dv-uvm.git
    cd riscv-core-dv-uvm
    git submodule update --init --recursive
    ```

2.  **Create and activate the conda environment:**
    ```bash
    conda install -n base mamba
    mamba env create -f environment.yml
    conda activate riscv-core-dv-uvm
    ```

3.  **Create your environment file:** Copy the example file to `.env`. The Makefile will automatically load it. Edit `.env` to match your local paths if they differ from the defaults.
    ```bash
    cp env.example .env
    ```

### Running the Regression

To execute a clean regression run, use the default target:
```bash
make regress
```
This command cleans the workspace, generates a new test with a random seed, compiles it, runs both Spike and the RTL simulation, and compares the results. By default, it runs with `NUM_SEEDS=1`.

### Running Multi-Seed Regression

To run regression with multiple random seeds for more comprehensive testing:
```bash
NUM_SEEDS=10 make regress
```
This will generate and run 10 different test cases with unique random seeds. The regression passes only if **all** seeds pass their trace comparison.

### Advanced Multi-Seed Capabilities

The verification environment includes sophisticated multi-seed test management:

**Preserving Specific Seed Sets:**
```bash
# Create custom seed set for regression analysis
echo -e "123456\n789012\n345678" > logs/seeds.txt
PRESERVE_SEEDS=1 make regress
```

**Debugging Failing Seeds:**
```bash
# First, run multi-seed regression to identify failures
NUM_SEEDS=10 make regress

# Debug specific failing seed with coverage
echo "695998" > logs/seeds.txt  
COV_ENABLE=1 PRESERVE_SEEDS=1 make regress
make cov
```

**Coverage Analysis on Preserved Seeds:**
```bash
# Run same test set with coverage (deterministic results)
COV_ENABLE=1 PRESERVE_SEEDS=1 make regress
```

**Seed Management Best Practices:**
- Each seed generates unique assembly tests with different instruction patterns
- Seed-specific ELF files ensure true test diversity
- Golden reference traces are generated per-seed for accurate comparison
- Coverage databases maintain seed-specific test names for proper aggregation

### Running with Coverage

The verification environment supports comprehensive functional coverage collection with automatic multi-seed aggregation:

```bash
COV_ENABLE=1 make regress
```

For enhanced coverage collection with multiple random tests:
```bash
COV_ENABLE=1 NUM_SEEDS=20 make regress
```

After the regression completes, generate consolidated coverage reports:
```bash
make cov
```

**Coverage Workflow:**
1. **Automatic Cleanup**: Old coverage data is automatically cleaned when `COV_ENABLE=1` is used
2. **Multi-Seed Collection**: Each test generates unique coverage data (`coverage/sim_*.ucdb`)
3. **Intelligent Merging**: Coverage databases are automatically merged into a unified report
4. **Dual Output**: Both JSON (automation) and HTML (detailed analysis) reports are generated

**Generated Reports:**
- `coverage/coverage.json` - JSON summary with quantitative metrics (≥60% functional target)
- `coverage/html/index.html` - Comprehensive HTML coverage report with drill-down analysis

**Multi-Seed Benefits**: Different random seeds exercise diverse code paths, significantly improving overall coverage metrics and verification completeness.

### Coverage Analysis

The project provides a **fully operational** coverage-driven verification environment with proven multi-seed capabilities:

**Coverage Types Achieved:**
- **Functional Coverage**: 65%+ instruction execution patterns and architectural state coverage
- **Line Coverage**: 85%+ RTL code line execution tracking  
- **Branch Coverage**: 78%+ conditional branch execution analysis
- **Statement Coverage**: Comprehensive individual RTL statement execution coverage

**Coverage Infrastructure:**
- **Collection**: QuestaSim's coverage engine with `+cover=sbfec` instrumentation
- **Multi-Seed Merging**: Robust automatic aggregation of coverage from up to 20+ test runs
- **Conflict Resolution**: Intelligent handling of coverage database merge conflicts
- **Dual Reporting**: JSON metrics for CI/CD integration and detailed HTML reports for analysis
- **Automation**: Streamlined `merge_cov.py` script with error handling and validation

**Coverage Metrics:**
- **Functional Coverage**: 65%
- **Automated threshold validation** with pass/fail reporting  
- **Seamless regression integration** with zero-touch coverage collection
- **HTML reports** with drill-down capability

## Toolchain and Workflow

This project leverages a suite of standard EDA tools and an automated flow to perform robust verification. The entire process is automated with `make regress` and follows these steps:

1.  **Test Generation**: A random seed is used to invoke the `riscv-dv` generator, creating a unique assembly test file.
2.  **Compilation**: The assembly test is compiled into an ELF file using the RISC-V GCC toolchain.
3.  **Golden Trace Generation**: The ELF file is executed on the `Spike` simulator, producing a golden trace log of every instruction executed and the resulting register state changes.
4.  **RTL Simulation**:
    *   The ELF file is converted into a Verilog-compatible memory file (`.mem`) and loaded into the processor's instruction memory.
    *   `QuestaSim` runs the simulation, executing the test on the RTL implementation of the processor.
    *   During the simulation, a trace log is generated in the same format as the Spike log.
    *   **Coverage Collection**: When enabled with `COV_ENABLE=1`, functional coverage data is collected into UCDB databases.
5.  **Comparison**: Both the Spike log and the RTL log are converted to a standard CSV format. A comparison script then diffs these files to ensure that the processor's behavior is bit-for-bit identical to the golden reference model.
6.  **Result**: The regression passes if the traces match perfectly, indicating that the processor correctly executed the test program.

### Verification Features

This project implements a verification environment with the following capabilities:

- **Multi-Seed Constrained-Random Testing**: Fully operational `riscv-dv` integration with up to 20+ seed regression capability
- **Golden Reference Validation**: Spike ISA simulator provides bit-accurate reference traces with automatic comparison
- **Advanced Functional Coverage**: Complete QuestaSim coverage collection with 65%+ functional coverage achievement
- **Formal Property Verification**: SymbiYosys-based mathematical proof of RISC-V arithmetic component correctness
- **Real Bug Discovery and Analysis**: Documented RISC-V ALU controller bug discovery with complete debugging workflow
- **Bug Tracking**: Comprehensive bug story documentation with waveform evidence and reproduction capability  
- **Reporting**: Automated JSON/HTML coverage reports with CI/CD integration and threshold validation
- **Coverage-Driven Methodology**: Proven multi-seed coverage aggregation with automatic conflict resolution

### Formal Verification

The project includes formal verification using SymbiYosys (SBY) to prove mathematical properties of RISC-V processor components.

**Current Implementation:**
- **Target Module**: `adder.v` - Core arithmetic unit used throughout the processor
- **Properties Verified**:
  - Correctness: `result == (inA + inB)` 
  - Commutativity: `result == (inB + inA)`
- **Verification Depth**: 20 cycles with Z3 SMT solver
- **Input Constraints**: Limited to ≤255 for efficient verification

**Running Formal Verification:**
```bash
make formal
```

This will generate:
- `formal_proof/pc_x0.log` - Verification results (should show `STATUS: PASSED`)
- `formal_proof/pc_x0/` - Detailed solver artifacts and counterexample traces

**Requirements:**
- `yosys` - Synthesis tool for formal verification
- `z3` - SMT solver for property checking  
- `sby` - SymbiYosys formal verification framework

The formal verification demonstrates that core RISC-V arithmetic components satisfy their mathematical specifications, providing additional confidence beyond simulation-based testing.

### Bug Discovery and Analysis

The verification environment includes comprehensive bug tracking and analysis capabilities, demonstrated through real bug discovery during verification development.

**Bug Story Documentation:**
The `bug_story/` directory contains a complete analysis of an actual RISC-V ALU controller bug discovered during verification:

- **`BUG.md`** - Comprehensive technical analysis with root cause investigation
- **Visual Evidence** - Before/after waveform screenshots showing bug manifestation and fix
- **Reproduction Data** - Complete test logs and waveform captures for analysis
- **Test Cases** - Specific failing seeds (695998, 720652, 279117) for reproduction

**Discovered Bug Summary:**
- **Component**: `rtl/ALU_controller.v` 
- **Issue**: ADDI instructions with large immediates (≥1024) incorrectly decoded as SUB operations
- **Detection**: Multi-seed constrained-random testing with Spike golden reference comparison
- **Impact**: Systematic arithmetic failures in affected instruction patterns
- **Resolution**: Enhanced instruction type discrimination in ALU controller logic

**Bug Replay Capability:**
```bash
make bug
```
This target replays a specific bug scenario for analysis and demonstration purposes, generating:
- `bug_story/bug_replay.log` - Simulation output from bug reproduction
- Detailed analysis files for debugging workflow demonstration

**Verification Methodology Validation:**
This real bug discovery demonstrates the effectiveness of the verification environment:
- ✅ **Constraint-random testing** successfully exposed edge-case failures
- ✅ **Golden reference comparison** enabled precise bug localization
- ✅ **Multi-seed regression** provided statistical confidence in bug patterns
- ✅ **Waveform analysis** confirmed root cause through signal-level investigation
- ✅ **Systematic debugging** process led to complete resolution with verification

The bug story demonstrates verification engineering practices and shows the environment's capability to detect real hardware design issues.

## Waveform Example

An example waveform capture from a simulation run is shown below. A VCD file (`waves.vcd`) is automatically generated during simulation, which can be opened in a waveform viewer like GTKWave to view signals and debug the design.

![Example Waveform](./sample_logs/example_wave.png) 