# RISC-V Processor and UVM Verification Environment

This branch implements classic UVM approach for RISC-V processor verification.

## UVM Refactored Implementation

The `uvm_refactored/` directory contains a self-contained, passive UVM testbench for the RISC-V processor core verification.

### Overview

This implementation uses a **passive monitoring UVM methodology** with the following components:

- **Transactions**: `riscv_commit_transaction` - Represents committed instructions
- **Monitors**: `cpu_monitor` - Observes and captures RTL commit transactions  
- **Scoreboard**: `cpu_scoreboard` - Compares RTL against Spike ISS reference
- **Agent**: `cpu_agent` - Passive-only agent (no driver or sequencer)
- **Test**: `riscv_base_test` - Main test that runs the verification
- **Environment**: `cpu_env` - Instantiates and connects all UVM components

### Architecture

```
uvm_top.sv
├── cpu_top (DUT wrapper)
│   └── processor (RISC-V core)
├── instruction_memory (hardware)
├── data_memory (hardware)
└── UVM Environment
    ├── cpu_monitor (observes RTL)
    └── cpu_scoreboard (compares vs Spike)
```

### Key Features

- **Passive monitoring approach**: No stimulus generation - observes processor execution
- **Hardware memory approach**: Uses actual memory modules instead of UVM memory models
- **ECALL handling**: Gracefully handles test completion on ECALL instruction
- **Pipeline synchronization**: Proper signal timing for pipelined processor
- **Self-contained**: All working files contained in `uvm_refactored/` directory

## Quick Start

### 1. UVM Smoke Test (No external test program)
```bash
make uvm_smoke
```

### 2. UVM Regression with Generated Test Program
```bash
make uvm_regress
```

This command will:
- Generate a random test program
- Compile it to memory format
- Run Spike reference simulation
- Run UVM testbench and compare results

### 3. Using Specific Seed (Recommended for Testing)
```bash
mkdir -p logs
echo "846056" > logs/seeds.txt
PRESERVE_SEEDS=1 make uvm_regress
```

## Project Structure

### UVM Refactored Files (Working Components Only)
- `uvm_refactored/uvm_top.sv` - Top-level testbench module
- `uvm_refactored/cpu_top.sv` - DUT wrapper (local copy)
- `uvm_refactored/cpu_interface.sv` - Interface between testbench and DUT
- `uvm_refactored/riscv_uvm_pkg.sv` - UVM package with all classes
- `uvm_refactored/transactions/` - Transaction definitions
- `uvm_refactored/monitors/` - Monitor implementations
- `uvm_refactored/subscribers/` - Scoreboard implementations
- `uvm_refactored/agents/` - Passive agent implementation
- `uvm_refactored/env/` - Environment implementations
- `uvm_refactored/tests/` - Test implementations

### Traditional Script-Based Approach
- `uvm_scripted_flow/tb_top.sv` - Original working script-based testbench
- `uvm_scripted_flow/cpu_top.sv` - Original DUT wrapper

## Environment Requirements

Ensure these environment variables are set (in `.env` file):
- `QUESTA_HOME` - Path to Questa installation
- `UVM_HOME` - Path to UVM library  
- `HOST_CC_PATH` - Path to C++ compiler

## Expected Output

Successful UVM run should show:
- PC MATCH messages for each instruction
- ECALL detection and graceful termination  
- UVM_INFO messages with zero UVM_ERRORs
- Clean test completion

## Design Philosophy

This UVM implementation demonstrates a **passive monitoring approach** which is optimal for processor verification:

- **No artificial stimulus**: Uses realistic pre-compiled programs instead of UVM sequences
- **Hardware-accurate**: Real memory modules provide correct timing behavior  
- **Focused verification**: Concentrates on instruction execution correctness
- **Efficient**: Minimal UVM overhead while maintaining proper checking methodology
