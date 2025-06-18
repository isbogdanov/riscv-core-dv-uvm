#!/usr/bin/env python3
# scripts/run_regression.py
#
# Copyright (c) 2025 Igor Bogdanov
# All rights reserved.

"""
This script runs the riscv-dv test generation for multiple seeds.
"""

import sys
import os
import subprocess
from pathlib import Path


def get_project_root():
    """Get the project root directory using git"""
    try:
        result = subprocess.run(
            ["git", "rev-parse", "--show-toplevel"],
            capture_output=True,
            text=True,
            check=True,
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        print(
            "Error: Could not determine project root. Are you in a git repository?",
            file=sys.stderr,
        )
        sys.exit(1)


def run_test_generation(seeds):
    """Run the riscv-dv test generation for the given seeds"""
    root_dir = get_project_root()
    os.chdir(root_dir)

    # Path to the riscv-dv runner
    riscv_dv_run = os.path.join("uvm_env", "riscv-dv", "run.py")

    # Path to the python generator source, which needs to be in the PYTHONPATH
    pygen_src_path = os.path.join(root_dir, "uvm_env", "riscv-dv", "pygen")

    # Set the PYTHONPATH to include the pygen source directory
    env = os.environ.copy()
    if "PYTHONPATH" in env:
        env["PYTHONPATH"] = f"{pygen_src_path}:{env['PYTHONPATH']}"
    else:
        env["PYTHONPATH"] = pygen_src_path

    # Use environment variables for test name and ISA, with defaults
    test_name = os.environ.get("DEFAULT_TEST_NAME", "riscv_arithmetic_basic_test")
    target_isa = os.environ.get("TARGET_ISA", "rv32i")

    # Loop through all the provided seeds
    for seed in seeds:
        print("=" * 57)
        print(f"           Running [gen] for SEED = {seed}")
        print("=" * 57)

        # Build the command arguments
        cmd_args = [
            "python3",
            riscv_dv_run,
            "--test",
            test_name,
            "--target",
            target_isa,
            "--isa",
            target_isa,
            "--simulator",
            "pyflow",
            "--steps",
            "gen",
            "--iterations",
            "1",
            "--seed",
            str(seed),
        ]

        try:
            result = subprocess.run(cmd_args, env=env, check=True)
        except subprocess.CalledProcessError as e:
            print(
                f"Error running test generation for seed {seed}: {e}", file=sys.stderr
            )
            sys.exit(1)

    print("=" * 57)
    print("            REGRESSION [gen] FINISHED")
    print("=" * 57)


def main():
    if len(sys.argv) < 2:
        print("Error: No seeds provided.", file=sys.stderr)
        print(
            "Usage: python3 scripts/run_regression.py <seed1> [seed2]...",
            file=sys.stderr,
        )
        sys.exit(1)

    # Convert seed arguments to integers
    try:
        seeds = [int(seed) for seed in sys.argv[1:]]
    except ValueError:
        print("Error: All seeds must be integers.", file=sys.stderr)
        sys.exit(1)

    run_test_generation(seeds)


if __name__ == "__main__":
    main()
