% carries out one v-cycle for a poisson problem in 2D
% a,b           - coefficients in front of second derivatives
% u             - solution vector
% rhs           - right hand side of poisson problem
% preSmoothing  - number of pre-smoothing steps
% postSmoothing - number of post-smoothing steps
% level         - current level under consideration. The level l typically
%                 holds 2^l+1 grid points (this changes in case of semi-
%                 coarsening).
% mgID          - multigrid or solver scheme (see exercise3.m)
function u=vCycle(a,b,u,rhs,preSmoothing,postSmoothing,level,mgID)

% mgID=3 -> only one Gauss-Seidel iteration and return
if (mgID==3)
    u=gaussSeidel(a,b,u,rhs);
    return
end



% If this is the coarsest level, we perform 10^4 Gauss-Seidel iterations to
% solve the coarse problem (we might need to adapt the number of iterations
% for bigger-sized problems than discussed in the exercise class)
if (level==1)
    for k = 1 : 1 : 10000
        u=gaussSeidel(a,b,u,rhs);
    end
    
% If this is not the coarsest level under consideration,...
else

  % carry out pre-smoothing steps,...
  for s=1 : 1 : preSmoothing
    u = gaussSeidel(a,b,u,rhs);
  end

  % ... compute the residual,...
  res = residual(a,b,u,rhs);

  % ... restrict the solution to coarser grid,...
  if (mgID==0)
    resCoarse = restrict_fullweighting(res);
  elseif (mgID==1)
    resCoarse = restrict_injection(res);
  elseif (mgID==2)
    resCoarse = restrict_semicoarsening(res);
  end
  eCoarse = zeros(length(resCoarse(:,1)), length(resCoarse(1,:)) );

  % ... carry out v-cycle algorithm recursively.
  eCoarse = vCycle(a,b,eCoarse,resCoarse,preSmoothing,postSmoothing,level-1,mgID);

  % After receiving a solution for the error from the residual equation on
  % the coarser grid, interpolate solution to the finer grid...
  if (mgID==0)
    eFine = interpolate(eCoarse);
  elseif (mgID==1)
    eFine = interpolate(eCoarse);
  elseif (mgID==2)
    eFine = interpolate_semi(eCoarse);
  end

  % ... and correct the original solution.
  u = u+eFine;

  % Finally, carry out post-smoothing.
  for s = 1 : 1 : postSmoothing
    u = gaussSeidel(a,b,u,rhs);
  end
end

return