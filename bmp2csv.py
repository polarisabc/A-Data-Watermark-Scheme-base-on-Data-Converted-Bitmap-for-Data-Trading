import pandas as pd
import numpy as np
from PIL import Image
import sys
from mapping import inverse_exponential_mapping

file_path = 'creditcard.csv'
watermarked_path = 'watermarked.csv'
index_path = 'data_index.npy'
bmp_path = 'watermarked.bmp'
random_seed = 42
np.random.seed(random_seed)
size = 1024
cols = np.array(['V' + str(i) for i in range(1, 29)])
col_num = 16
chosen_cols = cols[np.random.choice(len(cols), col_num, replace=False)]

def watermark(df, index, bmp, size, bit_len, mapping=False):
    bmp = np.array(bmp)
    bmp = bmp.reshape(size * size)
    bmp = bmp.astype(np.uint8)
    # np.savetxt('1.txt', bmp, fmt='%d')
    for i in range(size * size):
        bits = int(bmp[i])
        if mapping == True:
            bits = inverse_exponential_mapping(bits)
            bits = int(bits)
        elif bits == 100:
            bits = 99
        bits = str(bits)
        while len(bits) < bit_len:
            bits = '0' + bits
        
        row = int(index[i][1])
        col = str(index[i][2])
        value = df.at[row, col]
        value = str(value)
        if value[-2: ] == '.0':
            value += '1'
        pos_dot = value.find('.')
        pos_e = value.find('e')
        if pos_e != -1:
            if pos_e - pos_dot - 1 < bit_len + 1:
                for _ in range(bit_len + 1 - (pos_e - pos_dot - 1)):
                    value = value[:pos_dot + 1] + '0' + value[pos_dot + 1:]
            value = value[:pos_e - bit_len - 1] + bits + value[pos_e - 1:]
        else:
            if len(value) - pos_dot - 1 < bit_len + 1:
                for _ in range(bit_len + 1 - (len(value) - pos_dot - 1)):
                    value = value[:-1] + '0' + value[-1]
            value = value[:-(bit_len + 1)] + bits + value[-1]
        # print(value)
        df.at[row, col] = float(value)
    return df

if __name__ == '__main__':
    csv = pd.read_csv(file_path)
    index = np.load(index_path)
    bmp = Image.open(bmp_path)
    if sys.argv[1] == 'lsb':
        watermarked_csv = watermark(csv, index, bmp, size, bit_len=2)
    elif sys.argv[1] == 'dct':
        watermarked_csv = watermark(csv, index, bmp, size, bit_len=3, mapping=True)
    watermarked_csv.to_csv(watermarked_path, index=False)