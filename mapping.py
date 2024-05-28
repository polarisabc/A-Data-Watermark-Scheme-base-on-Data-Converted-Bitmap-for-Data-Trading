import numpy as np

def exponential_mapping(x):
    base = 1.05  # 指数函数的底数
    scale = 255 / (np.log(999 + 1) / np.log(base) - np.log(0 + 1) / np.log(base))  # 缩放因子
    
    mapped_value = scale * (np.log(x + 1) / np.log(base) - np.log(0 + 1) / np.log(base))
    mapped_value = int(mapped_value)
    
    return mapped_value

def inverse_exponential_mapping(mapped_value):
    base = 1.05  # 指数函数的底数
    scale = 255 / (np.log(999 + 1) / np.log(base) - np.log(0 + 1) / np.log(base))  # 缩放因子
    
    inv_mapped_value = np.power(base, (mapped_value / scale + np.log(0 + 1) / np.log(base))) - 1
    inv_mapped_value = int(inv_mapped_value)
    
    return inv_mapped_value

if __name__ == '__main__':
    # 测试映射和逆映射
    for x in range(1000):
        mapped_value = exponential_mapping(x)
        inv_mapped_value = inverse_exponential_mapping(mapped_value)
        print(f"{x} -> {mapped_value} -> {inv_mapped_value}")
