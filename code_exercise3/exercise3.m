%%% ------------- ADJUSTABLE PARAMETERS ------------------
% number of grid points N+1
level=5;
% multigrid-scheme identifier
% 0 - full-weighted restriction, d-linear interpolation
% 1 - injection for restriction, d-linear interpolation
% 2 - semi-coarsening in x-direction, linear interpolation in x-direction
% 3 - no multi-grid, only pure Gauss-Seidel solver (one iteration step instead of v-cycle)
mgID = 3;
% coefficients for (an)isotropic Poisson equation
a = 1;
b = 1;
% number of pre- and postsmoothing operations
preSmoothing=2;
postSmoothing=2;


%%% -------------- MAIN PROGRAM ---------------------------

% number of grid points
N=2^level+1;
% mesh size
h = 1.0 /(N-1);
% solution vector and right hand side
u = zeros(N,N);
rhs = u;
% variable for error estimation
eNew = zeros(1,1);

% initialise solution vector and right hand side
for j = 1 : 1 : N
    for i = 1 : 1 : N
        % set right hand side to zero everywhere
        rhs(i,j) = 0;
        % set initial solution to sin(pi*x)*sin(pi*y)
        u(i,j) = sin(pi*(i-1)*h)*sin(pi*(j-1)*h);
    end
end
% compute error as maximum value of pointwise residual
eNew(1) = max(max(abs(residual(a,b,u,rhs))));

% iterate until the error is below 1e-5...
v = 0;
while (eNew > 1e-12)
    % solve
    u=vCycle(a,b,u,rhs,preSmoothing,postSmoothing,level,mgID);
    
    % compute the error
    eNew = [eNew max(max(abs(residual(a,b,u,rhs))))];
    fprintf('Error in iteration %d: %f\n',v,eNew(length(eNew)-1));
    v = v+1;
end
