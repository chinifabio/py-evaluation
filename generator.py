import csv
from random import seed
import numpy as np
from tqdm import tqdm
import argparse
import os

os.makedirs('data', exist_ok=True)

parser = argparse.ArgumentParser(description='Generate a CSV file')
parser.add_argument('--row', type=int, help='Number of rows')
parser.add_argument('--col', type=int, help='Number of columns')
args = parser.parse_args()

np.random.seed(0xdeadc0de)

def generate_csv(row, col, chunk_size=10000):
    filename = f'data/{row}_{col}.csv'
    if os.path.exists(filename):
        print(f'File {filename} already exists')
        return
    with open(filename, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow(list(range(col)))  # Writing header

        for i in tqdm(range(row)):
            if i % chunk_size == 0:
                csvfile.flush()  # Flush the buffer to the file
            csv_writer.writerow(np.random.randint(0, 100, size=col))

generate_csv(args.row, args.col)
