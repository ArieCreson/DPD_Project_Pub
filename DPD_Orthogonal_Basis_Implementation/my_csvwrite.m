clear all;
load('C:\DPD Experiment\Experiment try\fxp_40MHz_sample_rate_H7B20L1000.mat');
M=[real(Y) imag(Y)]; % matrix with 2 columns
csvwrite('fxp_40MHz_sample_rate_H7B20L1000.csv',M);