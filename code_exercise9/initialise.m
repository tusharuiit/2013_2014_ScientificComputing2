%%% set initial positions, mass, velocity and force of the planets
function [positions,masses,velocities,forcesOld] = initialise();

% initialise the matrices
positions = zeros(2,4);
masses = zeros(4);
velocities = zeros(2,4);
forcesOld = zeros(2,4);

%%% sun
masses(1) = 1;
positions(:,1) = [ 0 ; 0];
velocities(:,1) = [0 ; 0];

%%% earth
masses(2) = 3.0e-6;
positions(:,2) = [0 ; 1];
velocities(:,2) = [-1 ; 0];

%%% jupiter
masses(3) = 9.55e-4;
positions(:,3) = [ 0 ; 5.36];
velocities(:,3) = [-0.425 ; 0];


%%% halley comet
masses(4) = 1e-14;
positions(:,4) = [34.75 ; 0];
velocities(:,4) = [0 ; 0.0296];

% initially compute the forces between the planets
forcesOld = computeForces(positions,masses);

return
