% explicit Euler time stepping for positions and velocities
function [positions,velocities] = explEuler(positions,velocities,dt,masses);

l = length(positions(1,:));

% compute forces
forces = computeForces(positions,masses);

% position and velocity update
for i = 1 : 1 : l
    positions(:,i) = positions(:,i) + dt*velocities(:,i);
    velocities(:,i) = velocities(:,i) +dt/masses(i)*forces(:,i);
end


return