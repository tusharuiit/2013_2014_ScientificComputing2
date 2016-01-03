% velocity stoermer verlet time integration
function [positions,velocities,forces,forcesOld] = velocityStoermerVerlet(positions,velocities,forces,forcesOld,dt,masses);

l = length(positions(1,:));

% position update
for i = 1 : 1 : l
    positions(:,i) = positions(:,i) + dt*velocities(:,i) + dt^2/2/masses(i)*forcesOld(:,i);
end

% compute new forces
forces = computeForces(positions,masses);

% compute new velocities
for i = 1 : 1 : l
    velocities(:,i) = velocities(:,i) +dt/2/masses(i)*(forcesOld(:,i)+forces(:,i));
end

% store old forces
forcesOld = forces;

return