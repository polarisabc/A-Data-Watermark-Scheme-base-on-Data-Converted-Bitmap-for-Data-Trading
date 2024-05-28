fid = 1;
msgfid=fopen('hidden.txt','r');%�������ļ�������������Ϣ
[msg,count]=fread(msgfid);
len=count*8;
fclose(msgfid);
d =str2bit(msg);
block = [3, 3];
[fn, pn] = uigetfile({'*.bmp', 'bmp file(*.bmp)';}, 'ѡ������');
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
%�������ͼ��ߴ粻��������������Ϣ�����ڴ�ֱ�����ϸ������ͼ��
if sN < tN
    multiple = ceil(tN / sN);
    tmp = [];
    for i = 1:multiple
        tmp = [tmp; I];
    end;
    I = tmp;
end;

%���������㷨������������д��Ӳ�̡�
stegoed = hide_lsb(block, d, I);
imwrite(stegoed, 'watermarked.bmp', 'bmp');

[fn, pn] = uigetfile({'*.bmp', 'bmp file(*.bmp)';}, 'ѡ����������');
y = imread(strcat(pn, fn));
sy = size(y);
if(length(sy) >= 3)
    I = rgb2gray(y);
else
    I = y;
end;
 %������ȡ�㷨�����������Ϣ��
out = dh_lsb(block, I);

m=bit2str(out);
fidm=fopen('message.txt','wt');
fwrite(fidm,m)
fclose(fidm)

%���������ʡ�
len = min(length(d), length(out));
rate = sum(abs(out(1:len) - d(1:len))) / len;
y = 1 - rate;
fprintf(fid, 'LSB :len:%d\t error rate:%f\t  error num:%d\n', len, rate, len * rate);
