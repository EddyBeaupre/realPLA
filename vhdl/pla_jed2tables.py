#!/usr/bin/env python3
import sys
import os
from getopt import getopt

from pla_parse_jedec import *

pterms = []
sterms = [[], [], [], [], [], [], [], []]
output_inverter = []
table_number = 0

input_name_to_n = {
    "#CAS"      : 0,
    "#LORAM"    : 1,
    "#HIRAM"    : 2,
    "#CHAREN"   : 3,
    "#VA14"     : 4,
    "A15"       : 5,
    "A14"       : 6,
    "A13"       : 7,
    "A12"       : 8,
    "BA"        : 9,
    "#AEC"      : 10,
    "R/#W"      : 11,
    "#EXROM"    : 12,
    "#GAME"     : 13,
    "VA13"      : 14,
    "VA12"      : 15
}

input_n_to_name = (
    "#CAS"  ,
    "#LORAM",
    "#HIRAM",
    "#CHAREN",
    "#VA14" ,
    "A15"   ,
    "A14"   ,
    "A13"   ,
    "A12"   ,
    "BA"    ,
    "#AEC"  ,
    "R/#W"  ,
    "#EXROM",
    "#GAME" ,
    "VA13"  ,
    "VA12"
)

# chip names, not signal names
output_n_to_name = [
    "ram",
    "BASIC",
    "KERNAL",
    "CHARROM",
    "GRW",
    "I/O",
    "ROML",
    "ROMH"
]

# chip names, not signal names
outsig_n_to_name = [
    "#CASRAM",
    "#BASIC",
    "#KERNAL",
    "#CHARROM",
    "#GRW",
    "#IO",
    "#ROML",
    "#ROMH"
]

def calc_fn(fn, inputs):
    sterm = sterms[fn]
    result = False
    for p in sterm:
        pterm = pterms[p]
        product = True
        for p in pterm:
            if inputs[p[0]] == p[1]: # 1 means "not"
                product = False
        result = result or product
    if output_inverter[fn]:
        result = not result
    return result


def set_input(inputs, name, val):
    inputs[input_name_to_n[name]] = val


def update_addr_in_inputs(inputs, addr_hi, rd):
    set_input(inputs, 'A15', (addr_hi >> 3) & 1)
    set_input(inputs, 'A14', (addr_hi >> 2) & 1)
    set_input(inputs, 'A13', (addr_hi >> 1) & 1)
    set_input(inputs, 'A12', (addr_hi >> 0) & 1)
    set_input(inputs, 'R/#W', rd)


def get_active_memory(inputs):
    m = '-'
    for f in range(8):
        r = calc_fn(f, inputs)
        if not r and f != 4: # 4 = GRW, ignore this
            if m == '-':
                m = output_n_to_name[f]
            else:
                m = m + ', ' + output_n_to_name[f]
        if m == 'I/O':
            inputs2 = inputs[:]
            set_input(inputs2, 'BA', 0)
    return m


def print_table_start(outfile):
    outfile.write('''
\\begin{table}[H]
\\begin{minipage}{\\linewidth}
    \\tabletextsize
    \\centering
''')

def print_table_end(outfile):
    outfile.write('''
    \\normalsize
\\end{minipage}
\\end{table}
''')

def print_cpu_table(outfile, lhgx, title_add, text):
    inputs = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    set_input(inputs, '#CAS', 0)
    set_input(inputs, '#AEC', 0)

    outfile.write("\n\\subsubsection{\\#LORAM, \\#HIRAM, \\#GAME, \\#EXROM = " +
                  title_add + "}\n")
    outfile.write(text + "\n")

    print_table_start(outfile)
    outfile.write('''
    \\begin{tabularx}{\\mywidthwide}{>{\\centering}X|c|c|c|c}
        \\toprule
            & \\multicolumn{2}{c|}{\\#CHAREN 1} & \\multicolumn{2}{c}{\\#CHAREN 0} \\\\
        Address         & CPU R & CPU W & CPU R & CPU W \\\\
        \\midrule
''')
    set_input(inputs, '#LORAM', lhgx[0])
    set_input(inputs, '#HIRAM', lhgx[1])
    set_input(inputs, '#GAME',  lhgx[2])
    set_input(inputs, '#EXROM', lhgx[3])

    for addr_hi in range(16):
        update_addr_in_inputs(inputs, addr_hi, rd=1)
        line = "\\texttt{{\\${:04X}}} ".format(0x1000 * addr_hi)

        set_input(inputs, '#CHAREN', 1)
        set_input(inputs, 'R/#W', 1)
        m = get_active_memory(inputs)
        line = line + "& {:<8}".format(m)

        set_input(inputs, 'R/#W', 0)
        m = get_active_memory(inputs)
        line = line + "& {:<8}".format(m)

        set_input(inputs, '#CHAREN', 0)
        set_input(inputs, 'R/#W', 1)
        m = get_active_memory(inputs)
        line = line + "& {:<8}".format(m)

        set_input(inputs, 'R/#W', 0)
        m = get_active_memory(inputs)
        line = line + "& {:<8}".format(m)
        outfile.write(line + '\\\\\n')
    outfile.write('''
        \\bottomrule
    \\end{{tabularx}}
    \\caption{{C64 memory configurations with LHGX = {}}}
    \\label{{tab:cpumem{}}}'''.format(title_add, title_add.replace(' ', '_')))
    print_table_end(outfile)

def print_cpu_table_nocharen(outfile, lhgx, title_add, text):
    inputs = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    set_input(inputs, '#CAS', 0)
    set_input(inputs, '#AEC', 0)
    outfile.write("\n\\subsubsection{\\#LORAM, \\#HIRAM, \\#GAME, \\#EXROM = " +
                  title_add + "}\n")
    outfile.write(text + "\n")

    print_table_start(outfile)
    outfile.write('''
    \\begin{tabularx}{\\mywidthnarrow}{>{\\centering}X|c|c}
        \\toprule
        Address         & CPU R & CPU W \\\\
        \\midrule
''')
    set_input(inputs, '#LORAM', lhgx[0])
    set_input(inputs, '#HIRAM', lhgx[1])
    set_input(inputs, '#GAME',  lhgx[2])
    set_input(inputs, '#EXROM', lhgx[3])

    for addr_hi in range(16):
        update_addr_in_inputs(inputs, addr_hi, rd=1)
        line = "\\texttt{{\\${:04X}}} ".format(0x1000 * addr_hi)

        set_input(inputs, 'R/#W', 1)
        m = get_active_memory(inputs)
        line = line + "& {:<8}".format(m)

        set_input(inputs, 'R/#W', 0)
        m = get_active_memory(inputs)
        line = line + "& {:<8}".format(m)
        outfile.write(line + '\\\\\n')
    outfile.write('''
        \\bottomrule
    \\end{{tabularx}}
    \\caption{{C64 memory configurations with LHGX = {}}}
    \\label{{tab:cpumem{}}}'''.format(title_add, title_add.replace(' ', '_')))
    print_table_end(outfile)


def print_vic_table(outfile, addr_hi, gx, title_add, text):
    inputs = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    set_input(inputs, '#CAS', 0)
    set_input(inputs, '#AEC', 1)
    outfile.write("\n\\subsubsection{\\#GAME, \\#EXROM = " +
                  title_add + "}\n")
    outfile.write(text + "\n")

    print_table_start(outfile)
    outfile.write('''
    \\begin{tabularx}{\\mywidthnarrow}{>{\\centering}X|c|c}
        \\toprule
        VIC         & \#VA14 = 0 & \#VA14 = 1 \\\\
        Addr        & VIC R      & VIC R \\\\
        \\midrule
''')
    set_input(inputs, '#GAME',  gx[0])
    set_input(inputs, '#EXROM', gx[1])
    update_addr_in_inputs(inputs, addr_hi, rd=1)

    for vaddr_hi in range(4):
        set_input(inputs, 'VA13', (vaddr_hi >> 1) & 1)
        set_input(inputs, 'VA12', (vaddr_hi >> 0) & 1)

        line = "\\texttt{{\\${:04X}}} ".format(0x1000 * vaddr_hi)

        set_input(inputs, '#VA14', 0)
        m = get_active_memory(inputs)
        line = line + "& {:<10}".format(m)

        set_input(inputs, '#VA14', 1)
        m = get_active_memory(inputs)
        line = line + "& {:<10}".format(m)

        outfile.write(line + '\\\\\n')
    outfile.write('''
        \\bottomrule
    \\end{{tabularx}}
    \\caption{{VIC-II memory configurations with GX = {}}}
    \\label{{tab:vicmem{}}}'''.format(title_add, title_add.replace(' ', '_')))
    print_table_end(outfile)


def print_vic_table_nova14(outfile, addr_hi, gx, label_add,
                           caption):
    inputs = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    set_input(inputs, '#CAS', 0)
    set_input(inputs, '#AEC', 1)

    print_table_start(outfile)
    outfile.write('''
    \\begin{tabularx}{\\mywidthnarrow}{>{\\centering}X|c}
        \\toprule
        VIC Addr        & VIC R \\\\
        \\midrule
''')
    set_input(inputs, '#GAME',  gx[0])
    set_input(inputs, '#EXROM', gx[1])
    update_addr_in_inputs(inputs, addr_hi, rd=1)

    for vaddr_hi in range(4):
        set_input(inputs, 'VA13', (vaddr_hi >> 1) & 1)
        set_input(inputs, 'VA12', (vaddr_hi >> 0) & 1)

        line = "\\texttt{{\\${:04X}}} ".format(0x1000 * vaddr_hi)
        m = get_active_memory(inputs)
        line = line + "& {:<8}".format(m)

        outfile.write(line + '\\\\\n')
    outfile.write('''
        \\bottomrule
    \\end{tabularx}
''')
    outfile.write('\\caption{{{}}}\n'.format(caption))
    outfile.write('\\label{{tab:vicmem{}}}\n'.format(label_add))
    print_table_end(outfile)



def print_logic_tab(outfile):
    n_inputs = 16
    n_pterms = len(pterms)
    outfile.write(54 * '-' + '\n')
    and_array = [['.' for j in range(n_pterms)] for i in range(n_inputs)]
    n_pterm = 0
    for pterm in pterms:
        for p in pterm:
            if p[1] == 1:
                and_array[p[0]][n_pterm] = '/'
            else:
                and_array[p[0]][n_pterm] = '*'
        n_pterm += 1

    str = '      p '
    n_pterm = 0
    for col in and_array[0]:
        str = str + '{}'.format(int(n_pterm / 10))
        n_pterm += 1
    outfile.write(str + '\n')
    str = '        '
    n_pterm = 0
    for col in and_array[0]:
        str = str + '{}'.format(n_pterm % 10)
        n_pterm += 1
    outfile.write(str + '\n')
    outfile.write('Inputs\n')
    n_line = 0
    for line in and_array:
        str = '{:7} '.format(input_n_to_name[n_line])
        for col in line:
            str = str + '{}'.format(col)
        outfile.write(str + '\n')
        n_line += 1
    n_line = 0
    outfile.write(41 * ' ' + 'Outputs\n')
    for sterm in sterms:
        str = 8 * ' '
        for p in range(n_pterms):
            if p in sterm:
                str = str + '+'
            else:
                str = str + '.'
        if output_inverter[n_line]:
            str = str + ' NOT {:9} '.format(outsig_n_to_name[n_line])
        else:
            str = str + '     {:9} '.format(outsig_n_to_name[n_line])
        outfile.write(str + '\n')
        n_line += 1
    outfile.write(54 * '-' + '\n')



def print_tables(outfile):
    outfile.write('''
\\subsection{CPU Memory Configuration}
''')

    print_cpu_table(outfile, [1, 1, 1, 1], '1111',
                    '''
Table \\ref{tab:cpumem1111} shows the standard memory configuration
(\\$01 = \\#\\$37). No cartridge is attached.
BASIC, I/O and KERNAL are visible to the CPU.
With \\#CHAREN = 0 (\\$01 = \\#\\$33), CHARROM (read) and RAM (write)
are mapped instead of I/O.
''')

    print_cpu_table(outfile, [0, 1, 1, 1], '011x',
                    '''
Table \\ref{tab:cpumem011x} shows the configuration with BASIC banked out
(\\$01 = \\#\\$36). If an 8k cartridge is attached, it is also banked out.
I/O and KERNAL are visible to the CPU.
With \\#CHAREN = 0 (\\$01 = \\#\\$32), CHARROM (read) and RAM (write)
are mapped instead of I/O.
''')

    print_cpu_table(outfile, [1, 0, 0, 0], '1000',
                    '''
Table \\ref{tab:cpumem1000} shows the configuration with
a 16k cartridge attached but banked out (\\$01 = \\#\\$35).
I/O is visible to the CPU.
\\#CHAREN = 0 (\\$01 = \\$31) can be used to hide the I/O space,
but it does not bank in CHARROM.
''')

    print_cpu_table(outfile, [1, 0, 1, 0], '101x',
                    '''
Table \\ref{tab:cpumem101x} shows the configuration with
BASIC and KERNAL banked out (\\$01 = \\#\\$35).
If an 8k cartridge is attached, it is also banked out.
I/O is visible to the CPU.
With \\#CHAREN = 0 (\\$01 = \\#\\$32), CHARROM (read) and RAM (write)
are mapped instead of I/O.
''')

    print_cpu_table_nocharen(outfile, [0, 0, 1, 1], '001x or 00x0',
                             '''
The configurations hown in table \\ref{tab:cpumem001x_or_00x0}
have everything banked out (\\$01 = \\#\\$34 or \\$01 = \\#\\$30).
No cartridge, an 8k or an 16k cartridge is attached.
Only RAM is visible to the CPU.
\\#CHAREN has no effect in this case.
''')

    print_cpu_table(outfile, [1, 1, 0, 0], '1100',
                    '''
Table \\ref{tab:cpumem1100} shows the standard 16k cartridge
configuration (\\$01 = \\#\\$37). A 16k cartridge is attached.
ROML/ROMH, I/O and KERNAL are visible to the CPU.
With \\#CHAREN = 0 (\\$01 = \\#\\$33), CHARROM (read) and RAM (write)
are mapped instead of I/O.
''')

    print_cpu_table(outfile, [0, 1, 0, 0], '0100',
                    '''
The 16k cartridge configuration with ROML banked out
(\\$01 = \\#\\$36) is shown in table \\ref{tab:cpumem0100}.
A 16k cartridge is attached.
ROMH, I/O and KERNAL are visible to the CPU.
With \\#CHAREN = 0 (\\$01 = \\#\\$32), CHARROM (read) and RAM (write)
are mapped instead of I/O.
''')

    print_cpu_table(outfile, [1, 1, 1, 0], '1110',
                    '''
Table \\ref{tab:cpumem1110} shows the standard 8k cartridge
configuration (\\$01 = \\#\\$37). An 8k cartridge is attached.
ROML, BASIC, I/O and KERNAL are visible to the CPU.
With \\#CHAREN = 0 (\\$01 = \\#\\$33), CHARROM (read) and RAM (write)
are mapped instead of I/O.
''')

    print_cpu_table_nocharen(outfile, [0, 0, 0, 1], 'xx01',
                             '''
The Ultimax configuration is shown in table \\ref{tab:cpumemxx01}.
An Ultimax cartridge is attached.
Only 4k RAM, ROML, I/O and ROMH are visible to the CPU.
Note that ROMH is mapped to \\$E000. Memory areas marked with "-"
are not mapped, i.e. read accesses to these areas result in values
depending on the current state of the floating data bus.
Write accesses to ROML or ROMH address space
are forwarded to the cartridge, they have no effect on usual
ROM based cartridges.
\\$01 does not change the memory configuration in this mode.
''')

    outfile.write('''

\\subsection{VIC-II Memory Configuration}
\\label{sec:vic-memory-config}

The VIC-II is able to address 16 kByte of memory, which requires 14
address bits. The C64 has 64 kByte of DRAM, there are 4 VIC-II banks
possible in this memory space.

The two CIA lines \\#VA14 and \\#VA15 are used to map one of these four
RAM areas to the VIC-II address space.
They do not appear in the address column of the tables below, because they
are no address lines controlled by the VIC-II.

\\#VA14 is used by the PLA to decide whether CHARROM has to be visible.

''')

    print_vic_table(outfile, 0x7, [1, 1], '1x or 00',
                    '''
Table \\ref{tab:vicmem1x_or_00} shows the memory map as seen by the VIC-II
when not being in Ultimax mode.
''')

    outfile.write('''\n\\subsubsection{\\#GAME, \\#EXROM = 01}
Table \\ref{tab:vicmem01a} shows the memory map as seen by the
VIC-II in Ultimax mode.
The address lines A12 to A15 of the C64 address bus are
pulled up by RP4 whenever the VIC-II has the bus, so they are
\\%1111 usually.

Table \\ref{tab:vicmem01b}
shows an example where the address lines A12 to A15
are overridden to \\%0111 by an external cartridge.
This shows that a cartridge can hide any internal memory
from the VIC-II and provide data for it on the Expansion Port
This technique is used in the Turbo Chameleon by Individual Computers.
Note that the internal color RAM is still read as usual.
''')

    print_vic_table_nova14(outfile, 0xf, [0, 1], '01a',
        'VIC-II memory configuration with GX = 01')

    print_vic_table_nova14(outfile, 0x7, [0, 1], '01b',
        'VIC-II memory configuration with GX = 01, modified address bus')

###############################################################################
def usage_and_exit(errmsg=None):
    stream = errmsg and sys.stderr or sys.stdout
    stream.write("""Usage: {} [options] <infile.jed.txt> <outfile.txt>

Options:

   --logic                     Print logic table only
   --help (-h)                 Show this usage message
""".format(os.path.basename(sys.argv[0])))
    if errmsg:
        stream.write("\nERROR: %s\n" % (errmsg))
    sys.exit(errmsg and - 1)


###############################################################################
def main():
    try:
        opts, args = getopt(sys.argv[1:], "hv", ["help", "version", "logic"])
    except Exception as e:
        print(str(e), file=sys.stderr)
        return -1

    print_logic_only = False
    for opt, value in opts:
        if opt == "--logic":
            print_logic_only = True
        elif opt == "--help" or opt == "-h":
            usage_and_exit()
        else:
            usage_and_exit("Unknown option '%s'" % (opt))

    if len(args) == 2:
        in_filename = args[0]
        out_filename = args[1]
    else:
        usage_and_exit("Wrong number of arguments.")


    parse_jedec(in_filename, pterms, sterms, output_inverter)

    outfile = open(out_filename, 'wt')

    if print_logic_only:
        print_logic_tab(outfile)
    else:
        print_tables(outfile)

if __name__ == "__main__":
    sys.exit(main())
