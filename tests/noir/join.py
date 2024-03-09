#!/usr/bin/env python

from noir import EnvironmentConfig, StreamEnvironment, col
import sys

config = EnvironmentConfig.default()
env = StreamEnvironment(config)
other = env.opt_stream(sys.argv[2])
res = env.opt_stream(sys.argv[1])\
    .join(other, left_on=col(0), right_on=col(0))\
    .filter(col(1) > col(11))\
    .collect()
env.execute()
