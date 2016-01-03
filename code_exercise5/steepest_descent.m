function u=steepest_descent(N,b,u);

    N2=N+2;
    
    %compute the residual of the current approximation
    r=residual_vec(N,b,u);

    a=0;
    b=0;
    for k=2:N+1
        for j=2:N+1
            for i=2:N+1
                idx=N2*N2*(k-1)+N2*(j-1)+i;
                a=a+r(idx)*r(idx);
                b=b+r(idx)*(N+1)*(N+1)*(r(idx+1)+r(idx-1)+r(idx+N2)+r(idx-N2)+r(idx+N2*N2)+r(idx-N2*N2)-6*r(idx));
            end
        end
    end
    l=a/b;
    for k=2:N+1
        for j=2:N+1
            for i=2:N+1
                idx=N2*N2*(k-1)+N2*(j-1)+i;
                u(idx)=u(idx)+l*r(idx);
            end
        end
    end