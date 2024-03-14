#!/usr/bin/env python

from noir import EnvironmentConfig, StreamEnvironment, col
from noir import max as noir_max
import sys

config = EnvironmentConfig.from_args()
env = StreamEnvironment(config)
env.spown_remote_workers()

res = env.opt_stream(sys.argv[3])\
    .filter(col(0) >= 50)\
    .select(col(1))\
    .collect()
env.execute()