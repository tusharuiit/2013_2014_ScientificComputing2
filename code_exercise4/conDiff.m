
%%% --------------- SPECIFICATION -----------------------

% grid level (-> 2^level+1 grid points on finest level)
level = 10;
% epsilon (steering diffusion level)
epsi = 1;
% tolerance for max. norm of residual
mytol = 1e-10;


%%% --------------- COMPUTATION & ALGORITHMS ------------

% number of grid points
N = 2^level + 1;
% mesh size
h = 1/(N-1);
% stencil on finest grid level
stencil = [-epsi/h^2-1/h;  2*epsi/h^2+1/h;  -epsi/h^2]';
% max. norm of residual
totRes = 0.0;

% solution vector and right hand side
u = zeros(N,1);
uSol = zeros(N,1);
rhs = zeros(N,1);

% initialise solution as well as right hand side
for i = 2 : 1 : N-1
    rhs(i) = 2*(i-1)*h - (2*epsi+1);
    uSol(i) = ((i-1)*h)^2 - (i-1)*h;
end
% compute residual
totRes = 0.0;
for i = 2 : 1 : N-1
    totRes = max(totRes,abs(rhs(i) - stencil*u(i-1:i+1)) );
end


% start multigrid
counter = 0;
while(totRes>mytol)
    u = wCycle(u,rhs,level,stencil);
    %u = smooth(stencil,u,rhs);
    % compute residual
    totRes = 0.0;
    for i = 2 : 1 : N-1
        totRes = max(totRes,abs(rhs(i) - stencil*u(i-1:i+1)) );
    end
    fprintf('Iteration %i: %g\n', counter,totRes);
    counter = counter+1;
end
