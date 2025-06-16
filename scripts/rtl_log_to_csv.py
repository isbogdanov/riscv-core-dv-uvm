#!/usr/bin/env python3
# scripts/rtl_log_to_csv.py

import sys
import re
import csv
import subprocess
import argparse


def disassemble_elf(elf_file):
    """
    Disassembles the given ELF file using objdump and returns a dictionary
    mapping PC addresses to their instruction and operands.
    """
    disassembly_map = {}
    try:
        # Command to run objdump
        cmd = ["riscv64-unknown-elf-objdump", "-d", elf_file]
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)

        # Regex to parse objdump output lines, e.g., "80000000: f14022f3 csrr t0,mhartid"
        # It handles both standard instructions and those with operands.
        objdump_pattern = re.compile(
            r"^\s*([0-9a-fA-F]+):\s+[0-9a-fA-F]+\s+([a-zA-Z_.]+)\s*(.*)$"
        )

        for line in result.stdout.splitlines():
            match = objdump_pattern.match(line)
            if match:
                pc, instr, operands = match.groups()
                # Store the disassembled info, stripping any whitespace from operands
                disassembly_map[pc] = {
                    "instr": instr.strip(),
                    "operand": operands.strip(),
                }
    except (subprocess.CalledProcessError, FileNotFoundError) as e:
        print(f"Error running objdump: {e}", file=sys.stderr)
        sys.exit(1)
    return disassembly_map


def main():
    """
    Converts a custom RTL simulation log into the standard riscv-dv
    trace CSV format, enriching it with disassembly from the ELF file.
    """
    parser = argparse.ArgumentParser(
        description="Convert RTL log to riscv-dv CSV format."
    )
    parser.add_argument("--log", required=True, help="Input RTL log file")
    parser.add_argument("--csv", required=True, help="Output CSV file")
    parser.add_argument("--elf", required=True, help="ELF file for disassembly")
    args = parser.parse_args()

    # Get the disassembly info from the ELF file first
    disassembly = disassemble_elf(args.elf)

    # Regex to parse our RTL log lines. The GPR part is now optional.
    log_pattern = re.compile(
        r"core\s+\d+:\s+0x([0-9a-fA-F]+)\s+\(0x([0-9a-fA-F]+)\)(?:\s+x(\d+)\s+0x([0-9a-fA-F]+))?"
    )

    # Header must match the format defined in riscv_trace_csv.py
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

            for line in f_in:
                match = log_pattern.match(line)
                if match:
                    pc, binary, rd, rd_val = match.groups()

                    # Look up disassembly info for the current PC
                    disasm_info = disassembly.get(pc, {"instr": "", "operand": ""})

                    gpr_field = ""
                    if rd is not None and rd_val is not None:
                        gpr_field = f"x{rd}:{rd_val}"

                    row_dict = {
                        "pc": pc,
                        "binary": binary,
                        "gpr": gpr_field,
                        "instr": disasm_info["instr"],
                        "operand": disasm_info["operand"],
                        "instr_str": f"{disasm_info['instr']} {disasm_info['operand']}".strip(),
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
