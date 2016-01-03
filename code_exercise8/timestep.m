function [xNew1,vNew1] = timestep(xA,vA,FA,dt);

% ---------- time integration exercise 8 --------------------
% actually we would need to divide the FA-entries by the mass of the
% molecule. Since m is scaled to unity, we can skip this operation.
vNew1 = vA + dt* FA;
xNew1 = xA + dt/2*(vA+vNew1);
return;