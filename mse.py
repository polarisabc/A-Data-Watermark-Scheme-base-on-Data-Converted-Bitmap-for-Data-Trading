import pandas as pd
import numpy as np

original_path = 'creditcard.csv'
watermarked_path = 'watermarked.csv'
index_path = 'data_index.npy'

def mse(df1, df2, index):
    error = 0.0
    for _, row, col in index:
        row = int(row)
        col = str(col)
        value1 = float(df1.at[row, col])
        value2 = float(df2.at[row, col])
        error += (value1-value2) * (value1-value2)
    error /= len(index)
    return error

if __name__ == '__main__':
    original_csv = pd.read_csv(original_path)
    watermarked_csv = pd.read_csv(watermarked_path)
    index = np.load(index_path)
    error = mse(original_csv, watermarked_csv, index)
    print('MSE error = ', error)