n_col=10
for lib in 'noir' 'polars' 'pandas'; do
    for n_row in 10000 100000 1000000 10000000; do
        echo "Benchmarking $lib with $n_row rows and 10 columns"
        for ((i=0;i<5;i++)); do
            mprof run -T 0.01 -o mprof_results/filter_${lib}_${n_row}_${n_col}_row_${i}.dat ./tests/$lib/filter.py data/${n_row}_${n_col}.csv
            mprof run -T 0.01 -o mprof_results/filteragg_${lib}_${n_row}_${n_col}_row_${i}.dat ./tests/$lib/filter_agg.py data/${n_row}_${n_col}.csv
            mprof run -T 0.01 -o mprof_results/groupby_${lib}_${n_row}_${n_col}_row_${i}.dat ./tests/$lib/groupby_mean.py data/${n_row}_${n_col}.csv
            mprof run -T 0.01 -o mprof_results/join_${lib}_${n_row}_${n_col}_row_${i}.dat ./tests/$lib/join.py data/${n_row}_${n_col}.csv data/1000_10.csv ${n_col}
        done
    done
done

n_row=100000
for lib in 'noir' 'polars' 'pandas'; do
    for n_col in 10 100 1000; do
        echo "Benchmarking $lib with $n_row rows and 10 columns"
        for ((i=0;i<5;i++))
            mprof run -T 0.01 -o mprof_results/filter_${lib}_${n_row}_${n_col}_col_${i}.dat ./tests/$lib/filter.py data/${n_row}_${n_col}.csv
            mprof run -T 0.01 -o mprof_results/filteragg_${lib}_${n_row}_${n_col}_col_${i}.dat ./tests/$lib/filter_agg.py data/${n_row}_${n_col}.csv
            mprof run -T 0.01 -o mprof_results/groupby_${lib}_${n_row}_${n_col}_col_${i}.dat ./tests/$lib/groupby_mean.py data/${n_row}_${n_col}.csv
            mprof run -T 0.01 -o mprof_results/join_${lib}_${n_row}_${n_col}_col_${i}.dat ./tests/$lib/join.py data/${n_row}_${n_col}.csv data/1000_10.csv ${n_col}
        done
    done
done