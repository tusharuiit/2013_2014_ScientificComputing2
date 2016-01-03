% interpolates only in x-direction
function eFine = interpolate_semi(eCoarse);


% fine grid sizes
Nx = 2*(length(eCoarse(:,1))-1)+1;
Ny = length(eCoarse(1,:));

eFine = zeros(Nx,Ny);

% carries out interpolation. Case distinction depending on location of
% point on x-axis
for i = 2 : 1 : Nx-1
    for j = 2 : 1 : Ny-1
        if (mod(i,2)==0)
            eFine(i,j) = 1/2.0 * (  eCoarse(i/2  ,j  ) ...
                                  + eCoarse(i/2+1,j  ) );
        else
            eFine(i,j) = 1/1.0 * eCoarse( (i+1)/2, j );
        end
    end
end

return