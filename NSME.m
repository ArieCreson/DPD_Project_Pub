
% NSME calculation

% Z_NSME = (Z_aligned.*n(1))+n(2)      Scaling with x(1) and shifting with x(2) at Z_aligned to best match the amplifier output.
options = optimset('TolX',1e-2);
fun = @(n)10*log10(mean(abs(((Z_aligned.*n(1))+n(2))-Y_aligned).^2) / mean((abs((Z_aligned.*n(1))+n(2)).^2)));
n0 = [1,0];

[n,NSME_no_dpd] = fminsearch(fun,n0,options)

fun = @(n)10*log10(mean(abs(((Z_aligned.*n(1))+n(2))-Y_fit).^2) / mean((abs((Z_aligned.*n(1))+n(2)).^2)));
n0 = [1,0];

[n,NSME_with_dpd] = fminsearch(fun,n0,options)