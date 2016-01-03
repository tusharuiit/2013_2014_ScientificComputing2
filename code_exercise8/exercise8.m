% configuration 1
% xA = [-2 ; 0];
% vA = [0 ; 0];
% dt = 0.0001;
% numberTimesteps=200000;

% configuration 2
xA = [-2 ; 1];
vA = [1 ; 0];
dt = 0.0001;
numberTimesteps= 20000;



xB = [0 ; 0];
vB = [0 ; 0];
FA = zeros(2,1);
positions = zeros(2,numberTimesteps);
energy = zeros(1,numberTimesteps);


for t = 1 : 1 : numberTimesteps
    FA = computeForce(xA,xB);
    %[xA,vA,xB,vB] = timestepWithVerlet(xA,vA,xB,vB,FA,dt);
    [xA,vA] = timestep(xA,vA,FA,dt);
    positions(:,t) = xA;
    energy(t) = computeEnergy(xA,xB,vA,vB);
end