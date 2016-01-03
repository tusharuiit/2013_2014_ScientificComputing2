% Precondition Conjugate Gradients 
clear;
N=15;
visualise=0;
p=acos(-1);
h=1/(N+1)

%set right hand side
b=ones((N+2)^3,1);

%initialisation
type=0;
u=zeros((N+2)^3,1);
res = 1;
it=0;
r=residual_vec(N,b,u);
p=r;
v=r;
disp('Initialisation done');

%iterate
tic;
while (res>0.00001 & it<2000)
    it=it+1;
    [u,r,p,v]=pcg(N,b,u,r,p,v,type);
    res=residual(N,b,u);
    disp('Iteration'); it
end
time=toc;
    
disp('PCG:');
it
res
time

%%Visualisation of the solution
%%Visualize the result at z=1/4, 1/2, 3/4
if (visualise)
    N2=N+2;
    for z=1:3
        k=(z/4)*(N+1);
        for i=1:N2
            for j=1:N2
                S(i,j)=u(N2*N2*k+N2*(j-1)+i);
            end
        end
        f=figure(z);
        hold on;
        if (z==1)
            title('Conjugate Gradients, solution on the plane z=1/4');
        elseif (z==2)
            title('Conjugate Gradients, solution on the plane z=1/2');
        elseif (z==3)
            title('Conjugate Gradients, solution on the plane z=3/4');
        end
        %zlim([0 1]);
        xlim([1 N+2]);
        ylim([1 N+2]);
        xlabel('i+1');
        ylabel('j+1');
        view([37.5 30]);
        mesh(S);
        hold off;
    end
end





