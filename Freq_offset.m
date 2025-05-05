%% Compensate for frequency offset and phase shift

% The sequences of the compensation:
% - Resample the signals by 32
% - Align the signals (preliminary)
% - Downsample the signals by 32
% - Compensate for frequency offset
% - Compensate for phase shift
% - Resample the signals by 64
% - Align the signals (fine)
% - Return to the original rate (downsample by 64)

% Upsampling by 32 and aligning

Z1 = resample (z_aligned,32,1);
Y1 = resample (Y_40MHz_aligned,32,1);

% Preliminary alignment

[Z1,Y1,D1] = alignsignals(Z1,Y1,[],'truncate');
D1     % Delay to get alignment

Downsampling_to_40MHz               % Downsampling back to 40 MHz


% Frequency offset compensation

b=angle(Z1_aligned./Y1_aligned);        % angle of difference (unfiltered)
a=filter(ones(64,1)/64,1,b);            % angle of difference (filtered)

delta_time = (1000)/40e+6;
f1 = 1001;
f2 = 2000;
if (a(f2)-a(f1)) < 0
    f1 = f1 + 1000;
    f2 = f2 + 1000;
end
delta_freq = (a(f2)-a(f1))/delta_time/(2*pi) % Hz

t=([0:length(Y1_aligned)-1]).'/40e+6;
Y2_aligned = Y1_aligned .* exp(j*2*pi*delta_freq*t);        % Correct Y1_aligned with the frequency error

c=filter(ones(64,1)/64,1,angle(Z1_aligned./Y2_aligned));    % Find the constant phase shift between the signals
phase_shift = mean(c)
Y3_aligned = Y2_aligned .* exp(j*phase_shift);              % Correct Y2_aligned with the phase error
d=filter(ones(64,1)/64,1,angle(Z1_aligned./Y3_aligned));    % Check that the signals are well aligned (frequency and phase)  
aligned_phase_shift = mean(d)

    if abs(aligned_phase_shift)>0.05            % Frequency offset compensation if the offset freq is around 180 deg
Y1_aligned = Y1_aligned .* exp(j*pi/4);         % Shift the phase of Y1_aligned
b=angle(Z1_aligned./Y1_aligned);                % angle of difference (unfiltered)
a=filter(ones(64,1)/64,1,b);                    % angle of difference (filtered)

delta_time = (1000)/40e+6;
delta_freq = (a(f2)-a(f1))/delta_time/(2*pi) % Hz

t=([0:length(Y1_aligned)-1]).'/40e+6;
Y2_aligned = Y1_aligned .* exp(j*2*pi*delta_freq*t);        % Correct Y1_aligned with the frequency error

c=filter(ones(64,1)/64,1,angle(Z1_aligned./Y2_aligned));    % Find the constant phase shift between the signals
phase_shift = mean(c)
Y3_aligned = Y2_aligned .* exp(j*phase_shift);              % Correct Y2_aligned with the phase error
d=filter(ones(64,1)/64,1,angle(Z1_aligned./Y3_aligned));  % Check that the signals are well aligned (frequency and phase)  
aligned_phase_shift = mean(d)
    end

   
% Ploting
figure(2)
plot(a,'LineWidth',2)
xlabel('bin')
ylabel('Rad')
legend('Delta phase between Input to Output')

figure(3)
plot(c)
hold on
plot(d)
xlabel('bin')
ylabel('Rad')
legend('Phase after freq correction','Phase after phase correction')
hold off

% Resampling by 64 and aligning

Z2 = resample (Z1_aligned,64,1);
Y2 = resample (Y3_aligned,64,1);

% Fine alignment

[Z2,Y2,D2] = alignsignals(Z2,Y2,[],'truncate');
D2     % Delay to get alignment
     
Z_aligned = resample (Z2,1,64);        % Downsampling back to 40 MHz
Y_aligned = resample (Y2,1,64);
