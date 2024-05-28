import pandas as pd
import numpy as np
from PIL import Image
import sys
from mapping import exponential_mapping

file_path = 'creditcard.csv'
index_path = 'data_index.npy'
bmp_save_path = 'original.bmp'
random_seed = 42
np.random.seed(random_seed)
size = 1024
cols = np.array(['V' + str(i) for i in range(1, 29)])
col_num = 16
chosen_cols = cols[np.random.choice(len(cols), col_num, replace=False)]

def random_choice(data_len, num):
    random_index = np.random.choice(data_len, size=num, replace=False)
    return random_index

def select_planA(df, chosen_cols, size):
    data = []
    for col in chosen_cols:
        values = df.loc[:, col].to_numpy()
        values = values[:, np.newaxis]
        for index, value in enumerate(values):
            value = value.tolist()
            value += [index, col]
            data.append(value)
    data = np.array(data)
    random_index = random_choice(len(data), size*size)
    data = data[random_index]
    return data

def select_planB(df, chosen_cols, size):
    data = []
    group_size = len(df.index) // size
    row_num = size // col_num
    for x in range(size):
        chosen_rows = random_choice(group_size, row_num)
        for row in chosen_rows:
            row += group_size * x
            for col in chosen_cols:
                value = df.at[row, col]
                data.append([value, row, col])
    data = np.array(data)
    return data

def select_planC(df, chosen_cols, size):
    data = []
    group_size = len(df.index) // (size // 2 * 3)
    row_num = size // col_num
    for x in range(size // 2 * 3):
        if x % 3 == 0:
            chosen_rows = random_choice(group_size, row_num)
        else:
            chosen_rows = random_choice(group_size, row_num // 2)
        for row in chosen_rows:
            row += group_size * x
            for col in chosen_cols:
                value = df.at[row, col]
                data.append([value, row, col])
    data = np.array(data)
    return data

def generate_bmp(data, size, bit_len, mapping=False):
    bits = []
    cnt = 0
    for value, _, __ in data:
        cnt += 1
        value = str(float(value))
        if value[-2:] == '.0':
            value += '1'
        pos_dot = value.find('.')
        pos_e = value.find('e')
        if pos_e != -1:
            if pos_e - pos_dot - 1 < bit_len + 1:
                for _ in range(bit_len + 1 - (pos_e - pos_dot - 1)):
                    value = value[:pos_dot + 1] + '0' + value[pos_dot + 1:]
            value = value[pos_e - bit_len - 1 : pos_e - 1]
        else:
            if len(value) - pos_dot - 1 < bit_len + 1:
                for _ in range(bit_len + 1 - (len(value) - pos_dot - 1)):
                    value = value[:-1] + '0' + value[-1]
            value = value[-(bit_len + 1) : -1]
        if mapping == True:
            value = exponential_mapping(int(value))
        bits.append(int(value))
    bits = np.array(bits)
    bits = bits.reshape(size, size)
    bits = bits.astype(np.uint8)
    # np.savetxt('2.txt', bits.reshape(size * size), fmt='%d')
    # print(bits)
    bmp = Image.fromarray(bits, mode='L')
    return bmp

if __name__ == '__main__':
    if sys.argv[1] == 'original':
        file_path = 'creditcard.csv'
        bmp_save_path = 'original.bmp'
    elif sys.argv[1] == 'verify':
        file_path = 'watermarked.csv'
        bmp_save_path = 'verify.bmp'
    else:
        raise Exception('Invalid Argument Value')
    csv = pd.read_csv(file_path)
    if sys.argv[2] == 'planA':
        data = select_planA(csv, chosen_cols, size)
    elif sys.argv[2] == 'planB':
        data = select_planB(csv, chosen_cols, size)
    elif sys.argv[2] == 'planC':
        data = select_planC(csv, chosen_cols, size)
    else:
        raise Exception('Invalid Argument Value')
    if sys.argv[1] == 'original':
        np.save(index_path, data)
    if sys.argv[3] == 'lsb':
        bmp = generate_bmp(data, size, bit_len=2)
    elif sys.argv[3] == 'dct':
        bmp = generate_bmp(data, size, bit_len=3, mapping=True)
    else:
        raise Exception('Invalid Argument Value')
    bmp.save(bmp_save_path)