sudo apt update && sudo apt upgrade -y
sudo apt install -y python3 python-is-python3 python3-pip
git clone https://github.com/chinifabio/py-evaluation.git
cd py-evaluation
pip install noir-0.2.5-cp37-abi3-manylinux_2_34_x86_64.whl
pip install pandas numpy tqdm
for row in 1000 10000 100000 1000000 10000000; do
    python3 generator.py --row $row --col 10
done
