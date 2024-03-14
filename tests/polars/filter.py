#!/usr/bin/env python

import polars as pl
import sys

path = sys.argv[1]
res = pl.scan_csv(path)\
    .filter(pl.col("0") >= 50)\
    .select(pl.col("1"))\
    .collect()
