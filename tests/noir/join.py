#!/usr/bin/env python

from noir import EnvironmentConfig, StreamEnvironment, col
import sys

config = EnvironmentConfig.default()
env = StreamEnvironment(config)

path = sys.argv[1]
other_path = sys.argv[2]
n_col = int(sys.argv[3])

other = env.opt_stream(other_path)
res = env.opt_stream(path)\
    .join(other, left_on=col(0), right_on=col(0))\
    .filter(col(1) >= col(n_col + 1))\
    .collect()
env.execute()
