function stencilCoarse = computeCoarseGridStencil(stencil);

stencilCoarse = 1/stencil(2)*[-stencil(1)^2; stencil(1)^2+stencil(3)^2; -stencil(3)^2]';

return