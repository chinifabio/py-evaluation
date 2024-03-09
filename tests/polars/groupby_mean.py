#!/usr/bin/env python

import polars as pl
import sys

path = sys.argv[1]
res = pl.scan_csv(path)\
    .select([pl.col("1").alias("key"), (pl.col("0") + pl.col("2")).alias("sum")])\
    .group_by(pl.col("key") % 10)\
    .agg(pl.col("sum").mean())\
    .collect()
