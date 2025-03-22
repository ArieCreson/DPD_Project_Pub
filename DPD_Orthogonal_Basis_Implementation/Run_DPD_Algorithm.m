function [NMSE,Cond_num] = Run_DPD_Algorithm(Polynomial_order, Polynomial_Memory, Bool_Orthogonal)
    global Mem;
    global orthogonal;
    global cond1
    order = Polynomial_order; % Polynom order
    Mem = Polynomial_Memory;   % Model Memory
    orthogonal = Bool_Orthogonal; % Orthogonal or non-orthogonal
    DPD_Algorithm_modified;
    NMSE = NSME_with_dpd
    Cond_num = cond1
end
