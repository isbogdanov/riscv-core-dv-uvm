#!/usr/bin/env python3
# scripts/run_spike.py
#
# Copyright (c) 2025 Igor Bogdanov
# All rights reserved.

"""
This script runs the Spike instruction set simulator on a pre-compiled
ELF file. This ensures that Spike and the RTL simulation execute the
exact same binary.
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


def find_elf_file(out_dir):
    """Find the compiled ELF object in the assembly test directory"""
    asm_dir = os.path.join(out_dir, "asm_test")
    elf_files = glob.glob(os.path.join(asm_dir, "*.o"))
    if not elf_files:
        print(
            f"Error: No .o file found in {asm_dir}. Did 'make compile_asm' run?",
            file=sys.stderr,
        )
        sys.exit(1)
    return elf_files[0]


def main():
    if len(sys.argv) != 2:
        print("Usage: python3 scripts/run_spike.py <seed>", file=sys.stderr)
        sys.exit(1)

    seed = sys.argv[1]

    # Find the output directory
    out_dir = find_output_directory()

    # Find the compiled ELF file
    elf_file = find_elf_file(out_dir)

    # Create the Spike log directory
    spike_log_dir = os.path.join(out_dir, "spike_sim")
    os.makedirs(spike_log_dir, exist_ok=True)

    # Use environment variables if set, otherwise use defaults
    test_name = os.environ.get("DEFAULT_TEST_NAME", "riscv_arithmetic_basic_test")
    target_isa = os.environ.get("TARGET_ISA", "rv32i")
    spike_cmd = os.environ.get("SPIKE_CMD", "spike")

    # The log file name must match what run_simulation.py expects
    spike_log_file = os.path.join(spike_log_dir, f"{test_name}_0.log")

    print(f"--- Running Spike on {elf_file} ---")

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

        print(f"--- Spike simulation complete. Log at {spike_log_file} ---")

    except subprocess.CalledProcessError as e:
        print(f"Error running Spike: {e}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError:
        print(
            f"Error: '{spike_cmd}' command not found. Is Spike installed and in PATH?",
            file=sys.stderr,
        )
        sys.exit(1)


if __name__ == "__main__":
    main()
