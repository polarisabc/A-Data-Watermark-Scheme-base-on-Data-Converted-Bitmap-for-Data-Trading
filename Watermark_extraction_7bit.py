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






# 读取文本文件
filename = input("请输入文本文件名（包括路径）：")
with open(filename, 'r') as file:
    text = file.read()

# 将文本转换为二进制串
binary_str = text_to_binary(text)
print("转换为二进制串：", binary_str)
print("位数：",len(binary_str))

#错误编码块个数
corrected_str  = correct_binary_str(binary_str)

#纠错后的二进制串
print("纠错后的二进制串：",corrected_str)
print("位数：",len(corrected_str))

#纠错后的文本
decoded_text = binary_to_text(corrected_str)
print("纠错后的文本：", decoded_text)

#去除冗余位后
orignial_str = original(corrected_str)
print("去除冗余位后的二进制串：", orignial_str)
print("位数：",len(orignial_str))

effecive_text = binary_to_text(orignial_str)
print("去除冗余位后的有效文本：", effecive_text)

#将解码后的文本保存到文件
output_filename = input("请输入输出文件名（包括路径）：")
with open(output_filename, 'w') as file:
    file.write(effecive_text)
