#!/usr/bin/env python

from noir import EnvironmentConfig, StreamEnvironment
from noir.stream.expressions import col, lit
import sys

path = sys.argv[1]
config = EnvironmentConfig.default()
env = StreamEnvironment(config)
res = env.opt_stream(path).filter(col(0) > 50).collect()
env.execute()