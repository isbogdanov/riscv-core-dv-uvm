#!/usr/bin/python

# Author: Igor Bogdanov

import sys, getopt


def main(argv):
    try:
        with open(argv[0]) as f:
            for line in f:
                # print(line)
                hex_str = line[2:-1]

                # print(hex_str)

                int_num = int(hex_str, base=16)
                print("{0:032b}".format(int_num))
            f.close()
    except IOError:
        sys.exit(2)


if __name__ == "__main__":
    main(sys.argv[1:])
