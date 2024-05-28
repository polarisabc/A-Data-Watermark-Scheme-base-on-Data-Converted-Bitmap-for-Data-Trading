
clc;
clear;
wi=imread('watermarked.bmp');%��ȡЯ��ͼ��
wi=double(wi)/255;
wi=wi(:,:,1);%ȡͼ���һ������ȡ
T=dctmtx(8);%��ͼ����зֿ�
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%��ͼ��ֿ����DCT�任
%1-100
for i=1:800 %80Ϊ���ص�������Ϣ�ı�����
     if  DCTcheck(i+0,i+7)<=DCTcheck(i+7,i+0)        
         message(i,1)=1;
     else
         message(i,1)=0;
     end
end
%101-200
wi=imread('watermarked.bmp');%��ȡЯ��ͼ��
wi=double(wi)/255;
wi=wi(:,:,1);%ȡͼ���һ������ȡ
T=dctmtx(8);%��ͼ����зֿ�
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%��ͼ��ֿ����DCT�任

for i=1:800 %80Ϊ���ص�������Ϣ�ı�����
     if  DCTcheck(i+1,i+6)<=DCTcheck(i+6,i+1)        
         message(i+800,1)=1;
     else
         message(i+800,1)=0;
     end
end


out=bit2str(message);
fid=fopen('message.txt', 'wt');
fwrite(fid, out)
fclose(fid);         
     


