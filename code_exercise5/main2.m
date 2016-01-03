% Steepest Descent
clear;
N=7;
visualise=1;
p=acos(-1);
h=1/(N+1)

%set right hand side
b=zeros((N+2)^3,1);
for k=2:N+1
    for j=2:N+1
        for i=2:N+1
            idx=(k-1)*(N+2)^2+(j-1)*(N+2)+i;
            b(idx)=1; 
        end
    end
end

%initialisation
u=zeros((N+2)^3,1);
res = 1;
it=0;
%iterate
tic;
while (res>0.00001)
    it=it+1;
    u=steepest_descent(N,b,u);
    res=residual(N,b,u);
end
time=toc;
    
disp('Steepest Descent:');
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
            title('Steepest Descent, solution on the plane z=1/4');
        elseif (z==2)
            title('Steepest Descent, solution on the plane z=1/2');
        elseif (z==3)
            title('Steepest Descent, solution on the plane z=3/4');
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
