function res=residual_vec(N,b,u);
    
    M=N+2;
    a=1/(6*(N+1)*(N+1));
    res=zeros((N+2)^3,1);
    
    for k=2:N+1
        for j=2:N+1
            for i=2:N+1
                idx=M*(M*(k-1)+(j-1))+i;
                res(idx) = b(idx) - (N+1)^2*(u(idx-1)+u(idx+1)+u(idx-M)+u(idx+M)+u(idx-M^2)+u(idx+M^2)-6*u(idx));
            end
        end
    end
