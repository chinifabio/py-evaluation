#!/usr/bin/env python

import polars as pl
import sys

path = sys.argv[1]
res = pl.scan_csv(path)\
    .with_columns((pl.col("0") + pl.col("2")).alias("sum"))\
    .group_by(pl.col("1") % 10)\
    .agg(pl.col("sum").mean())\
    .collect()
