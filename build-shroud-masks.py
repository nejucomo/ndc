#! /usr/bin/env python

import os
import sys
import argparse


INPUT_SUFFIX='.shroud.map'
OUTPUT_SUFFIX='.shroud.mask'


DESCRIPTION = """
Find all *.%s files and generate corresponding *.%s
files.  The revealed areas should be represented as Basic Wooden Floor
(Iwr) tiles and the shrouded areas should be Dark Flagstones (Urb).
""" % (INPUT_SUFFIX, OUTPUT_SUFFIX)


def main(args = sys.argv[1:]):
    # Simply for pretty help:
    argparse.ArgumentParser(description=DESCRIPTION).parse_args(args)

    for bd, ds, fs in os.walk('./nejucomos_dungeon_crawl'):
        for f in fs:
            if f.endswith(INPUT_SUFFIX):
                name = f[:-len(INPUT_SUFFIX)]
                print 'Processing %r' % (name,)
                generate_shroud_mask(os.path.join(bd, name))


def generate_shroud_mask(stem):
    with file(stem + INPUT_SUFFIX) as f:
        rows = parse_map_to_bits(f)

    columns = transpose(rows)

    with file(stem + OUTPUT_SUFFIX, 'w') as f:
        for column in columns:
            f.write('|%s\n' % (''.join(column),))


def parse_map_to_bits(f):
    """This may be specific to the 1.10 editor; ie, somewhat brittle."""
    lines = f.readlines()

    # header = lines[:3] # Ignored for now.

    rows = []
    for line in lines[3:]:  # Skip the header.
        column = []

        for field in line.split(','):
            subfields = field.strip().split()
            if len(subfields) == 2:
                int(subfields.pop(0)) # Verify it's a start marker.
            [tilekey] = subfields
            bit = {'Iwr': '1', 'Urb': '0'}[tilekey]
            column.append(bit)

        rows.append(column)

    return rows


def transpose(matrix):
    return zip(*matrix)



if __name__ == '__main__':
    main()
