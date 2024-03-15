if [ ! -d "data" ]; then
    mkdir data
fi

if [ ! -d "hyperfine_results" ]; then
    mkdir hyperfine_results
fi

if [ ! -d "mprof_results" ]; then
    mkdir mprof_results
fi

hyperfine --warmup 3 --export-json hyperfine_results/groupby_mean_row.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/groupby_mean.py data/{n_row}_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/join_row.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/join.py data/{n_row}_10.csv data/1000_10.csv 10"

hyperfine --warmup 3 --export-json hyperfine_results/filter_row.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/filter.py data/{n_row}_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/filter_agg_row.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/filter_agg.py data/{n_row}_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/groupby_mean_col.json \
    --parameter-list n_col 10,100,1000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/groupby_mean.py data/100000_{n_col}.csv"

hyperfine --warmup 3 --export-json hyperfine_results/join_col.json \
    --parameter-list n_col 10,100,1000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/join.py data/100000_{n_col}.csv data/1000_10.csv {n_col}"

hyperfine --warmup 3 --export-json hyperfine_results/filter_col.json \
    --parameter-list n_col 10,100,1000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/filter.py data/100000_{n_col}.csv"

hyperfine --warmup 3 --export-json hyperfine_results/filter_agg_col.json \
    --parameter-list n_col 10,100,1000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/filter_agg.py data/100000_{n_col}.csv"
