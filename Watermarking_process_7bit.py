def text_to_binary(text):
    binary_str = ''
    for char in text:
        binary_char = format(ord(char), '07b')  # 转换为7位二进制
        binary_str += binary_char
    return binary_str

def encode_hamming(binary_str):
    encoded_str = ''
    i = 0

    while i < len(binary_str)-6 :
        
            data_bits = binary_str[i:i+7]  # 获取7位数据位
            parity_bits = calculate_parity_bits(data_bits)  # 计算4位校验位
            encoded_str += parity_bits[0] + parity_bits[1] + data_bits[0] + parity_bits[2] + data_bits[1] + data_bits[2] + data_bits[3] + parity_bits[3] +data_bits[4] + data_bits[5] + data_bits[6] 
            i += 7
   # return encoded_str
    #k = len(binary_str)%7
    #j = 0
   # m = k*7
    
   # encoded_str += binary_str[len(binary_str)-k:len(binary_str)]
        
           
    return encoded_str

def calculate_parity_bits(data_bits):
    parity_bits = ''
    parity_bits += str((int(data_bits[0]) + int(data_bits[1]) + int(data_bits[3]) + int(data_bits[4]) + int(data_bits[6]) ) % 2)
    parity_bits += str((int(data_bits[0]) + int(data_bits[2]) + int(data_bits[3]) + int(data_bits[5]) + int(data_bits[6]) ) % 2)
    parity_bits += str((int(data_bits[1]) + int(data_bits[2]) + int(data_bits[3]) ) % 2)
    parity_bits += str((int(data_bits[4]) + int(data_bits[5]) + int(data_bits[6]) ) % 2)
    return parity_bits

def binary_to_text(encoded_str):
    text = ''
    i = 0
    while i < len(encoded_str):
        encoded_char = encoded_str[i:i+7]  # 获取7位二进制字符
        char = chr(int(encoded_char, 2))  # 转换为ASCII字符
        text += char
        i += 7
    return text

# 读取文本文件
filename = input("请输入文本文件名（包括路径）：")
with open(filename, 'r') as file:
    text = file.read()

# 将文本转换为二进制串
binary_str = text_to_binary(text)
print("转换为二进制串：", binary_str)
print("位数：",len(binary_str))
# 使用海明码编码
encoded_str = encode_hamming(binary_str)
print("海明码编码结果：", encoded_str)
print("位数：",len(encoded_str))

# 将二进制串转换为文本
decoded_text = binary_to_text(encoded_str)
print("解码后的文本：", decoded_text)

# 将解码后的文本保存到文件
output_filename = input("请输入输出文件名（包括路径）：")
with open(output_filename, 'w') as file:
    file.write(decoded_text)
