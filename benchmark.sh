hyperfine --warmup 3 --export-json hyperfine_results/groupby_mean.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/groupby_mean.py data/{n_row}_10.csv"

hyperfine --warmup 3 --export-json hyperfine_results/join.json \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/join.py data/{n_row}_10.csv data/1000_10.csv"

# attenzione: su ogni host devi installare python, pip, py-noir e generare i datasets
hyperfine --warmup 3 --export-json hyperfine_results/simple.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000 \
    --parameter-list n_hosts 1,2,3,4 \
    --parameter-list lib pandas,polars,noir \
    "/home/fabio/Documents/Noir/py-evaluation/tests/{lib}/simple.py -r /home/fabio/Documents/Noir/py-evaluation/{n_hosts}_hosts.yml /home/fabio/Documents/Noir/py-evaluation/data/{n_row}_100.csv"

for lib in 'noir' 'polars' 'pandas'; do
    for in 10000 100000 1000000 10000000; do
        echo "Benchmarking $lib with $n_row rows"
        mprof run ./tests/$lib/join.py data/${n_row}_10.csv data/1000_10.csv -o join_${lib}_${n_row}.dat
        mprof run ./tests/$lib/join.py data/${n_row}_10.csv -o groupby_${lib}_${n_row}.dat
    done
done
