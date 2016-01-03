function u=multigrid_iteration(N,b,u);
    
    %two presmoothing iterations
    for it=1:2
        u=gauss_seidel_iteration(N,b,u);
    end

    if (N>=3)
        %computation of the residual
        res = residual_vec(N,b,u);
    
        %restriction
        b_c = restrict(N,res);

        %direct solver (Gaussian elimination) on the coarse grid
        N_c = (N-1)/2;
        u_c = zeros((N_c+2)^3,1);
        u_c = multigrid_iteration(N_c,b_c,u_c);

        %interpolation
        u_delta = interpolate(N_c,u_c);

        %apdating u
        u = u + u_delta;
    end
    
    %two postsmoothing iterations
    for it=1:2
        u=gauss_seidel_iteration(N,b,u);
    end
