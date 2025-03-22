
% NSME calculation

options = optimset('TolX',1e-2);
fun = @(n)10*log10(mean(abs(((Z_aligned.*n(1))+n(2))-Y_aligned).^2) / mean((abs((Z_aligned.*n(1))+n(2)).^2)));
n0 = [1,0];

[n,NSME_after_final_alignement] = fminsearch(fun,n0,options)
