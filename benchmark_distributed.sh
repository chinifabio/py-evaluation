PWD = $(pwd) # current directory, PyNoir needs absolute paths

hyperfine --warmup 3 --export-json hyperfine_results/distributed_groupby_mean_row.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_groupby_mean.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/{n_row}_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_join_row.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_join.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/{n_row}_10.csv ${PWD}/data/1000_10.csv 10"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_filter_row.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_filter.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/{n_row}_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_filter_agg_row.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_filter_agg.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/{n_row}_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_groupby_mean_col.json \
    --ignore-failure \
    --parameter-list n_col 10,100,1000 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_groupby_mean.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/100000_{n_col}.csv"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_join_col.json \
    --ignore-failure \
    --parameter-list n_col 10,100,1000 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_join.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/100000_{n_col}.csv ${PWD}/data/1000_10.csv {n_col}"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_filter_col.json \
    --ignore-failure \
    --parameter-list n_col 10,100,1000 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_filter.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/100000_{n_col}.csv"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_filter_agg_col.json \
    --ignore-failure \
    --parameter-list n_col 10,100,1000 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_filter_agg.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/100000_{n_col}.csv"