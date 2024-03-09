#!/usr/bin/env python

import pandas as pd
import sys
path = sys.argv[1]
df = pd.read_csv(path)
df["sum"] = df["0"] + df["2"]
res = df.groupby(df["1"] % 10)["sum"].mean()
