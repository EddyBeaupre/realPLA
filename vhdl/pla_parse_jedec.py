
import fileinput
import re


def parse_pterm(text):
    pterm = []
    if text != 16 * '00':
        for i in range(16):
            fuses = text[2 * i : 2 * i + 2]
            if fuses == '00':
                #print('Warning: Found 00 in {}, term is always false'.format(text))
                return [];
            elif fuses == '01':
                pterm.append((i, 1))
            elif fuses == '10':
                pterm.append((i, 0))
    return pterm


def product_sum_line(pterms, sterms, pfuses, sfuses):
    #print('Found product/sum fuses {}, {}'.format(pfuses, sfuses));
    if sfuses == 8 * '1':
        pass #print('  unused') # keep it nevertheless just for fun
    if pfuses == 32 * '0':
        pass #print('  always false')
    else:
        # not unused and not always false
        n_pterm = len(pterms)
        pterms.append(parse_pterm(pfuses))
        for i in range(8):
            if sfuses[i] == '0':
                sterms[i].append(n_pterm)


def parse_jedec(in_filename, pterms, sterms, output_inverter):
    f = fileinput.input(in_filename)
    for line in f:
        m = re.match(r"L[0-9]{5} ([01]{32})([01]{8})\*", line)
        if m != None:
            product_sum_line(pterms, sterms, m.group(1), m.group(2))
        else:
            m = re.match(r"L[0-9]{5} ([01]{8})\*", line)
            if m != None:
                oinv = m.group(1)
                for c in oinv:
                    output_inverter.append(int(c))
                #print('found inverter line {}'.format(output_inverter))
    f.close()
