% Calculate the DPD input signal

% Calculate the DPD coeficients

[output_after_mpapd,DPD_coef_Inverse] = apply_dpd_gen(Z_aligned,Y_aligned,order);
DPD_coef_Inverse

N = build_dpd_gen_mat(Z_aligned,order);        
s=N*DPD_coef_Inverse;       % Input signal to the amplifier after passing thru the DPD
% s=round(s);                 % Rounding to integer per request of Intel's PA.
rms(s)

[output_before_dpd,amp_coef] = apply_dpd_gen(Y_aligned,Z_aligned,order);    % Find the coeficients of the amplifier from measured data
amp_coef


Y_after_DPD                       % Find the theoretical amplifier output after compensation by dpd

Y_model=N*amp_coef;               % Find the model amplifier output (w/o dpd). If the model is perfect the output should resemble the measured output Y_aligned.

% Lets plot the transfer gain and phase shift of the amplifier after DPD

figure(4)
TransferPA = abs(Y_aligned./Z_aligned);
TransferPA_fit = abs(Y_fit./Z_aligned);
TransferPA_model = abs(Y_model./Z_aligned);
subplot(2,2,1)
plot(abs(Z_aligned), 20*log10(TransferPA), 'o', ...
abs(Z_aligned), 20*log10(TransferPA_model), '.m')
xlabel('Input Absolute Value')
ylabel('Magnitude Power Gain (dB)')
legend('Measured Gain','Model Gain','Location','northeast')
title('Power Gain Transfer Function')

subplot(2,2,2)
plot(abs(Z_aligned), 20*log10(TransferPA), 'o', ...
abs(Z_aligned), 20*log10(TransferPA_fit), '.')
xlabel('Input Absolute Value')
ylabel('Magnitude Power Gain (dB)')
legend('Measured Gain','Gain DPD Fit','Location','northeast')
title('Power Gain Transfer Function')

Delta_ang_no_DPD = (angle(Y_aligned./Z_aligned))*(360/(2*pi));        % Phase difference between output to input in deg
Delta_ang_with_DPD = (angle(Y_fit./Z_aligned))*(360/(2*pi));          % Phase difference between fited output (with DPD) to input in deg
Delta_ang_model = (angle(Y_model./Z_aligned))*(360/(2*pi));           % Phase difference between model output to input in deg

subplot(2,2,3)
plot(abs(Z_aligned), Delta_ang_no_DPD, 'o', ...
abs(Z_aligned), Delta_ang_model, '.m')
xlabel('Input Absolute Value')
ylabel('Phase (deg)')
legend('Measured Phase','Model Phase','Location','northeast')
title('Phase')

subplot(2,2,4)
plot(abs(Z_aligned), Delta_ang_no_DPD, 'o', ...
abs(Z_aligned), Delta_ang_with_DPD, '.')
xlabel('Input Absolute Value')
ylabel('Phase (deg)')
legend('Measured Phase','DPD Fit Phase','Location','northeast')
title('Phase')
