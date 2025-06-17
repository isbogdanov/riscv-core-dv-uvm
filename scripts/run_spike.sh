#!/bin/bash
# scripts/run_spike.sh

# This script runs the Spike instruction set simulator on a pre-compiled
# ELF file. This ensures that Spike and the RTL simulation execute the
# exact same binary.

set -e # Exit on any error

if [ $# -ne 1 ]; then
    echo "Usage: $0 <seed>"
    exit 1
fi
SEED=$1

# Find the output directory (assumes only one 'out_*' directory exists)
OUT_DIR=$(ls -d out_*/ 2>/dev/null | head -n 1)
if [ -z "$OUT_DIR" ]; then
    echo "Error: Output directory (out_*) not found. Did 'make gen' run successfully?"
    exit 1
fi

# The generator creates a single test directory. Find the compiled object there.
ELF_FILE=$(find "${OUT_DIR}asm_test" -name "*.o" | head -n 1)
if [ -z "$ELF_FILE" ]; then
    echo "Error: No .o file found in ${OUT_DIR}asm_test. Did 'make compile_asm' run?"
    exit 1
fi

# Define the log file path, ensuring the directory exists.
SPIKE_LOG_DIR="${OUT_DIR}spike_sim"
mkdir -p "$SPIKE_LOG_DIR"
# The log file name must match what the original flow created.
SPIKE_LOG_FILE="${SPIKE_LOG_DIR}/riscv_arithmetic_basic_test_0.log"

echo "--- Running Spike on ${ELF_FILE} ---"
# The '-l' flag enables logging of retired instructions.
# The '--log-commits' flag adds GPR write data to the log.
# We must redirect stderr to stdout because Spike writes its log to stderr.
spike -m0x80000000:0x20000 --isa=rv32im -l --log-commits "$ELF_FILE" > "$SPIKE_LOG_FILE" 2>&1

echo "--- Spike simulation complete. Log at ${SPIKE_LOG_FILE} ---" 