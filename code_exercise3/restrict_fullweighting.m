% restriction for 2D Poisson problem with full-weighting
% r         - fine grid solution/residual to be restricted
% rCoarse   - restricted residual
function rCoarse = restrict_fullweighting(r);

% fine grid domain sizes
Nx = length(r(:,1));
Ny = length(r(1,:));
% initialise coarsened vector
rCoarse = zeros( (Nx-1)/2+1,(Ny-1)/2+1);

% throw errors if some dimension does not match...
if ( mod ((Nx-1),2) ~= 0)
    Nx-1
    disp('Error! Cannot coarse any further in x-direction!')
    return
end
if ( mod ((Ny-1),2) ~= 0)
    Ny-1
    disp('Error! Cannot coarse any further in y-direction!')
    return
end

% loop over inner points and compute the coarsened representation.
% We do not work on the boundary/ outer points, since we expect the
% residual to be zero there anyway.
for i=2 : 1 : (Nx-1)/2
    for j = 2 : 1 : (Ny-1)/2
        rCoarse(i,j) = 1/16*(  r(2*(i-1)  ,2*(j-1)  ) ...
                            + r(2*(i-1)+2,2*(j-1)  ) ...
                            + r(2*(i-1)  ,2*(j-1)+2) ...
                            + r(2*(i-1)+2,2*(j-1)+2) ) ...
                     + 1/8*(  r(2*(i-1)+1,2*(j-1)  ) ...
                            + r(2*(i-1)  ,2*(j-1)+1) ...
                            + r(2*(i-1)+2,2*(j-1)+1) ...
                            + r(2*(i-1)+1,2*(j-1)+2) ) ...
                     + 1/4*   r(2*(i-1)+1,2*(j-1)+1);
    end
end

return
