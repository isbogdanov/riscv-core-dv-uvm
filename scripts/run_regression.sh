#!/bin/bash
# scripts/run_regression.sh

# Exit on any error
set -e

# The rest of the arguments are the seeds
SEEDS=("$@")

if [ ${#SEEDS[@]} -eq 0 ]; then
    echo "Error: No seeds provided."
    echo "Usage: $0 <seed1> [seed2]..."
    exit 1
fi

# --- Script Body ---
# Get the project root directory, so we can run this script from anywhere
ROOT_DIR=$(git rev-parse --show-toplevel)
cd "$ROOT_DIR"

# Path to the riscv-dv runner
RISCV_DV_RUN="uvm_env/riscv-dv/run.py"

# Path to the python generator source, which needs to be in the PYTHONPATH
PYGEN_SRC_PATH="$ROOT_DIR/uvm_env/riscv-dv/pygen"

# The YAML file that lists available tests is now resolved by run.py
# from the custom target directory.

# Path to our custom ISS configuration which tells the tool how to run our RTL
ISS_YAML="uvm_env/riscv-dv/target/amd_sprint_no_c/iss.yaml"

# Set the PYTHONPATH to include the pygen source directory so the generator
# script can find its modules.
export PYTHONPATH=$PYGEN_SRC_PATH

# Loop through all the provided seeds
for seed in "${SEEDS[@]}"; do
    echo "========================================================="
    echo "           Running [gen] for SEED = ${seed}"
    echo "========================================================="
    
    # We run the same test for each seed, but the seed makes it unique
    TEST_NAME="riscv_arithmetic_basic_test"

    # Run the generator step of the flow
    python3 "$RISCV_DV_RUN" \
        --test "$TEST_NAME" \
        --custom_target uvm_env/custom_target/rv32im \
        --target rv32im \
        --isa rv32im \
        --simulator "pyflow" \
        --steps gen \
        --iterations 1 \
        --seed "$seed"
done

echo "========================================================="
echo "            REGRESSION [gen] FINISHED"
echo "=========================================================" 