function [dpd_out, dpd_coef] = apply_dpd_gen(Input_signal,Output_signal, order)
%
global Mem;
global orthogonal;
global cond1;
linear_gain = rms(Output_signal)/rms(Input_signal); 
Y_Matrix = build_dpd_gen_mat(Output_signal/linear_gain,order); % Bring output signal to match RMS of input

Condition_number = cond(Y_Matrix)
cond1 = Condition_number;
dpd_coef = pinv(Y_Matrix)*Input_signal;

dpd_out = Y_Matrix*dpd_coef;
end
