#!/usr/bin/env python

import pandas as pd
import sys
path = sys.argv[1]
other_path = sys.argv[2]
df = pd.read_csv(path)
other_df = pd.read_csv(other_path)
joined = pd.merge(df, other_df, on="0", how="inner")
filtered = joined[joined["1_x"] > joined["1_y"]]

