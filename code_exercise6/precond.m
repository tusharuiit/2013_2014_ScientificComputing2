function v=precond(N,r,type);

    M=(N+2)^3;
    init=zeros(M,1);

    if (type==0)
        v=r;
    elseif (type==1)
        v=jacobi_iteration(N,r,init);
    elseif (type==2)
        v=gauss_seidel_iteration(N,r,init);
	    v_t=v;
	    for i=1:M
	        v_t(i)=v(M+1-i);
        end
	    v_t=gauss_seidel_iteration(N,v_t,init);
	    for i=1:M
	        v(i)=v_t(M+1-i);
	    end
    end
