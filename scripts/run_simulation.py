#!/usr/bin/env python3
# scripts/run_simulation.py
#
# Copyright (c) 2025 Igor Bogdanov
# All rights reserved.

"""
This script runs RTL simulation and compares results with Spike reference.
"""

import sys
import os
import subprocess
import glob
import re
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


def find_output_directory():
    """Find the output directory (assumes only one 'out_*' directory exists)"""
    out_dirs = glob.glob("out_*/")
    if not out_dirs:
        print("Error: Output directory (out_*) not found.", file=sys.stderr)
        sys.exit(1)
    return out_dirs[0]


def find_elf_file(out_dir, seed):
    """Find the compiled ELF object for a specific seed in the assembly test directory"""
    asm_dir = os.path.join(out_dir, "asm_test")
    test_name = os.environ.get("DEFAULT_TEST_NAME", "riscv_arithmetic_basic_test")

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


def convert_elf_to_mem(elf_file, riscv_prefix):
    """Convert ELF to Verilog memory format"""
    bin_file = f"{elf_file}.bin"
    mem_file = f"{elf_file}.mem"

    print("--- Converting ELF to Verilog memory format ---")

    # First, create a raw binary file
    objcopy_cmd = [f"{riscv_prefix}-objcopy", "-O", "binary", elf_file, bin_file]
    try:
        subprocess.run(objcopy_cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running objcopy: {e}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError:
        print(
            f"Error: '{riscv_prefix}-objcopy' not found. Is the RISC-V toolchain installed?",
            file=sys.stderr,
        )
        sys.exit(1)

    # Then, convert the binary to a text file with one 32-bit binary word per line
    bin_conv_cmd = ["python3", "scripts/bin_conv.py", bin_file, mem_file]
    try:
        subprocess.run(bin_conv_cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running bin_conv.py: {e}", file=sys.stderr)
        sys.exit(1)

    return mem_file


def convert_spike_log_to_csv(spike_log_file, spike_csv_file):
    """Convert the Spike log to the standard CSV format"""
    print("--- Converting Spike log to CSV ---")

    cmd = [
        "python3",
        "uvm_env/riscv-dv/scripts/spike_log_to_trace_csv.py",
        "--log",
        spike_log_file,
        "--csv",
        spike_csv_file,
    ]

    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error converting Spike log to CSV: {e}", file=sys.stderr)
        sys.exit(1)


def run_rtl_simulation(mem_file, rtl_log_file):
    """Run the RTL simulation with QuestaSim"""
    print("--- Running RTL Simulation ---")

    questa_home = os.environ.get("QUESTA_HOME")
    if not questa_home:
        print("Error: QUESTA_HOME environment variable not set", file=sys.stderr)
        sys.exit(1)

    host_cc_path = os.environ.get("HOST_CC_PATH", "/usr/bin/gcc")

    # Check if coverage is enabled
    cov_enable = os.environ.get("COV_ENABLE", "0") == "1"

    # Base vsim command
    vsim_cmd = [
        "vsim",
        "-c",
        "-sv_lib",
        f"{questa_home}/uvm-1.2/linux_x86_64/uvm_dpi",
        "-cpppath",
        host_cc_path,
        "smoke_top",
        f"+ram_init_file={mem_file}",
        f"+trace_log={rtl_log_file}",
    ]

    # Add coverage options if enabled
    if cov_enable:
        import time

        timestamp = int(time.time())
        ucdb_file = f"coverage/sim_{timestamp}.ucdb"
        test_name = f"seed_{timestamp}"
        os.makedirs("coverage", exist_ok=True)
        vsim_cmd.extend(["-coverage", "-coverstore", ucdb_file, "-testname", test_name])
        print(f"Coverage enabled - saving to {ucdb_file} with test name {test_name}")

    # Add the do command
    vsim_cmd.extend(["-do", "run -all; quit"])

    try:
        subprocess.run(vsim_cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running RTL simulation: {e}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError:
        print(
            "Error: 'vsim' not found. Is QuestaSim installed and in PATH?",
            file=sys.stderr,
        )
        sys.exit(1)


def convert_rtl_log_to_csv(rtl_log_file, rtl_csv_file, elf_file):
    """Convert the RTL log to the standard CSV format"""
    print("--- Converting RTL log to CSV ---")

    cmd = [
        "python3",
        "scripts/rtl_log_to_csv.py",
        "--log",
        rtl_log_file,
        "--csv",
        rtl_csv_file,
        "--elf",
        elf_file,
    ]

    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error converting RTL log to CSV: {e}", file=sys.stderr)
        sys.exit(1)


def compare_trace_csvs(spike_csv_file, rtl_csv_file):
    """Compare the trace CSVs and return (exit_code, is_failed)"""
    print("--- Comparing RTL CSV with Spike CSV ---")

    cmd = [
        "python3",
        "uvm_env/riscv-dv/scripts/instr_trace_compare.py",
        "--csv_file_1",
        spike_csv_file,
        "--csv_file_2",
        rtl_csv_file,
    ]

    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=False)
        output = result.stdout + result.stderr
        print(output)

        # Check both exit code and output for failure
        is_failed = result.returncode != 0 or "[FAILED]" in output
        return result.returncode, is_failed

    except FileNotFoundError:
        print("Error: instr_trace_compare.py not found", file=sys.stderr)
        sys.exit(1)


def process_seed(seed, out_dir, riscv_prefix):
    """Process a single seed through the simulation pipeline"""
    print("=" * 57)
    print(f"           Running RTL Simulation for SEED = {seed}")
    print("=" * 57)

    test_name = os.environ.get("DEFAULT_TEST_NAME", "riscv_arithmetic_basic_test")

    # Find the compiled ELF file
    elf_file = find_elf_file(out_dir, seed)

    # Define file paths
    rtl_log_file = os.path.join(out_dir, f"rtl_trace_{seed}.log")
    spike_log_file = os.path.join(out_dir, "spike_sim", f"{test_name}_{seed}.log")
    spike_csv_file = os.path.join(out_dir, f"spike_trace_{seed}.csv")
    rtl_csv_file = os.path.join(out_dir, f"rtl_trace_{seed}.csv")

    # Convert ELF to memory file
    mem_file = convert_elf_to_mem(elf_file, riscv_prefix)

    # Convert Spike log to CSV
    convert_spike_log_to_csv(spike_log_file, spike_csv_file)

    # Run RTL simulation
    run_rtl_simulation(mem_file, rtl_log_file)

    # Convert RTL log to CSV
    convert_rtl_log_to_csv(rtl_log_file, rtl_csv_file, elf_file)

    # Compare the CSVs
    exit_code, is_failed = compare_trace_csvs(spike_csv_file, rtl_csv_file)

    if is_failed:
        print(f"SEED {seed}: FAIL - CSV mismatch detected.")
        return False
    else:
        print(f"SEED {seed}: PASS - CSVs are identical")
        return True


def main():
    if len(sys.argv) < 2:
        print(
            "Usage: python3 scripts/run_simulation.py <seed1> [seed2] [seed3] ...",
            file=sys.stderr,
        )
        sys.exit(1)

    # Convert seed arguments to integers
    try:
        seeds = [int(seed) for seed in sys.argv[1:]]
    except ValueError:
        print("Error: All seeds must be integers.", file=sys.stderr)
        sys.exit(1)

    # Get project root and change to it
    root_dir = get_project_root()
    os.chdir(root_dir)

    # Get RISC-V toolchain prefix
    riscv_prefix = os.environ.get("RISCV_PREFIX", "riscv64-unknown-elf")

    # Find the output directory
    out_dir = find_output_directory()

    # Process each seed
    pass_count = 0
    fail_count = 0

    for seed in seeds:
        if process_seed(seed, out_dir, riscv_prefix):
            pass_count += 1
        else:
            fail_count += 1

    # Print summary
    print("=" * 57)
    print("                 REGRESSION SUMMARY")
    print("=" * 57)
    print(f"REPORT: pass = {pass_count}, fail = {fail_count}")
    print("=" * 57)

    if fail_count != 0:
        print("REGRESSION FAILED")
        sys.exit(1)
    else:
        print("REGRESSION PASSED")
        sys.exit(0)


if __name__ == "__main__":
    main()
