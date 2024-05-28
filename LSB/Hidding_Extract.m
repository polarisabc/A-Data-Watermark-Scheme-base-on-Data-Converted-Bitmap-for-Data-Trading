fid = 1;
msgfid=fopen('hidden.txt','r');%打开秘密文件，读入秘密信息
[msg,count]=fread(msgfid);
len=count*8;
fclose(msgfid);
d =str2bit(msg);
block = [3, 3];
[fn, pn] = uigetfile({'*.bmp', 'bmp file(*.bmp)';}, '选择载体');
s = imread(strcat(pn, fn));
ss = size(s);
if(length(ss) >= 3)
I = rgb2gray(s);
else
    I = s;
end;
si = size(I);
sN = floor(si(1) / block(1)) * floor(si(2) / block(2));
tN = length(d);
%如果载体图像尺寸不足以隐藏秘密信息，则在垂直方向上复制填充图像
if sN < tN
    multiple = ceil(tN / sN);
    tmp = [];
    for i = 1:multiple
        tmp = [tmp; I];
    end;
    I = tmp;
end;

%调用隐藏算法，把隐蔽载体写至硬盘。
stegoed = hide_lsb(block, d, I);
imwrite(stegoed, 'watermarked.bmp', 'bmp');

[fn, pn] = uigetfile({'*.bmp', 'bmp file(*.bmp)';}, '选择隐蔽载体');
y = imread(strcat(pn, fn));
sy = size(y);
if(length(sy) >= 3)
    I = rgb2gray(y);
else
    I = y;
end;
 %调用提取算法，获得秘密信息。
out = dh_lsb(block, I);

m=bit2str(out);
fidm=fopen('message.txt','wt');
fwrite(fidm,m)
fclose(fidm)

%计算误码率。
len = min(length(d), length(out));
rate = sum(abs(out(1:len) - d(1:len))) / len;
y = 1 - rate;
fprintf(fid, 'LSB :len:%d\t error rate:%f\t  error num:%d\n', len, rate, len * rate);
