# to clear cache use --prepare 'sync; echo 3 > /proc/sys/vm/drop_caches'
hyperfine --warmup 3 --export-json results/simple.json --export-csv results/simple.csv \
    --parameter-list n_row 1000,10000,100000,1000000 \
    --parameter-list lib pandas,polars,noir \
    --prepare 'sync; echo 3 | sudo tee /proc/sys/vm/drop_caches' \
    --show-output \
    "./tests/{lib}/test_0.py data/{n_row}_100.csv" \

hyperfine --warmup 3 --export-csv results/simple.csv \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000 \
    --parameter-list lib pandas,polars,noir \
    "./tests/{lib}/simple.py data/{n_row}_100.csv"

hyperfine --warmup 3 --export-csv results/groupby_mean.csv \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/groupby_mean.py data/{n_row}_100.csv"

hyperfine --warmup 3 --export-csv results/join.csv \
    --parameter-list n_row 1000,10000,100000,1000000,10000000 \
    --parameter-list lib pandas,polars,noir \
    --ignore-failure \
    "./tests/{lib}/join.py data/{n_row}_100.csv"

# testa filter -> select con più hosts e con più righe
hyperfine --warmup 3 --export-json hyperfine_results/simple.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000 \
    --parameter-list n_hosts 1,2,3,4 \
    --parameter-list lib pandas,polars,noir \
    "/home/fabio/Documents/Noir/py-evaluation/tests/{lib}/simple.py -r /home/fabio/Documents/Noir/py-evaluation/{n_hosts}_hosts.yml /home/fabio/Documents/Noir/py-evaluation/data/{n_row}_100.csv"

hyperfine --warmup 3 --export-json hyperfine_results/simple.json \
    --ignore-failure \
    --parameter-list n_row 1000,10000,100000,1000000 \
    --parameter-list n_hosts 1,2,3,4 \
    "/home/fabio/Documents/Noir/py-evaluation/tests/noir/simple.py -r /home/fabio/Documents/Noir/py-evaluation/{n_hosts}_hosts.yml /home/fabio/Documents/Noir/py-evaluation/data/{n_row}_100.csv"
