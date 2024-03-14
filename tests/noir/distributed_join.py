#!/usr/bin/env python

from noir import EnvironmentConfig, StreamEnvironment, col
import sys

config = EnvironmentConfig.from_args()
env = StreamEnvironment(config)
env.spown_remote_workers()

path = sys.argv[3]
other_path = sys.argv[4]
n_col = int(sys.argv[5])

other = env.opt_stream(path)
res = env.opt_stream(other_path)\
    .join(other, left_on=col(0), right_on=col(0))\
    .filter(col(1) >= col(n_col + 1))\
    .collect()
env.execute()
