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
for i=1:count;
    if msg(i,1)==0
        if DCTrgb(i+4,i+1)<DCTrgb(i+3,i+2) %ѡ��(5,2)��(4,3)��һ��ϵ��
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
        DCTrgb(i+4,i+1)=DCTrgb(i+4,i+1)-alpha;%��ԭ��С��ϵ��������С��ʹ��ϵ�������
    else
        DCTrgb(i+3,i+2)=DCTrgb(i+3,i+2)-alpha;
    end
end
%����Ϣд�ز�����

wi=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);%��DCTrgb1������任
output=io;
output(:,:,1)=wi;
imwrite(output,'watermarked.bmp');
figure;
subplot(1,2,1);imshow('original.bmp');title('ԭʼͼ��');
subplot(1,2,2);imshow('watermarked.bmp');title('Ƕ��ˮӡͼ��');







