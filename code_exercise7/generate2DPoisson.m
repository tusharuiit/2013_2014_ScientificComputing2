function A = generate2DPoisson(x,y);

% init matrix as eye matrix; with this, we already have the Dirichlet nodes
% initialised correctly
A = eye(x*y,x*y);
N = x*y;

% write matrix entries for inner points;
% therefore, loop over all point coordinates
    for yy=2:1:y-1
        for xx=2:1:x-1
            c  =(xx-1)+(yy-1)*x+1;
            nbN=c + x;
            nbS=c - x;
            nbW=c + 1;
            nbE=c - 1;
            A(c,c) = 4;
            A(c,nbE) = -1;
            A(c,nbW) = -1;
            A(c,nbS) = -1;
            A(c,nbN) = -1;
        end
    end

return