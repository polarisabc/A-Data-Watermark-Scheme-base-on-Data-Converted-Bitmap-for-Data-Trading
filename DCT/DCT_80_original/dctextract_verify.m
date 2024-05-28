
clc;
clear;
wi=imread('verify.bmp');%��ȡЯ��ͼ��
wi=double(wi)/255;
wi=wi(:,:,1);%ȡͼ���һ������ȡ
T=dctmtx(8);%��ͼ����зֿ�
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%��ͼ��ֿ����DCT�任

for i=1:1008 %80Ϊ���ص�������Ϣ�ı�����
     if  DCTcheck(i+4,i+1)<=DCTcheck(i+3,i+2)        
         message(i,1)=1;
     else
         message(i,1)=0;
     end
end

out=bit2str(message);
fid=fopen('message.txt', 'wt');
fwrite(fid, out)
fclose(fid);         
     



