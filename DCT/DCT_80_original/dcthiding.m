clc;
clear;
msgfid=fopen('hidden.txt','r');%%打开秘密文件,读入秘密信息
[msg,count]=fread(msgfid);
count=count*8;
alpha=0.02;
fclose(msgfid);
msg=str2bit(msg)';
[len col]=size(msg);
io=imread('original.bmp');%读取载体图像
io=double(io)/255;
output=io;
i1=io(:,:,1);%取图像的一层来隐藏
T=dctmtx(8);%对图像进行分块
DCTrgb=blkproc(i1,[8 8],'P1*x*P2',T,T');%对图像分块进行DCT变换
[row,col]=size(DCTrgb);
row=floor(row/8);
col=floor(col/8);
% 顺序信息嵌入
temp=0;
for i=1:count;
    if msg(i,1)==0
        if DCTrgb(i+4,i+1)<DCTrgb(i+3,i+2) %选择(5,2)和(4,3)这一对系数
            temp=DCTrgb(i+4,i+1);
            DCTrgb(i+4,i+1)=DCTrgb(i+3,i+2);
            DCTrgb(i+3,i+2)=temp;
        end
    else
         if  DCTrgb(i+4,i+1)>DCTrgb(i+3,i+2)
            temp=DCTrgb(i+4,i+1);
            DCTrgb(i+4,i+1)=DCTrgb(i+3,i+2);
            DCTrgb(i+3,i+2)=temp;
        end
    end
    if DCTrgb(i+4,i+1)<DCTrgb(i+3,i+2)
        DCTrgb(i+4,i+1)=DCTrgb(i+4,i+1)-alpha;%将原本小的系数调整更小，使得系数差别变大
    else
        DCTrgb(i+3,i+2)=DCTrgb(i+3,i+2)-alpha;
    end
end
%将信息写回并保存

wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%对DCTrgb1进行逆变换
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked.bmp');
figure;
subplot(1,2,1);imshow('original.bmp');title('原始图像');
subplot(1,2,2);imshow('watermarked.bmp');title('嵌入水印图像');







