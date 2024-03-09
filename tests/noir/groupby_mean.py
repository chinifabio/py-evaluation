#!/usr/bin/env python

from noir import EnvironmentConfig, StreamEnvironment, col, avg
import sys

config = EnvironmentConfig.default()
env = StreamEnvironment(config)
res = env.opt_stream(sys.argv[1])\
    .with_compiled_expression(False)\
    .group_by(col(1) % 10)\
    .select([avg((col(0) + col(2)))])\
    .collect()
env.execute()
