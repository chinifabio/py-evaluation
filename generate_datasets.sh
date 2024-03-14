dataset_folder="data"

if [ ! -d "$dataset_folder" ]; then
    mkdir $dataset_folder
else
    rm -rf $dataset_folder
    mkdir $dataset_folder
fi

n_col=10
for n_row in 1000 10000 100000 1000000 10000000; do
    echo "Generating dataset with $n_row rows and $n_col columns"
    python generator.py --row $n_row --col $n_col > /dev/null
done

n_row=100000
for n_col in 10 100 1000; do
    echo "Generating dataset with $n_row rows and $n_col columns"
    python generator.py --row $n_row --col $n_col > /dev/null
done

echo "Datasets generated."
