function u=wCycle(u,rhs,level,stencil);


  if level==1
    u = smooth(stencil,u,rhs);
    return
  else

    N = length(u);
    residual = zeros(N,1);

    % pre-smoothing
    for i = 1 : 1 : 2
      u = smooth(stencil,u,rhs);
    end

    % compute residual
    for i = 2 : 1 : N-1
      residual(i) = rhs(i) - stencil*u(i-1:i+1);
    end

    % compute restricted residual and initialise error vector
    rCoarse = restrict(stencil,residual);
    eCoarse = zeros(length(rCoarse),1);
    % compute stencil on coarse grid
    stencilCoarse = computeCoarseGridStencil(stencil);

    % recursively call w-cycle (g=2 <-> w-Cycle; g=1 <-> v-cycle)
    for g=1:1:2
      eCoarse = wCycle(eCoarse,rCoarse,level-1,stencilCoarse);
    end

    % interpolate error on fine grid
    eFine = interpolate(stencil,eCoarse);

    % correct solution
    u = u+eFine;

    % post-smoothing
    for i = 1 : 1 : 2
      u = smooth(stencil,u,rhs);
    end
  
  end

return
