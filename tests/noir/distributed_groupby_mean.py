#!/usr/bin/env python

from noir import EnvironmentConfig, StreamEnvironment, col, avg
import sys

config = EnvironmentConfig.from_args()
env = StreamEnvironment(config)
env.spown_remote_workers()
res = env.opt_stream(sys.argv[3])\
    .with_compiled_expression(False)\
    .group_by(col(1) % 10)\
    .select([avg((col(0) + col(2)))])\
    .collect()
env.execute()
