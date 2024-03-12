#!/usr/bin/env python

from noir import EnvironmentConfig, StreamEnvironment, col
import sys

config = EnvironmentConfig.from_args()
env = StreamEnvironment(config)
other = env.opt_stream(sys.argv[3])
res = env.opt_stream(sys.argv[4])\
    .join(other, left_on=col(0), right_on=col(0))\
    .filter(col(1) > col(11))\
    .collect()
env.execute()
