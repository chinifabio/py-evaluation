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

n_col=10
for lib in 'noir' 'polars' 'pandas'; do
    for n_row in 10000 100000 1000000 10000000; do
        echo "Benchmarking $lib with $n_row rows and 10 columns"
        mprof run -T 0.01 -o mprof_results/filter_${lib}_${n_row}_${n_col}_row.dat ./tests/$lib/filter.py data/${n_row}_${n_col}.csv
        mprof run -T 0.01 -o mprof_results/filteragg_${lib}_${n_row}_${n_col}_row.dat ./tests/$lib/filter_agg.py data/${n_row}_${n_col}.csv
        mprof run -T 0.01 -o mprof_results/groupby_${lib}_${n_row}_${n_col}_row.dat ./tests/$lib/groupby_mean.py data/${n_row}_${n_col}.csv
        mprof run -T 0.01 -o mprof_results/join_${lib}_${n_row}_${n_col}_row.dat ./tests/$lib/join.py data/${n_row}_${n_col}.csv data/1000_10.csv ${n_col}
    done
done

n_row=100000
for lib in 'noir' 'polars' 'pandas'; do
    for n_row in 10000 100000 1000000 10000000; do
        echo "Benchmarking $lib with $n_row rows and 10 columns"
        mprof run -T 0.01 -o mprof_results/filter_${lib}_${n_row}_${n_col}_col.dat ./tests/$lib/filter.py data/${n_row}_${n_col}.csv
        mprof run -T 0.01 -o mprof_results/filteragg_${lib}_${n_row}_${n_col}_col.dat ./tests/$lib/filter_agg.py data/${n_row}_${n_col}.csv
        mprof run -T 0.01 -o mprof_results/groupby_${lib}_${n_row}_${n_col}_col.dat ./tests/$lib/groupby_mean.py data/${n_row}_${n_col}.csv
        mprof run -T 0.01 -o mprof_results/join_${lib}_${n_row}_${n_col}_col.dat ./tests/$lib/join.py data/${n_row}_${n_col}.csv data/1000_10.csv ${n_col}
    done
done
