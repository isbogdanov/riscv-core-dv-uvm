#!/usr/bin/env python3
# scripts/run_spike.py
#
# Copyright (c) 2025 Igor Bogdanov
# All rights reserved.

"""
This script runs the Spike instruction set simulator on pre-compiled
ELF files for multiple seeds. This ensures that Spike and the RTL simulation
execute the exact same binaries.
"""

import sys
import os
import subprocess
import glob
from pathlib import Path


def find_output_directory():
    """Find the output directory (assumes only one 'out_*' directory exists)"""
    out_dirs = glob.glob("out_*/")
    if not out_dirs:
        print(
            "Error: Output directory (out_*) not found. Did 'make gen' run successfully?",
            file=sys.stderr,
        )
        sys.exit(1)
    return out_dirs[0]


def find_elf_file(out_dir, seed):
    """Find the compiled ELF object for a specific seed in the assembly test directory"""
    asm_dir = os.path.join(out_dir, "asm_test")
    test_name = os.environ.get("TEST_NAME", "riscv_arithmetic_basic_test")

    # Look for seed-specific ELF file first
    seed_elf_file = os.path.join(asm_dir, f"{test_name}_{seed}.o")
    if os.path.exists(seed_elf_file):
        return seed_elf_file

    # Fallback to default name (for single seed or legacy)
    default_elf_file = os.path.join(asm_dir, f"{test_name}_0.o")
    if os.path.exists(default_elf_file):
        return default_elf_file

    # If neither exists, show what files are available
    elf_files = glob.glob(os.path.join(asm_dir, "*.o"))
    if elf_files:
        print(f"Error: Expected ELF file for seed {seed} not found.", file=sys.stderr)
        print(f"Available ELF files: {elf_files}", file=sys.stderr)
    else:
        print(
            f"Error: No .o files found in {asm_dir}. Did 'make compile_asm' run?",
            file=sys.stderr,
        )
    sys.exit(1)


def run_spike_for_seed(seed, out_dir, elf_file):
    """Run Spike simulation for a single seed"""
    # Create the Spike log directory
    spike_log_dir = os.path.join(out_dir, "spike_sim")
    os.makedirs(spike_log_dir, exist_ok=True)

    # Use environment variables if set, otherwise use defaults
    test_name = os.environ.get("TEST_NAME", "riscv_arithmetic_basic_test")
    target_isa = os.environ.get("TARGET_ISA", "rv32i")
    spike_cmd = os.environ.get("SPIKE_CMD", "spike")

    # Create seed-specific log file name
    spike_log_file = os.path.join(spike_log_dir, f"{test_name}_{seed}.log")

    print(f"--- Running Spike for SEED {seed} on {elf_file} ---")

    # Build the Spike command
    spike_args = [
        spike_cmd,
        "-m0x80000000:0x20000",
        f"--isa={target_isa}",
        "-l",
        "--log-commits",
        elf_file,
    ]

    try:
        # Run Spike and capture both stdout and stderr
        with open(spike_log_file, "w") as log_file:
            result = subprocess.run(
                spike_args, stdout=log_file, stderr=subprocess.STDOUT, check=True
            )

        print(
            f"--- Spike simulation complete for SEED {seed}. Log at {spike_log_file} ---"
        )

        return True

    except subprocess.CalledProcessError as e:
        print(f"Error running Spike for seed {seed}: {e}", file=sys.stderr)
        return False
    except FileNotFoundError:
        print(
            f"Error: '{spike_cmd}' command not found. Is Spike installed and in PATH?",
            file=sys.stderr,
        )
        return False


def main():
    if len(sys.argv) < 2:
        print(
            "Usage: python3 scripts/run_spike.py <seed1> [seed2] [seed3] ...",
            file=sys.stderr,
        )
        sys.exit(1)

    # Convert seed arguments to integers
    try:
        seeds = [int(seed) for seed in sys.argv[1:]]
    except ValueError:
        print("Error: All seeds must be integers.", file=sys.stderr)
        sys.exit(1)

    # Find the output directory
    out_dir = find_output_directory()

    # Process each seed
    success_count = 0
    for seed in seeds:
        elf_file = find_elf_file(out_dir, seed)
        if run_spike_for_seed(seed, out_dir, elf_file):
            success_count += 1

    if success_count != len(seeds):
        print(
            f"Error: Only {success_count}/{len(seeds)} Spike simulations succeeded",
            file=sys.stderr,
        )
        sys.exit(1)

    print(f"--- All {len(seeds)} Spike simulations completed successfully ---")


if __name__ == "__main__":
    main()
