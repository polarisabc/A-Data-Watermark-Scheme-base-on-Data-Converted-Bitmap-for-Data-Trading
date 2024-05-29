# A-Data-Watermark-Scheme-base-on-Data-Converted-Bitmap-for-Data-Trading
A Data Watermark Scheme base on Data Converted Bitmap for Data Trading
detail steps
(1) generate orginal bmp: csv2bmp.py
cmd input: python csv2bmp.py original plan{A,B,C} {lsb,dct}
exp_1: planA + lsb
exp_2: planB + lsb
exp_3: planC + lsb
exp_4: planA + dct
exp_5: planB + dct
exp_6: planC + dct
output: original.bmp

(2)generate watermark: Watermark_process_7bit.py
input: original.txt
output: hidden.txt

(3)embed watermark in bmp: lsb/dct
input: original.bmp  and  message.txt
output:watermarked.bmp

(4)embed watermark in table: bmp2csv.py
input:watermarked.bmp
cmd input:python bmp2csv.py {lsb, dct}
output: watermarked.csv

(5)verify watermark in table: csv2bmp.py
input: watermarked.csv
cmd input: python csv2bmp.py verify plan{A,B,C} {lsb,dct}
output: verify.bmp

(6)attack watermarked table: attack.py
input watermarked.csv
cmd input: attack.py
output: attacked table

(7)extract watermark in attacked table :csv2bmp.py
input: watermarked.csv
cmd input: python csv2bmp.py verify plan{A,B,C} {lsb,dct}
output: verify.bmp

(8)extract watermark in bmp : dct/lsb
output: message.txt

(9)verify CF: caculate
input: original.txt and messgae.txt
output: num


