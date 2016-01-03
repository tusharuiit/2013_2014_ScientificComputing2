% define the domain size in x- and y-direction
x = 4;
y = 5;

% generate full and sparse matrix A for 2D poisson with dirichlet cond.
A = generate2DPoisson(x,y);
sparseA = sparse(A);

% compute complete Cholesky decomp.
[completeL,completeInvD] = myLDL(A);
disp('Compute norm(L*D^{-1}*L^top - A)=');
norm(completeL*diag(completeInvD)*(completeL')-A)

% compute incomplete LDL-decomposition with our standard implementation
[myL,myInvD] = incompleteLDL(A);
matlabSparseL = ichol(sparseA);
matlabLsqrtInvD = full(matlabSparseL);
clear matlabSparseL;

% compare matlab and our outcome. Therefore, compute L*sqrt(inv(D)) from
% our data and compute the 2-norm between matlab's and our result
myLsqrtInvD = zeros(x*y,x*y);
for i = 1 : 1 : x*y
    for j = 1 : 1 : x*y
        myLsqrtInvD(i,j) = myL(i,j)*sqrt(myInvD(j));
    end
end

disp('Compare our and Matlab-result for L and D. Norm=');
norm(matlabLsqrtInvD-myLsqrtInvD,2)


% compute L and D for the optimised version for 2D poisson
[myLP,myInvDP] = incompleteLDLPoisson2D(x,y);
% compare outcome in 2-norm for our standard and optimised implementation
disp('Compare our optimised and standard implementation for L. Norm=');
norm(myLP-myL)
disp('Compare our optimised and standard implementation for D. Norm=');
norm(myInvDP-myInvD)
