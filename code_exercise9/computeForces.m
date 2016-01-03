%%% computes gravitational forces between planets at different positions (matrix
%%% where each column corresponds to the position vector of one planet) and
%%% with different masses
function F = computeForces(positions,masses);

% number of planets
l = length(positions(1,:));

%%% initialise zero force
F = zeros(length(positions(:,1)),l);


%%% loop over each pair of planets
for i = 1 : 1 : l
    for j = i+1 : 1 : l
        
        % compute force on this pair
        d = positions(:,j)-positions(:,i);
        f = masses(i)*masses(j) /(sqrt(d'*d) * (d'*d)) * d;
        F(:,i) = F(:,i) + f;
        F(:,j) = F(:,j) - f;
    end
end

return
