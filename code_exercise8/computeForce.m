function F = computeForce(xA,xB);

r2 = (xA-xB)' * (xA-xB);

% attractive and repulsive forces (exercise 8a-c)
F = 24*(2*r2^(-6) - r2^(-3) )/r2 * (xA-xB);

% only repulsive forces (exercise 8d)
%F = 24*(2*r2^(-6))/r2 * (xA-xB);

return