
clc;
clear;
wi=imread('verify.bmp');%读取携密图像
wi=double(wi)/255;
wi=wi(:,:,1);%取图像的一层来提取
T=dctmtx(8);%对图像进行分块
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%对图像分块进行DCT变换

for i=1:1008 %80为隐藏的秘密信息的比特数
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
     



