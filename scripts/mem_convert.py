#!/usr/bin/env python3
# scripts/mem_convert.py
#
# Copyright (c) 2025 Igor Bogdanov
# All rights reserved.

"""
This script converts all generated ELF files into the Verilog .mem format
by reusing the conversion logic from the main simulation script.
"""

import sys
import os
import glob
from run_simulation import find_elf_file, convert_elf_to_mem


def main():
    """Main entry point"""
    # Get RISC-V toolchain prefix
    riscv_prefix = os.environ.get("RISCV_PREFIX", "riscv64-unknown-elf")

    # Find the output directory
    out_dirs = glob.glob("out_*/")
    if not out_dirs:
        print("Error: Output directory (out_*) not found.", file=sys.stderr)
        sys.exit(1)
    out_dir = out_dirs[0]

    # Find the seed file
    seed_file = "logs/seeds.txt"
    if not os.path.exists(seed_file):
        print(f"Error: Seed file '{seed_file}' not found.", file=sys.stderr)
        sys.exit(1)

    # Process each seed
    with open(seed_file, "r") as f:
        for seed in f:
            seed = seed.strip()
            if not seed:
                continue

            print(f"--- Converting ELF for SEED = {seed} ---")
            elf_file = find_elf_file(out_dir, seed)
            convert_elf_to_mem(elf_file, riscv_prefix)


if __name__ == "__main__":
    main()
