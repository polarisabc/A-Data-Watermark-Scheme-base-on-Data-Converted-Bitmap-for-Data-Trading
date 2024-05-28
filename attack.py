import pandas as pd
import numpy as np
import sys
import copy

    


random_seed = 2001
np.random.seed(random_seed)
cols = np.array(['V' + str(i) for i in range(1, 29)])

def swap_column(df, rate):
    row_num = len(df.index)
    swap_num = int(0.5 * rate * row_num)
    for col in cols:
        random_index1 = np.random.choice(row_num, swap_num)
        random_index2 = np.random.choice(row_num, swap_num)
        for i in range(swap_num):
            tmp = df.at[random_index1[i], col]
            df.at[random_index1[i], col] = df.at[random_index2[i], col]
            df.at[random_index2[i], col] = tmp
    return df

def modify_column(df, rate):
    row_num = len(df.index)
    modify_num = int(rate * row_num)
    for col in cols:
        random_index = np.random.choice(row_num, modify_num)
        for row in random_index:
            value = df.at[row, col]
            value = str(value)
            e_pos = value.find('e')
            if e_pos != -1:
                value = value[:e_pos - 1] + value[e_pos:]
            else:
                value = value[:-1]
            value = float(value)
            df.at[row, col] = value
    return df

def add_row(df, rate, pattern):
    add_num = int(rate * len(df.index))
    new_row = pd.Series([0] * len(df.columns), index=df.columns)
    for _ in range(add_num):
        row_num = len(df.index)
        if pattern == 'even':
            random_index = np.random.choice(row_num)
        elif pattern == 'top':
            random_index = np.random.choice(row_num // 2)
        elif pattern == 'mid':
            random_index = np.random.choice(row_num // 2)
            random_index += row_num // 4
        elif pattern == 'bottom':
            random_index = np.random.choice(row_num // 2)
            random_index += row_num // 2
        df = pd.concat([df.iloc[:random_index], pd.DataFrame([new_row]), df.iloc[random_index:]], ignore_index=True)
    return df

def delete_row(df, rate, pattern):
    del_num = int(rate * len(df.index))
    for _ in range(del_num):
        row_num = len(df.index)
        if pattern == 'even':
            random_index = np.random.choice(row_num)
        elif pattern == 'top':
            random_index = np.random.choice(row_num // 2)
        elif pattern == 'mid':
            random_index = np.random.choice(row_num // 2)
            random_index += row_num // 4
        elif pattern == 'bottom':
            random_index = np.random.choice(row_num // 2)
            random_index += row_num // 2
        df = pd.concat([df.iloc[:random_index], df.iloc[random_index + 1:]], ignore_index=True)
    return df

if __name__ == '__main__':
    for i in range(1,2):   
        csv=pd.read_csv('exp_' + str(i) + '_watermarked.csv')
        for rate in [0.2, 0.5]:
            modified_csv = swap_column(copy.deepcopy(csv), rate)
            modified_csv.to_csv('exp_'+str(i)+'_'+'modified_[swap_column]_' + str(rate) + '.csv', index=False)
            modified_csv = modify_column(copy.deepcopy(csv), rate)
            modified_csv.to_csv('exp_'+str(i)+'_'+'modified_[modify_column]_' + str(rate) + '.csv', index=False)
        
