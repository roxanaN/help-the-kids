% [USES] Algoritmi-ad-hoc/SST
% [USES] Algoritmi-ad-hoc/SIT
function [L, U, x] = Doolittle(A, b)
	n = length(A);
	L = eye(n);
	U = zeros(n);

	for i = 1 : n
		% calculate the upper triangular matrix
		sum_for_U = L(i , 1 : (i - 1)) * U(1 : (i - 1), i : n);
		U(i, i : n) = A(i, i : n) - sum_for_U;
	
		% calculate the lower triangular matrix
		sum_for_L = L((i + 1) : n, 1 : (i - 1)) * U(1 : (i - 1), i);
		L((i + 1) : n, i) = (A((i + 1) : n, i) - sum_for_L) / U(i, i);
	endfor

	% L * U * x = b;
	% L * y = b => y (SIT)
	% U * x = y => x (SST)
	
	% Solve the lower triangular system
	y = SIT(L, b);
	% Solve the upper triangular system
	x = SST(U, y);
endfunction

