#!/usr/bin/env python

import polars as pl
import sys

path = sys.argv[3]
res = pl.scan_csv(path)\
    .filter(pl.col("0") >= 50)\
    .with_columns((pl.col("0") + pl.col("2")).alias("sum"))\
    .select(pl.max("sum"))\
    .collect()
