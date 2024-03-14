#!/usr/bin/env python

import pandas as pd
import sys
path = sys.argv[1]
df = pd.read_csv(path)
filtered = df[df["0"] >= 50]
final = filtered["1"]
