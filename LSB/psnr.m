function y = psnr(org, stg)
% function y = psnr(org, stg)
y = 0;
sorg = size(org);
sstg = size(stg);
if sorg ~= sstg
    fprintf(1, 'org and stg must have same size!\n');
end;
np = sum(sum((org - stg) .^ 2));
y = 10 * log10(max(max(double((org .^ 2)) * sorg(1) * sorg(2) / np)));
