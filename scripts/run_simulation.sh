#!/bin/bash
# scripts/run_simulation.sh

# Exit on any error
set -e

# Activate the project's conda environment to make the RISC-V toolchain available.
# This is the robust way to ensure this script can find the necessary binaries.
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate amd-dv-sprint

if [ $# -eq 0 ]; then
    echo "Usage: $0 <seed1> [seed2] [seed3] ..."
    exit 1
fi

# Get the project root directory
ROOT_DIR=$(git rev-parse --show-toplevel)
cd "$ROOT_DIR"

# Define the RISC-V toolchain prefix. This may need to be adjusted
# depending on how the toolchain was installed (e.g., riscv32-unknown-elf).
export RISCV_PREFIX="riscv64-unknown-elf"

# Regression counters
pass_count=0
fail_count=0

# Loop through all the provided seeds
for seed in "$@"; do
    echo "========================================================="
    echo "           Running RTL Simulation for SEED = ${seed}"
    echo "========================================================="
    
    TEST_NAME="riscv_arithmetic_basic_test"
    
    # Find the output directory for this specific test
    # This is a bit brittle, assumes a single out_* directory
    OUT_DIR=$(ls -d out_*/)
    # The generator creates a file with index _0, not the seed. Find the compiled object.
    ELF_FILE=$(find "${OUT_DIR}asm_test" -name "*.o" | head -n 1)
    if [ -z "$ELF_FILE" ]; then
        echo "Error: No .o file found in ${OUT_DIR}asm_test. Did 'make compile_asm' run?"
        exit 1
    fi
    MEM_FILE="${ELF_FILE}.mem"
    BIN_FILE="${ELF_FILE}.bin"
    RTL_LOG_FILE="${OUT_DIR}rtl_trace_${seed}.log"
    # Point to the raw text log from the spike simulation.
    SPIKE_LOG_FILE="${OUT_DIR}spike_sim/riscv_arithmetic_basic_test_0.log"

    # Define paths for the standardized CSV files
    SPIKE_CSV_FILE="${OUT_DIR}spike_trace_${seed}.csv"
    RTL_CSV_FILE="${OUT_DIR}rtl_trace_${seed}.csv"

    # 1. Convert ELF to a memory file our simulation can read.
    echo "--- Converting ELF to Verilog memory format ---"
    # First, create a raw binary file.
    ${RISCV_PREFIX}-objcopy -O binary "$ELF_FILE" "$BIN_FILE"
    # Then, convert the binary to a text file with one 32-bit binary word per line.
    python3 scripts/bin_conv.py "$BIN_FILE" "$MEM_FILE"

    # 2. Convert the Spike log to the standard CSV format
    echo "--- Converting Spike log to CSV ---"
    python3 uvm_env/riscv-dv/scripts/spike_log_to_trace_csv.py \
        --log "$SPIKE_LOG_FILE" \
        --csv "$SPIKE_CSV_FILE"

    # 3. Run the RTL simulation with QuestaSim
    echo "--- Running RTL Simulation ---"
    vsim -c -do "run -all; quit" \
        -sv_lib "$QUESTA_HOME/uvm-1.2/linux_x86_64/uvm_dpi" \
        -cpppath /usr/bin/gcc \
        smoke_top \
        +ram_init_file="$MEM_FILE" \
        +trace_log="$RTL_LOG_FILE"
        
    # 4. Convert the RTL log to the standard CSV format
    echo "--- Converting RTL log to CSV ---"
    python3 scripts/rtl_log_to_csv.py \
        --log "$RTL_LOG_FILE" \
        --csv "$RTL_CSV_FILE" \
        --elf "$ELF_FILE"

    # 5. Compare the trace CSVs
    echo "--- Comparing RTL CSV with Spike CSV ---"
    python3 uvm_env/riscv-dv/scripts/instr_trace_compare.py \
        --csv_file_1 "$SPIKE_CSV_FILE" \
        --csv_file_2 "$RTL_CSV_FILE"

    # Capture the exit code of the comparison
    compare_status=$?

    if [ "$compare_status" -eq 0 ]; then
        echo "SEED ${seed}: PASS - CSVs are identical"
        ((pass_count++))
    else
        echo "SEED ${seed}: FAIL - CSV mismatch detected."
        ((fail_count++))
    fi
done

echo "========================================================="
echo "                 REGRESSION SUMMARY"
echo "========================================================="
echo "REPORT: pass = ${pass_count}, fail = ${fail_count}"
echo "========================================================="

if [ "$fail_count" -ne 0 ]; then
    echo "REGRESSION FAILED"
    exit 1
else
    echo "REGRESSION PASSED"
    exit 0
fi 