#!/bin/python

import re;
## to merge data that are incorrectly cut into two rows.
with open("./movies_metadata.csv") as f:
    lines = [];
    a=""
    for line in f:
        if re.match("^adult|True|False.*",line):
            print(a, end="")
            a=line
        else:
            a=a.strip()+line
