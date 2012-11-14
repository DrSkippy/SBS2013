#!/usr/bin/env python
import sys
import csv
idx = 1
wrt = csv.writer(sys.stdout)
data = []
maxx = -sys.maxint
minx = sys.maxint
for x in csv.reader(sys.stdin):
    try:
        tmp = float(x[idx])
        data.append(x)
        if tmp > maxx:
            maxx = tmp
        if tmp < minx:
            minx = tmp
    except:
            wrt.writerow(x[:idx] + ["scale"] + x[idx:])

for x in data:
    wrt.writerow(x[:idx+1] + [(float(x[idx])-minx)/(maxx-minx)] + x[idx+1:])
