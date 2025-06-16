#!/bin/bash
# scripts/run_regression.sh

# Exit on any error
set -e

# --- Argument parsing ---
# Default to running all steps
STEPS="all"
if [ "$1" == "--steps" ]; then
    STEPS="$2"
    shift 2
fi
# The rest of the arguments are the seeds
SEEDS=("$@")

if [ ${#SEEDS[@]} -eq 0 ]; then
    echo "Error: No seeds provided."
    echo "Usage: $0 [--steps <steps>] <seed1> [seed2]..."
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

# The YAML file that lists available tests
TESTLIST="uvm_env/riscv-dv/yaml/base_testlist.yaml"

# Path to our custom ISS configuration which tells the tool how to run our RTL
ISS_YAML="uvm_env/riscv-dv/target/amd_sprint/iss.yaml"

# Set the PYTHONPATH to include the pygen source directory so the generator
# script can find its modules.
export PYTHONPATH=$PYGEN_SRC_PATH

# The 'run.py' script cleans the output directory by default.
# For any step that is NOT the initial generation, we must tell it *not* to clean,
# so it can find the previously generated files.
NOCLEAN_OPT=""
if [[ "$STEPS" != "all" && "$STEPS" != "gen" ]]; then
    NOCLEAN_OPT="--noclean"
fi

# Loop through all the provided seeds
for seed in "${SEEDS[@]}"; do
    echo "========================================================="
    echo "           Running [${STEPS}] for SEED = ${seed}"
    echo "========================================================="
    
    # We run the same test for each seed, but the seed makes it unique
    TEST_NAME="riscv_arithmetic_basic_test"

    # Run the specified steps of the flow
    python3 "$RISCV_DV_RUN" \
        --test "$TEST_NAME" \
        --testlist "$TESTLIST" \
        --isa rv32imc \
        --simulator "pyflow" \
        --iss spike \
        --iss_yaml "$ISS_YAML" \
        --steps "$STEPS" \
        --iterations 1 \
        --seed "$seed" \
        $NOCLEAN_OPT
done

echo "========================================================="
echo "            REGRESSION [${STEPS}] FINISHED"
echo "=========================================================" 