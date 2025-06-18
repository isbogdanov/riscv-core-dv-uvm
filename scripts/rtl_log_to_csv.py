#!/usr/bin/env python3
# scripts/rtl_log_to_csv.py
#
# Copyright (c) 2025 Igor Bogdanov
# All rights reserved.

import sys
import re
import csv
import subprocess
import argparse

# Standard RISC-V ABI register names for RV32I
ABI_NAMES = [
    "zero",
    "ra",
    "sp",
    "gp",
    "tp",
    "t0",
    "t1",
    "t2",
    "s0",
    "s1",
    "a0",
    "a1",
    "a2",
    "a3",
    "a4",
    "a5",
    "a6",
    "a7",
    "s2",
    "s3",
    "s4",
    "s5",
    "s6",
    "s7",
    "s8",
    "s9",
    "s10",
    "s11",
    "t3",
    "t4",
    "t5",
    "t6",
]


def disassemble_elf(elf_file):
    """
    Disassembles the given ELF file and finds the start address of the main test.
    The riscv-dv standard boot flow jumps to the 'h0_start' label.
    """
    disassembly_map = {}
    start_pc = None
    try:
        # Get the address of the main test label
        cmd_sym = ["riscv64-unknown-elf-objdump", "-t", elf_file]
        result_sym = subprocess.run(cmd_sym, capture_output=True, text=True, check=True)
        for line in result_sym.stdout.splitlines():
            if " h0_start" in line:
                start_pc = line.split()[0]
                break

        # Get the full disassembly for enriching the log
        cmd_dis = ["riscv64-unknown-elf-objdump", "-d", elf_file]
        result_dis = subprocess.run(cmd_dis, capture_output=True, text=True, check=True)
        objdump_pattern = re.compile(
            r"^\s*([0-9a-fA-F]+):\s+[0-9a-fA-F]+\s+([a-zA-Z_.]+)\s*(.*)$"
        )
        for line in result_dis.stdout.splitlines():
            match = objdump_pattern.match(line)
            if match:
                pc, instr, operands = match.groups()
                disassembly_map[pc] = {
                    "instr": instr.strip(),
                    "operand": operands.strip(),
                }
    except (subprocess.CalledProcessError, FileNotFoundError) as e:
        print(f"Error running objdump: {e}", file=sys.stderr)
        sys.exit(1)

    if not start_pc:
        # Fallback if the standard label isn't found
        print(
            "Warning: Could not find 'h0_start' symbol. Starting trace from 0x80000000.",
            file=sys.stderr,
        )
        start_pc = "80000000"

    return disassembly_map, start_pc


def main():
    parser = argparse.ArgumentParser(
        description="Convert RTL log to riscv-dv CSV format."
    )
    parser.add_argument("--log", required=True, help="Input RTL log file")
    parser.add_argument("--csv", required=True, help="Output CSV file")
    parser.add_argument(
        "--elf", required=True, help="ELF file for disassembly and start address"
    )
    args = parser.parse_args()

    disassembly, start_pc_str = disassemble_elf(args.elf)
    start_pc_val = int(start_pc_str, 16)

    log_pattern = re.compile(
        r"core\s+\d+:\s+(?:\d\s)?0x([0-9a-fA-F]+)\s+\(0x([0-9a-fA-F]+)\)(?:\s+x(\d+)\s+0x([0-9a-fA-F]+))?"
    )

    csv_header = [
        "pc",
        "instr",
        "gpr",
        "csr",
        "binary",
        "mode",
        "instr_str",
        "operand",
        "pad",
    ]

    try:
        with open(args.log, "r") as f_in, open(args.csv, "w", newline="") as f_out:
            writer = csv.DictWriter(f_out, fieldnames=csv_header)
            writer.writeheader()

            # This flag ensures we only start logging after the CPU has reached the
            # actual start of the test program, filtering out any bootloader code.
            test_started = False

            for line in f_in:
                match = log_pattern.match(line)
                if not match:
                    continue

                pc_str, binary, rd_str, rd_val = match.groups()
                pc_val = int(pc_str, 16)

                # The RTL log starts at 0x80000000, which is where the test code begins.
                # The check for start_pc_val is more relevant if there's a preceding bootloader.
                # To be safe, we check if we've reached the known start symbol.
                if not test_started and pc_val >= int("80000000", 16):
                    test_started = True

                if not test_started:
                    continue

                # To match the Spike CSV, we ONLY log instructions that commit a GPR write.
                # The Spike log does not produce a commit line for writes to x0, so the
                # Spike conversion script implicitly filters them. We must do so explicitly.
                if rd_str is None or rd_val is None or rd_str == "0":
                    continue

                disasm_info = disassembly.get(
                    pc_str.lower(), {"instr": "unknown", "operand": ""}
                )

                rd_idx = int(rd_str)
                if rd_idx < len(ABI_NAMES):
                    gpr_field = f"{ABI_NAMES[rd_idx]}:{rd_val}"
                else:
                    gpr_field = f"x{rd_idx}:{rd_val}"

                # To match Spike's formatting, the instruction mnemonic is padded
                # to a fixed width before the operands are appended.
                mnemonic = disasm_info["instr"]
                operands = disasm_info["operand"].split("#")[0].strip()

                # Spike's disassembler adds a space after commas, but objdump doesn't.
                # We add it here to ensure a perfect match.
                operands_with_space = operands.replace(",", ", ")

                # Spike uses a field width of 8 for the mnemonic
                padded_mnemonic = f"{mnemonic:<7}"

                instr_str = f"{padded_mnemonic} {operands_with_space}".strip()

                row_dict = {
                    "pc": pc_str,
                    "binary": binary,
                    "gpr": gpr_field,
                    "instr": "",
                    "operand": "",
                    "instr_str": instr_str,
                    "csr": "",
                    "mode": "3",
                    "pad": "",
                }
                writer.writerow(row_dict)

    except IOError as e:
        print(f"Error converting RTL log to CSV: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
