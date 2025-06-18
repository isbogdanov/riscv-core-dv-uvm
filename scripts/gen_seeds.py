#!/usr/bin/env python3
# scripts/gen_seeds.py
#
# Copyright (c) 2025 Igor Bogdanov
# All rights reserved.

import sys
import random


def generate_seeds(num_seeds):
    """Generate a specified number of unique random seeds."""
    if num_seeds <= 0:
        return []
    # Generate seeds in a wide range to ensure variety
    return random.sample(range(1, 1_000_000), num_seeds)


def main():
    """
    Main function to generate seeds based on command-line argument.
    Prints seeds to standard output, one per line.
    """
    if len(sys.argv) != 2:
        print("Usage: python3 scripts/gen_seeds.py <number_of_seeds>", file=sys.stderr)
        sys.exit(1)

    try:
        num_seeds_to_generate = int(sys.argv[1])
        if num_seeds_to_generate <= 0:
            raise ValueError
    except ValueError:
        print(
            "Error: Please provide a positive integer for the number of seeds.",
            file=sys.stderr,
        )
        sys.exit(1)

    seeds = generate_seeds(num_seeds_to_generate)
    for seed in seeds:
        print(seed)


if __name__ == "__main__":
    main()
