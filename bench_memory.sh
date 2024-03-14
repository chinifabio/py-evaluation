if [ ! -d "mem_results" ]; then
    mkdir mem_results
else
    rm -rf mem_results
    mkdir mem_results
fi

echo "Benchmarking memory usage"
echo "lib,n_row,memory" > mem_results/results.csv

for n_row in 10000 100000 1000000 10000000
do
    for lib in 'noir' 'polars' 'pandas'
    do
        echo "Warming up $lib with $n_row rows"
        for i in {1..10}; do
            echo "Benchmarking $lib with $n_row rows"
            mprof run -o mem_results/join_${lib}_${n_row}_${i}.dat ./tests/$lib/join.py data/${n_row}_10.csv data/1000_10.csv
            mprof run -o mem_results/groupby_${lib}_${n_row}_${i}.dat ./tests/$lib/groupby_mean.py data/${n_row}_10.csv
        done
    done
done

