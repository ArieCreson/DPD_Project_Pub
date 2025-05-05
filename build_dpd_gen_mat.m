function M = build_dpd_gen_mat(X, order)
global orthogonal;
orthogonal
global Mem;
if orthogonal == 1
    X = X/max(abs(X));
    M = [];
    for q = 0:Mem  % Include q=0 to Q
        M = [M, PHI_q(X, q, order)];
    end
else
    X=X(:);
    abs_X=abs(X);
    M=ones(size(X));
    for k=1:order-1
        M=[M abs_X.^k];
    end
M=repmat(X,1,order).*M;     %   
end
end



function result = PHI_q(X, q, K)
    X_shifted = Xq(X, q);
    result = [];
    for k = 1:K
        result = [result, arrayfun(@(x) phi_k(x,k),X_shifted)];  % Vectorized
    end
end

 
function val = phi_k(x, k)
    coefficients = generate_orthogonal_polynomials(k);
    val = zeros(size(x));
    for i = 1:k
        val = val + coefficients(i) * (x*(abs(x)^(i-1)));
    end
end





function V = Xq(X, q)
    V = circshift(X, q);  % Shift input by q samples
    V(1:q) = 0;           % Replace initial q samples with zeros
end

function coefficients = generate_orthogonal_polynomials(order)
   % Generates a list of coefficients for a Volterra orthogonal polynomial of degree "order"
    coefficients = zeros(1, order);
    for i = 1:order
        coefficient = (-1)^(i + order) * factorial(order + i) / (factorial(i - 1) * factorial(i + 1) * factorial(order - i));
        coefficients(i) = round(coefficient); % Convert to integer
    end
end