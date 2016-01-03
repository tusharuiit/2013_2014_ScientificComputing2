% initialise positions, planet masses, velocities and (old) forces
[positions,masses,velocities,forcesOld] = initialise();
forces = forcesOld;

% set time step and number of time steps
dt = 0.015;
timesteps=320000;

% buffer to store all positions over time
allPositions = zeros(8,timesteps);


% time stepping
plot_n=100;
for t = 1 : 1 : timesteps
   % switch between velocity Stoermer Verlet...
   [positions,velocities,forces,forcesOld] = velocityStoermerVerlet(positions,velocities,forces,forcesOld,dt,masses);
   % ... and explicit Euler time integration
   %[positions,velocities] = explEuler(positions,velocities,dt,masses);
   
   %%% store the current position in the global position matrix
   % sun
   allPositions(1:2,t) = positions(:,1);
   % earth
   allPositions(3:4,t) = positions(:,2);
   % jupiter
   allPositions(5:6,t) = positions(:,3);
   % halley
   allPositions(7:8,t) = positions(:,4);
   
   % visualise molecules
   if (mod(t,plot_n) == 0)
     clf;
     hold on;
     grid on; axis([-10 35 -15 15 -35 35]);
     scatter3 ( positions(1,:), positions(2,:), [0 ; 0 ; 0 ; 0] , 150.0, 'r', 'filled' ), view(0,90); %view(-60,60);
     title ( sprintf ( 'Iteration %d\n', t ) );
     hold off;

     pause(0.2);
   end
   
end

%%% plot global positions
plot(allPositions(1,:),allPositions(2,:), 'k-', allPositions(3,:),allPositions(4,:),'r-', allPositions(5,:), allPositions(6,:), 'g-', allPositions(7,:),allPositions(8,:), 'b-')