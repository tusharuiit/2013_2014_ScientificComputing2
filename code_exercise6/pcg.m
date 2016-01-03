function [u,r,p,v]=pcg(N,b,u,r,p,v,type);

    N2=N+2;

    %updating u
    a=0;
    c=0;
    for k=2:N+1
        for j=2:N+1
            for i=2:N+1
                idx=N2*N2*(k-1)+N2*(j-1)+i;
                a=a+r(idx)*v(idx);
                c=c+p(idx)*(N+1)*(N+1)*(p(idx+1)+p(idx-1)+p(idx+N2)+p(idx-N2)+p(idx+N2*N2)+p(idx-N2*N2)-6*p(idx));
            end
        end
    end
    l=a/c;
    for k=2:N+1
        for j=2:N+1
            for i=2:N+1
                idx=N2*N2*(k-1)+N2*(j-1)+i;
                u(idx)=u(idx)+l*p(idx);
            end
        end
    end

    %new residual
    r=residual_vec(N,b,u);

    % preconditioning
    v = precond(N,r,type);

    %new search direction
    c=0;
    for k=2:N+1
        for j=2:N+1
            for i=2:N+1
                idx=N2*N2*(k-1)+N2*(j-1)+i;
                c=c+r(idx)*v(idx);
            end
        end
    end
    l=c/a;
    for k=2:N+1
        for j=2:N+1
            for i=2:N+1
                idx=N2*N2*(k-1)+N2*(j-1)+i;
                p(idx)=v(idx)+l*p(idx);
            end
        end
    end
