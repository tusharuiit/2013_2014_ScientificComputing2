function u=gauss_seidel_iteration(N,b,u);
    
    M=N+2;
    a=1/(6*(N+1)*(N+1));
    
	for k=2:N+1
		for j=2:N+1
			for i=2:N+1
                %remember that boundaries are also stored in u
                idx=M*(M*(k-1)+(j-1))+i;
				
                u(idx) = - a*b(idx) + (u(idx-1)+u(idx+1)+u(idx-M)+u(idx+M)+u(idx-M^2)+u(idx+M^2))/6;
            end
        end
    end