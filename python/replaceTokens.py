from __future__ import print_function
import sys

## a simple filter to replace the following token strings in the CoNLL output
## file if the POS tag has the identical value:
## `` -> "
## '' -? " 
## -LRB- -> ( 

if len(sys.argv) > 1 and sys.argv[1] == "null":
    for line in sys.stdin:
        print(line,sep='',end='')
else:
    for line in sys.stdin:
        fields = line.split("\t")
        if len(fields) > 4 and fields[1] == fields[4]:
            if fields[1] == "``":
                fields[1] = '"'
            elif fields[1] == "''":
                fields[1] = '"'
            elif fields[1] == "-LRB-":
                fields[1] = "("
            elif fields[1] == "-RRB-":
                fields[1] = ")"
            print("\t".join(fields),sep='',end='')
        else:
            print(line,sep='',end='')

