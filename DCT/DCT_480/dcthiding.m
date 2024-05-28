clc;
clear;
msgfid=fopen('hidden.txt','r');%%�������ļ�,����������Ϣ
[msg,count]=fread(msgfid);
count=count*8;
alpha=0.02;
fclose(msgfid);
msg=str2bit(msg)';
[len col]=size(msg);
io=imread('original.bmp');%��ȡ����ͼ��
io=double(io)/255;
output=io;
i1=io(:,:,1);%ȡͼ���һ��������
T=dctmtx(8);%��ͼ����зֿ�
DCTrgb=blkproc(i1,[8 8],'P1*x*P2',T,T');%��ͼ��ֿ����DCT�任
[row,col]=size(DCTrgb);
row=floor(row/8);
col=floor(col/8);
% ˳����ϢǶ��
temp=0;
%1-120
for i=1:960
    if msg(i,1)==0
        if DCTrgb(i+0,i+7)<DCTrgb(i+7,i+0) %ѡ��(5,2)��(4,3)��һ��ϵ��
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
        DCTrgb(i+0,i+7)=DCTrgb(i+0,i+7)-alpha;%��ԭ��С��ϵ��������С��ʹ��ϵ�������
    else
        DCTrgb(i+7,i+0)=DCTrgb(i+7,i+0)-alpha;
    end
end
wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%��DCTrgb1������任
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked1.bmp');

msgfid=fopen('hidden.txt','r');%%�������ļ�,����������Ϣ
[msg,count]=fread(msgfid);
count=count*8;
alpha=0.02;
fclose(msgfid);
msg=str2bit(msg)';
[len col]=size(msg);
io=imread('watermarked1.bmp');%��ȡ����ͼ��
io=double(io)/255;
output=io;
i1=io(:,:,1);%ȡͼ���һ��������
T=dctmtx(8);%��ͼ����зֿ�
DCTrgb=blkproc(i1,[8 8],'P1*x*P2',T,T');%��ͼ��ֿ����DCT�任
[row,col]=size(DCTrgb);
row=floor(row/8);
col=floor(col/8);
% ˳����ϢǶ��
temp=0;
%121-240
for i=1:960
    if msg(i+960,1)==0
        if DCTrgb(i+1,i+6)<DCTrgb(i+6,i+1) %ѡ��(5,2)��(4,3)��һ��ϵ��
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
        DCTrgb(i+1,i+6)=DCTrgb(i+1,i+6)-alpha;%��ԭ��С��ϵ��������С��ʹ��ϵ�������
    else
        DCTrgb(i+6,i+1)=DCTrgb(i+6,i+1)-alpha;
    end
end


wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%��DCTrgb1������任
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked2.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%201-300
msgfid=fopen('hidden.txt','r');%%�������ļ�,����������Ϣ
[msg,count]=fread(msgfid);
count=count*8;
alpha=0.02;
fclose(msgfid);
msg=str2bit(msg)';
[len col]=size(msg);
io=imread('watermarked2.bmp');%��ȡ����ͼ��
io=double(io)/255;
output=io;
i1=io(:,:,1);%ȡͼ���һ��������
T=dctmtx(8);%��ͼ����зֿ�
DCTrgb=blkproc(i1,[8 8],'P1*x*P2',T,T');%��ͼ��ֿ����DCT�任
[row,col]=size(DCTrgb);
row=floor(row/8);
col=floor(col/8);
% ˳����ϢǶ��
temp=0;
%241-360
for i=1:960
    if msg(i+1920,1)==0
        if DCTrgb(i+2,i+5)<DCTrgb(i+5,i+2) %ѡ��(5,2)��(4,3)��һ��ϵ��
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
        DCTrgb(i+2,i+5)=DCTrgb(i+2,i+5)-alpha;%��ԭ��С��ϵ��������С��ʹ��ϵ�������
    else
        DCTrgb(i+5,i+2)=DCTrgb(i+5,i+2)-alpha;
    end
end


wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%��DCTrgb1������任
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked3.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%301-400
msgfid=fopen('hidden.txt','r');%%�������ļ�,����������Ϣ
[msg,count]=fread(msgfid);
count=count*8;
alpha=0.02;
fclose(msgfid);
msg=str2bit(msg)';
[len col]=size(msg);
io=imread('watermarked3.bmp');%��ȡ����ͼ��
io=double(io)/255;
output=io;
i1=io(:,:,1);%ȡͼ���һ��������
T=dctmtx(8);%��ͼ����зֿ�
DCTrgb=blkproc(i1,[8 8],'P1*x*P2',T,T');%��ͼ��ֿ����DCT�任
[row,col]=size(DCTrgb);
row=floor(row/8);
col=floor(col/8);
% ˳����ϢǶ��
temp=0;
%361-480
for i=1:960
    if msg(i+2880,1)==0
        if DCTrgb(i+3,i+4)<DCTrgb(i+4,i+3) %ѡ��(5,2)��(4,3)��һ��ϵ��
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
        DCTrgb(i+3,i+4)=DCTrgb(i+3,i+4)-alpha;%��ԭ��С��ϵ��������С��ʹ��ϵ�������
    else
        DCTrgb(i+4,i+3)=DCTrgb(i+4,i+3)-alpha;
    end
end
wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%��DCTrgb1������任
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked.bmp');






