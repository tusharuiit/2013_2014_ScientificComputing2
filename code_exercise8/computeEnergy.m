function e = computeEnergy(xA,xB,vA,vB);

% compute the potential energy
r6 = ((xA-xB)' * (xA-xB))^3;
e = 4*((1/r6)^2 - 1/r6);

% add kinetic energy
e = e + 0.5*(vA'*vA) + 0.5*(vB'*vB);

return