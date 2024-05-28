
clc;
clear;
wi=imread('watermarked.bmp');%读取携密图像
wi=double(wi)/255;
wi=wi(:,:,1);%取图像的一层来提取
T=dctmtx(8);%对图像进行分块
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%对图像分块进行DCT变换
%1-100
for i=1:800 %80为隐藏的秘密信息的比特数
     if  DCTcheck(i+0,i+7)<=DCTcheck(i+7,i+0)        
         message(i,1)=1;
     else
         message(i,1)=0;
     end
end
%101-200
wi=imread('watermarked.bmp');%读取携密图像
wi=double(wi)/255;
wi=wi(:,:,1);%取图像的一层来提取
T=dctmtx(8);%对图像进行分块
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%对图像分块进行DCT变换

for i=1:800 %80为隐藏的秘密信息的比特数
     if  DCTcheck(i+1,i+6)<=DCTcheck(i+6,i+1)        
         message(i+800,1)=1;
     else
         message(i+800,1)=0;
     end
end

%201-300
wi=imread('watermarked.bmp');%读取携密图像
wi=double(wi)/255;
wi=wi(:,:,1);%取图像的一层来提取
T=dctmtx(8);%对图像进行分块
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%对图像分块进行DCT变换

for i=1:800 %80为隐藏的秘密信息的比特数
     if  DCTcheck(i+2,i+5)<=DCTcheck(i+5,i+2)        
         message(i+1600,1)=1;
     else
         message(i+1600,1)=0;
     end
end
%301-400
wi=imread('watermarked.bmp');%读取携密图像
wi=double(wi)/255;
wi=wi(:,:,1);%取图像的一层来提取
T=dctmtx(8);%对图像进行分块
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%对图像分块进行DCT变换

for i=1:800 %80为隐藏的秘密信息的比特数
     if  DCTcheck(i+3,i+4)<=DCTcheck(i+4,i+3)        
         message(i+2400,1)=1;
     else
         message(i+2400,1)=0;
     end
end
%401-500
wi=imread('watermarked.bmp');%读取携密图像
wi=double(wi)/255;
wi=wi(:,:,1);%取图像的一层来提取
T=dctmtx(8);%对图像进行分块
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%对图像分块进行DCT变换

for i=1:800 %80为隐藏的秘密信息的比特数
     if  DCTcheck(i+0,i+3)<=DCTcheck(i+3,i+0)        
         message(i+3200,1)=1;
     else
         message(i+3200,1)=0;
     end
end
%501-600
wi=imread('watermarked.bmp');%读取携密图像
wi=double(wi)/255;
wi=wi(:,:,1);%取图像的一层来提取
T=dctmtx(8);%对图像进行分块
DCTcheck=blkproc(wi,[8 8],'P1*x*P2',T,T');%对图像分块进行DCT变换

for i=1:800 %80为隐藏的秘密信息的比特数
     if  DCTcheck(i+1,i+3)<=DCTcheck(i+3,i+1)        
         message(i+4000,1)=1;
     else
         message(i+4000,1)=0;
     end
end
out=bit2str(message);
fid=fopen('message.txt', 'wt');
fwrite(fid, out)
fclose(fid);         
     



