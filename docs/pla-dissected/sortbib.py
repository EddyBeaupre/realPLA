#!/usr/bin/env python3
import sys

def caseinsensitive_sort(stringList):
    """case-insensitive string comparison sort
    doesn't do locale-specific compare
    though that would be a nice addition
    usage: stringList = caseinsensitive_sort(stringList)"""

    tupleList = [(x.lower(), x) for x in stringList]
    tupleList.sort()
    return [x[1] for x in tupleList]

def main():
    lines = []
    txt = ''
    for l in sys.stdin:
        l = l.strip()
        if l == '':
            lines.append(txt.strip())
            txt = ''
        else:
            txt = txt + ' ' + l
    # handle last line too
    if txt != '':
        lines.append(txt.strip())
    lines = caseinsensitive_sort(lines)
    for l in lines:
        print(l)

if __name__ == "__main__":
    main()
