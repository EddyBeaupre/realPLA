#!/usr/bin/env python3

from array import array

def bit(v, pos):
    return ((v >> pos) & 1)

def main():
    f = open('PLA.BIN', 'rb')
    dump = array('B')
    dump.fromfile(f, 0x10000)
    fmt = 24 * '{}'
    for i in range(0x10000):
        o = dump[i]
        print(fmt.format(
            bit(i, 1),  bit(i, 2),  bit(i, 3),  bit(i, 4),      # n_cas    n_loram n_hiram  n_charen
            bit(i, 5),  bit(i, 6),  bit(i, 7),  bit(i, 12),     # n_va14   a15     a14      a13
            bit(i, 14), bit(i, 13), bit(i, 8),  bit(i, 9),      # a12      ba      n_aec    rd 
            bit(i, 11), bit(i, 15), bit(i, 10), bit(i, 0),      # n_exrom  n_game  va13     va12
            bit(o, 6),  bit(o, 5),  bit(o, 4),  bit(o, 3),      # n_casram n_basic n_kernal n_charrom
            bit(o, 2),  bit(o, 1),  bit(o, 0),  bit(o, 7)       # n_grw    n_io    n_roml   n_romh
        ))

if __name__ == "__main__":
    main()
