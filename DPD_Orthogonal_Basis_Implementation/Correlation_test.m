[acor,lag] = xcorr(Y_40MHz_dc,z_dc);

[acormax,I] = max(abs(acor));
lagDiff = lag(I)

figure(5)
stem(lag,acor)
hold on
plot(lagDiff,acormax,'*')
hold off