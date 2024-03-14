if [ ! -d "data" ]; then
    mkdir data
fi

if [ ! -d "hyperfine_results" ]; then
    mkdir hyperfine_results
fi

if [ ! -d "mprof_results" ]; then
    mkdir mprof_results
fi

hyperfine --warmup 3 --export-json hyperfine_results/groupby_mean.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_col 10,100 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/groupby_mean.py data/{n_row}_{n_col}.csv"

hyperfine --warmup 3 --export-json hyperfine_results/join.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_col 10,100 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/join.py data/{n_row}_{n_col}.csv data/1000_10.csv {n_col}"

hyperfine --warmup 3 --export-json hyperfine_results/filter.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_col 10,100 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/filter.py data/{n_row}_{n_col}.csv"

hyperfine --warmup 3 --export-json hyperfine_results/filter_agg.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_col 10,100 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/filter_agg.py data/{n_row}_{n_col}.csv"

for lib in 'noir' 'polars' 'pandas'; do
    for n_row in 10000 100000 1000000 10000000; do
        for n_col in 10 100; do
            echo "Benchmarking $lib with $n_row rows and $n_col columns"
            mprof run -T 0.01 -o mprof_results/filter_${lib}_${n_row}_${n_col}.dat ./tests/$lib/filter.py data/${n_row}_${n_col}.csv
            mprof run -T 0.01 -o mprof_results/filteragg_${lib}_${n_row}_${n_col}.dat ./tests/$lib/filter_agg.py data/${n_row}_${n_col}.csv
            mprof run -T 0.01 -o mprof_results/groupby_${lib}_${n_row}_${n_col}.dat ./tests/$lib/join.py data/${n_row}_${n_col}.csv
            mprof run -T 0.01 -o mprof_results/join_${lib}_${n_row}_${n_col}.dat ./tests/$lib/join.py data/${n_row}_${n_col}.csv data/1000_10.csv
        done
    done
done

PWD = $(pwd) # current directory, PyNoir needs absolute paths

hyperfine --warmup 3 --export-json hyperfine_results/distributed_groupby_mean.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_col 10,100 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_groupby_mean.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/{n_row}_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_join.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_col 10,100 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_join.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/{n_row}_10.csv ${PWD}/data/1000_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_filter.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_col 10,100 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_filter.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/{n_row}_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/distributed_filter_agg.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list n_col 10,100 \
    --parameter-list n_hosts 2,3,4 \
    "${PWD}/tests/noir/distributed_filter_agg.py -r ${PWD}/{n_hosts}_hosts.yml \
        ${PWD}/data/{n_row}_10.csv"
