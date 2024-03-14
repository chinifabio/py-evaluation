#!/usr/bin/env python

import polars as pl
import sys

path = sys.argv[1]
other_path = sys.argv[2]

other_df = pl.scan_csv(other_path)
res = pl.scan_csv(path)\
    .join(other_df, on="0", how="inner")\
    .filter(pl.col("1") >= pl.col("2_right"))\
    .collect()
