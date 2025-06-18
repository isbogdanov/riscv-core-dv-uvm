#!/usr/bin/env python3
# scripts/bin_conv.py
#
# Copyright (c) 2025 Igor Bogdanov
# All rights reserved.

import sys


def main():
    """
    Converts a raw binary file into a Verilog-style binary file (one 32-bit
    word per line), suitable for loading with $readmemb.
    """
    if len(sys.argv) != 3:
        print(
            f"Usage: {sys.argv[0]} <input_binary> <output_binary_txt>", file=sys.stderr
        )
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    try:
        with open(input_file, "rb") as f_in, open(output_file, "w") as f_out:
            while True:
                # Read 4 bytes (a 32-bit word) at a time
                word = f_in.read(4)
                if not word:
                    break
                # The last word might be shorter; pad it with null bytes.
                if len(word) < 4:
                    word = word.ljust(4, b"\0")

                # RISC-V is little-endian. Convert the 4-byte word to an integer.
                int_val = int.from_bytes(word, byteorder="little")

                # Format as a 32-digit binary string and write to file.
                f_out.write(f"{int_val:032b}\n")

    except IOError as e:
        print(f"Error converting binary to text: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
