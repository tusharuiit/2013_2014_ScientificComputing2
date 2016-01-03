% perfoms the incomplete LDL decomposition on a symmetric positive definite
% matrix A (see lecture slides on pre-conditioning).
function [L,invD] = incompleteLDL(A);


M=length(A(:,1));
N=length(A(1,:));
if (M ~= N)
    disp('A is not quadratic!')
    return
end


L = zeros(N,N);
invD = zeros(N,1);


for i = 1 : 1 : N
    
    for j = 1:1:i-1
        % only compute L(i,j) if A(i,j) is not a zero value
        if (A(i,j) ~= 0)
          L(i,j) = A(i,j);
          for k=1:1:j-1
            % only compute if A-values are not zero
            if ( (A(i,k) ~=0) && (A(j,k) ~= 0) )
              L(i,j) = L(i,j) - L(i,k)*invD(k)*L(j,k);
            end
          end
        end
    end
    
    % always compute diagonal entry (since s.p.d. matrices are always
    % non-zero on the diagonal)
    invD(i) = A(i,i);
    for k=1:1:i-1
        if (A(i,k) ~= 0)
          invD(i) = invD(i)-L(i,k)*invD(k)*L(i,k);
        end
    end
    L(i,i) = invD(i);
    invD(i) = 1/invD(i);
end        

return
