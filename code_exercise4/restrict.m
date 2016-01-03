function rCoarse = restrict(stencil,residual);

rCoarse = zeros( (length(residual)-1)/2+1,1);
l = length(residual);

restrictionStencil = [-stencil(1)/stencil(2); 1; -stencil(3)/stencil(2)]';

rCoarse(1) = restrictionStencil(2)*residual(1)+restrictionStencil(3)*residual(2);
rCoarse(length(rCoarse)) = restrictionStencil(1)*residual(l-1)+restrictionStencil(2)*residual(l);
for i = 2 : 1 : length(rCoarse)-1
    rCoarse(i) = restrictionStencil*residual(2*(i-1):2*(i-1)+2);
end

return