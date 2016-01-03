function eFine = interpolate(stencil,eCoarse);

eFine = zeros(2*(length(eCoarse)-1)+1,1);
lEFine = length(eFine);

% for even entries: just use the value from the coarse grid
for i = 1 : 2 : lEFine
    eFine(i) = eCoarse((i-1)/2+1);
end


% for odd entries: use -stencil(1)/stencil(2) from left coarse grid node
% and -stencil(3)/stencil(2) from right coarse grid node
for i = 2 : 2 : lEFine
    eFine(i) = -stencil(1)/stencil(2) * eCoarse( i/2) -stencil(3)/stencil(2)*eCoarse(i/2+1);
end

return