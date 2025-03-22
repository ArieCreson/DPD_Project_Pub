function y=impair_signal(x, SampleRate)
%
% imapair_signal - a function to impair a signal. A tool for developing an
% alignment function
%
% Impairments are: gain and phase, frequency offset, DC component and time
% location
%
% Developed by Dr. Ilan Sutskover, WiFi Core Devision, Intel Corporation
% December 2018
%

FrequencyOffset = 11e+3; % Hz
Shift = 2000;
Repeat = 5;
Gain = 4; % dB
Phase = pi/6; % rad
DC = 1+j;

x=x(:); % ensure column vector

% step 1: duplicate and shift
x1 = repmat(x,Repeat,1);
x1 = circshift(x1,Shift);

% step 2: introduce frequency offset
t=[0:length(x1)-1].'/SampleRate;
x2 = x1 .* exp(-j*2*pi*FrequencyOffset*t);

% step 3: gain and phase
x3 = 10.^(Gain/20)*exp(j*Phase)*x2;

% step 4: DC
y = x3 + DC;

