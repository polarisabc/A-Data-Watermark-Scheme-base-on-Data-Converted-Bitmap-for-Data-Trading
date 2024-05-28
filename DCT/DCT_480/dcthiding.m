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
%1-120
for i=1:960
    if msg(i,1)==0
        if DCTrgb(i+0,i+7)<DCTrgb(i+7,i+0) %选择(5,2)和(4,3)这一对系数
            temp=DCTrgb(i+0,i+7);
            DCTrgb(i+0,i+7)=DCTrgb(i+7,i+0);
            DCTrgb(i+7,i+0)=temp;
        end
    else
         if  DCTrgb(i+0,i+7)>DCTrgb(i+7,i+0)
            temp=DCTrgb(i+0,i+7);
            DCTrgb(i+0,i+7)=DCTrgb(i+7,i+0);
            DCTrgb(i+7,i+0)=temp;
        end
    end
    if DCTrgb(i+0,i+7)<DCTrgb(i+7,i+0)
        DCTrgb(i+0,i+7)=DCTrgb(i+0,i+7)-alpha;%将原本小的系数调整更小，使得系数差别变大
    else
        DCTrgb(i+7,i+0)=DCTrgb(i+7,i+0)-alpha;
    end
end
wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%对DCTrgb1进行逆变换
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked1.bmp');

msgfid=fopen('hidden.txt','r');%%打开秘密文件,读入秘密信息
[msg,count]=fread(msgfid);
count=count*8;
alpha=0.02;
fclose(msgfid);
msg=str2bit(msg)';
[len col]=size(msg);
io=imread('watermarked1.bmp');%读取载体图像
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
%121-240
for i=1:960
    if msg(i+960,1)==0
        if DCTrgb(i+1,i+6)<DCTrgb(i+6,i+1) %选择(5,2)和(4,3)这一对系数
            temp=DCTrgb(i+1,i+6);
            DCTrgb(i+1,i+6)=DCTrgb(i+6,i+1);
            DCTrgb(i+6,i+1)=temp;
        end
    else
         if  DCTrgb(i+1,i+6)>DCTrgb(i+6,i+1)
            temp=DCTrgb(i+1,i+6);
            DCTrgb(i+1,i+6)=DCTrgb(i+6,i+1);
            DCTrgb(i+6,i+1)=temp;
        end
    end
    if DCTrgb(i+1,i+6)<DCTrgb(i+6,i+1)
        DCTrgb(i+1,i+6)=DCTrgb(i+1,i+6)-alpha;%将原本小的系数调整更小，使得系数差别变大
    else
        DCTrgb(i+6,i+1)=DCTrgb(i+6,i+1)-alpha;
    end
end


wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%对DCTrgb1进行逆变换
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked2.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%201-300
msgfid=fopen('hidden.txt','r');%%打开秘密文件,读入秘密信息
[msg,count]=fread(msgfid);
count=count*8;
alpha=0.02;
fclose(msgfid);
msg=str2bit(msg)';
[len col]=size(msg);
io=imread('watermarked2.bmp');%读取载体图像
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
%241-360
for i=1:960
    if msg(i+1920,1)==0
        if DCTrgb(i+2,i+5)<DCTrgb(i+5,i+2) %选择(5,2)和(4,3)这一对系数
            temp=DCTrgb(i+2,i+5);
            DCTrgb(i+2,i+5)=DCTrgb(i+5,i+2);
            DCTrgb(i+5,i+2)=temp;
        end
    else
         if  DCTrgb(i+2,i+5)>DCTrgb(i+5,i+2)
            temp=DCTrgb(i+2,i+5);
            DCTrgb(i+2,i+5)=DCTrgb(i+5,i+2);
            DCTrgb(i+5,i+2)=temp;
        end
    end
    if DCTrgb(i+2,i+5)<DCTrgb(i+5,i+2)
        DCTrgb(i+2,i+5)=DCTrgb(i+2,i+5)-alpha;%将原本小的系数调整更小，使得系数差别变大
    else
        DCTrgb(i+5,i+2)=DCTrgb(i+5,i+2)-alpha;
    end
end


wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%对DCTrgb1进行逆变换
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked3.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%301-400
msgfid=fopen('hidden.txt','r');%%打开秘密文件,读入秘密信息
[msg,count]=fread(msgfid);
count=count*8;
alpha=0.02;
fclose(msgfid);
msg=str2bit(msg)';
[len col]=size(msg);
io=imread('watermarked3.bmp');%读取载体图像
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
%361-480
for i=1:960
    if msg(i+2880,1)==0
        if DCTrgb(i+3,i+4)<DCTrgb(i+4,i+3) %选择(5,2)和(4,3)这一对系数
            temp=DCTrgb(i+3,i+4);
            DCTrgb(i+3,i+4)=DCTrgb(i+4,i+3);
            DCTrgb(i+4,i+3)=temp;
        end
    else
         if  DCTrgb(i+3,i+4)>DCTrgb(i+4,i+3)
            temp=DCTrgb(i+3,i+4);
            DCTrgb(i+3,i+4)=DCTrgb(i+4,i+3);
            DCTrgb(i+4,i+3)=temp;
        end
    end
    if DCTrgb(i+3,i+4)<DCTrgb(i+4,i+3)
        DCTrgb(i+3,i+4)=DCTrgb(i+3,i+4)-alpha;%将原本小的系数调整更小，使得系数差别变大
    else
        DCTrgb(i+4,i+3)=DCTrgb(i+4,i+3)-alpha;
    end
end
wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%对DCTrgb1进行逆变换
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked.bmp');






