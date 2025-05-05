%% DPD Algorithm %%

% Load input signal (z) to the amplifier
dirName = '';
FileName = strcat(dirName,'fxp_40MHz_sample_rate_H7B20L1000.mat');
load(FileName);




% Load measured output signal (Y) of the amplifier
dirName = '';
FileName = strcat(dirName,'test.mat');
load(FileName);



figure(1)
% Spectrum of input signal z
Fs = 40e+6;
subplot(2,2,1)
pwelch(z,[],[],[],Fs,'centered')
legend('In spectrum')



% Power (in dB) of input signal z
y = 10*log10(abs(z).^2);
subplot(2,2,2)
plot(y)
xlabel('bin')
ylabel('dBm')
legend('In signal')

% Resample the output signal (Y) from 32 MHz to 40 MHz (Y_40MHz)
YY = double (Y);    % Transform the data of Y from complex simple to YY complex double (required by the resample function)
Y_40MHz = resample (YY,40,32);
Fs = 40e+6;

subplot(2,2,3)
pwelch(Y_40MHz,[],[],[],Fs,'centered')
legend('Out spectrum')

% Power (in dB) of Y_40MHz
w = 10*log10(abs(Y_40MHz).^2);
subplot(2,2,4)
plot(w)
xlabel('bin')
ylabel('dBm')
legend('Out signal')


% Prepare the signals for processing

% Remove DC (Block DC) from input and output signals for better processing
DC_block

% Make equal power the input and output signals (for easier processing)
power_factor = mean(abs(z_dc).^2)/mean(abs(Y_40MHz_dc).^2);
Y_40MHz_dc = Y_40MHz_dc * sqrt (power_factor);

% Align the two signals

% Find the delay D beyween the input signal and one of the periodic
% repetition 
[z_aligned,Y_40MHz_aligned,D] = alignsignals(z_dc,Y_40MHz_dc);
%[Y_40MHz_aligned,z_aligned,D] = alignsignals(Y_40MHz_dc,z_dc);
D     % Delay to get alignment

    if D<1          % Puting limits on D (9912 is is the signal lenght including the space).
        D=D+9923
    end
    if D>34400
        D=D-9902
    end
  
z_dc_lenght = find(z_dc>1, 1, 'last')   % Nonzero (greater than 1) lenght of z_dc

Y_40MHz_aligned = Y_40MHz_aligned(D:D-1+z_dc_lenght);  % Bring the aligned part of Y_MHz_aligned to start of the sequence

Y_40MHz_aligned = padarray(Y_40MHz_aligned,10);         % Pad Y_40MHz_aligned with 10 zero elements at start and end.       

z_aligned = z_dc(1:z_dc_lenght);     
z_aligned = padarray(z_aligned,10);     % Pad z_aligned with 10 zero elements at start and end.


%%
Freq_offset

%%



% Polynom order.
global Y_DPD;

DPD_coef_gen
NSME