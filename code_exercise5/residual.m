function res=residual(N,b,u);
    
    M=N+2;
    a=1/(6*(N+1)*(N+1));
    res=0;
    
	for k=2:N+1
		for j=2:N+1
			for i=2:N+1
                idx=M*(M*(k-1)+(j-1))+i;
				local = b(idx) - (N+1)^2*(u(idx-1)+u(idx+1)+u(idx-M)+u(idx+M)+u(idx-M^2)+u(idx+M^2)-6*u(idx));
                res = res + local^2;
            end
        end
    end
    
    res = sqrt(res/(N^3));


