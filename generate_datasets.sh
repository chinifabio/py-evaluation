dataset_folder = "data"

if [ ! -d "$dataset_folder" ] then
    mkdir $dataset_folder
fi

for n_row in 10000 100000 1000000 10000000; do
    for n_col in 10 100 1000; do
        python generator.py --row $n_row --col $n_col > /dev/null
    done
done

python generator.py --row 1000 --col 10
mv $dataset_folder/1000_10.csv $dataset_folder/other.csv

echo "Datasets generated."
