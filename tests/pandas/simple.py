#!/usr/bin/env python

import pandas as pd
import sys
path = sys.argv[3]
df = pd.read_csv(path)
filtered = df[df["0"] >= 50]
max_sum = (filtered["1"] + filtered["2"]).max()
