% interpolates a coarse grid solution to the fine grid
function eFine = interpolate(eCoarse);

% sizes of fine grid solution
Nx = 2*(length(eCoarse(:,1))-1)+1;
Ny = 2*(length(eCoarse(1,:))-1)+1;

% initialise fine grid solution
eFine = zeros(Nx,Ny);

% do interpolation. Case distinction depending on location of the fine grid
% points
for i = 2 : 1 : Nx-1
    for j = 2 : 1 : Ny-1
        if ( (mod(i,2)==0) && (mod(j,2)==0) )
            eFine(i,j) = 1/4.0 * (  eCoarse(i/2  ,j/2  ) ...
                                + eCoarse(i/2+1,j/2  ) ...
                                + eCoarse(i/2  ,j/2+1) ...
                                + eCoarse(i/2+1,j/2+1) );
        elseif ( (mod(i,2)==1) && (mod(j,2)==0) )
            eFine(i,j) = 1/2.0 * (  eCoarse( (i+1)/2, j/2  ) ...
                                + eCoarse( (i+1)/2, j/2+1) );
        elseif ( (mod(i,2)==0) && (mod(j,2)==1) )
            eFine(i,j) = 1/2.0 * (  eCoarse( i/2  , (j+1)/2 ) ...
                                + eCoarse( i/2+1, (j+1)/2 ) );
        elseif ( (mod(i,2)==1) && (mod(j,2)==1) )
            eFine(i,j) = 1/1.0 * eCoarse( (i+1)/2, (j+1)/2 );
        end
    end
end

return