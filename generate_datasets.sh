dataset_folder="data"

if [ ! -d "$dataset_folder" ]; then
    mkdir $dataset_folder
else
    rm -rf $dataset_folder
    mkdir $dataset_folder
fi

for n_row in 1000 10000 100000 1000000 10000000; do
    for n_col in 10 100; do
        echo "Generating dataset with $n_row rows and $n_col columns"
        python generator.py --row $n_row --col $n_col > /dev/null
    done
done

for n_col in 10 100 1000; do
    echo "Generating dataset with 100000 rows and $n_col columns"
    python generator.py --row 100000 --col $n_col > /dev/null
done

echo "Datasets generated."
