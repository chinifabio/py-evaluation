#!/usr/bin/env python

from noir import EnvironmentConfig, StreamEnvironment, col
from noir import max as noir_max
import sys

config = EnvironmentConfig.default()
env = StreamEnvironment(config)

res = env.opt_stream(sys.argv[1])\
    .filter(col(0) >= 50)\
    .select(col(1))\
    .collect()
env.execute()