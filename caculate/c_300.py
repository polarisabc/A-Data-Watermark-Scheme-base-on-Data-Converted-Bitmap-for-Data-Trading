def text_to_binary(text):
    binary_str = ''
    for char in text:
        binary_char = format(ord(char), '07b')  # 转换为7位二进制
        binary_str += binary_char
    return binary_str

def correct_binary_str(binary_str): 
    temp = ''
    corrected_str = ''
    i=0
    while i < len(binary_str)-10:
        temp = binary_str[i:i+11] #获取11位海明码块
        error_str = ''
        error_bit = 0
        error_str += str( (int(temp[0]) + int(temp[2]) +int(temp[4]) +int(temp[6]) +int(temp[8]) +int(temp[10]) )%2 )
        error_str += str( (int(temp[1]) + int(temp[2]) +int(temp[5]) +int(temp[6]) +int(temp[9]) +int(temp[10]) )%2 )
        error_str += str( (int(temp[3]) + int(temp[4]) +int(temp[5]) +int(temp[6]) )%2 )
        error_str += str( (int(temp[7]) + int(temp[8]) +int(temp[9]) +int(temp[10]) )%2 )
        #error_bit = int(error_str[0])*1 + int(error_str[1])*2 + int(error_str[2])*4 + int(error_str[3])*8
        error_bit = int(error_str, 2)
        if error_bit:
            for j in range(1,12):
                if j==error_bit:
                    if temp[j-1] == '0' :
                         corrected_str += '1'
                    else:
                        corrected_str += '0'
                else:
                    corrected_str += temp[j-1]
        else:
            corrected_str += temp
        
        i +=11
    
    #剩余
   # k = len(binary_str)%11
    #j = 0
   # m = k*11
    
    #corrected_str += binary_str[len(binary_str)-k:len(binary_str)]
    
    return corrected_str

#去除冗余码，提取有效信息
def original(corrected_str):
    temp = ''
    original_str = ''
    i=0
    while i < len(corrected_str)-10:
        temp = binary_str[i:i+11] #获取11位海明码块
        original_str += temp[2] + temp[4] + temp[5] + temp[6] + temp[8] + temp[9] + temp[10]
        i +=11
    
    #剩余
    #k = len(corrected_str)%11
    #j = 0
  #  m = k*11
    
   # original_str += corrected_str[len(corrected_str)-k:len(corrected_str)]

    #去除多余的前导零
    end_str = ''
    p = len(original_str)%7 #多余的前导0的个数
    end_str += original_str[0 : len(original_str)-7]
    end_str += original_str[len(original_str)-7+p : len(original_str) ]
    

    return end_str
    



def binary_to_text(binary_str):
    text = ''
    i = 0
    while i < len(binary_str):
        binary_char = binary_str[i:i+7]  # 获取7位二进制字符
        char = chr(int(binary_char, 2))  # 转换为ASCII字符
        text += char
        i += 7
    return text



def calculate_match_percentage(file1_path, file2_path):
    with open(file1_path, 'r') as file1, open(file2_path, 'r') as file2:
        text1 = file1.read()
        text2 = file2.read()
        text1 = text1[0:300]
        text2 = text2[0:300]
        # 计算两个文本的长度
        length1 = len(text1)
        length2 = len(text2)

        # 找出两个文本中较短的长度
        min_length = min(length1, length2)

        # 计算匹配字符的数量
        match_count = sum(1 for i in range(min_length) if text1[i] == text2[i])

        # 计算匹配度百分比
        match_percentage = (match_count / length1) * 100

        # 返回匹配度百分比
        return match_percentage


             
file1_path = 'original.txt'# 第一个文本文件的路径
#for i in (0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5):
filename = 'message.txt'# 读取文本文件
with open(filename, 'r') as file:
        text = file.read()
binary_str = text_to_binary(text)# 将文本转换为二进制串
corrected_str  = correct_binary_str(binary_str)#错误编码块个数
orignial_str = original(corrected_str)#去除冗余位后
effecive_text = binary_to_text(orignial_str)
    #将解码后的文本保存到文件
output_filename = 'verify.txt'
with open(output_filename, 'w') as file:
        file.write(effecive_text)
    
file2_path = 'verify.txt'  # 第二个文本文件的路径

match_percentage = calculate_match_percentage(file1_path, file2_path)
print(f"字符匹配度百分比: {match_percentage:.2f}%")


