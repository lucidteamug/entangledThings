% Take the bell state write it in other basis. What happens?

%The trig functions are in RADIANS 
%We use the fact that a theta-rotation followed by a measurement in the standard basis can be
%used as an equivalent for measuring in a new basis theta off from our
%original basis
% A and B start in the Bell state

disp("hi")
disp("======================================================================================================================================================") 
disp("                                                               BELL STATE")
bellstate = [1 ; 0 ; 0 ; 1] * sqrt(2)

%Manually test a variety of different theta rotations on the bell state(as
%a way to simulate setting up to "measure" in a new basis) 
% and verify those rotations lead to the bell state
% (A math proof that isn't just trying random points is shown in the video)
for div = 0.5:10
    new_state = RotateState(bellstate,pi/div);
    if new_state ~= bellstate
        disp("FAILED");
    else
        disp("SUCCESS");
    end    
end    

disp("======================================================================================================================================================") 
disp("                                                                [1; 1; 1; 1]/2")

%Two examples showing that not just any possible 2qbit state will maintain
%its state descript a despite of basis
cur_state = [1 ;1; 1; 1] /2

 RotateState(cur_state,pi/6)  %Description changes (we don't get out [1; 1; 1; 1]
 RotateState(cur_state,pi)    %Description stays the same (we do get out [1; 1; 1; 1]



 
 
 

 
%Functions for rotation


% rotateMatrix takes in a theta and a matrix origMatrix (representing a
% basis) and returns a matrix representing a new basis theta-degrees
% rotated from the origMatrix
function rotatedMatrix = rotation(theta, origMatrix)

%Since the rotation matrix is used on the qbit-state vector, we want to
%rotate clockwise to express a counter-clockwise-theta basis
theta = (-1) * theta;
rotatedMatrix = [cos(theta) -sin(theta) ; sin(theta) cos(theta)] * origMatrix;
end 



% RotateState takes in a descript of a 2 qbit state (ex: [1;0;0;1]/sqrt(2)
% for the bell state) and a theta. It returns that state rotated by a that
% theta. (The equivalent of putting each qbit from that state through a
% rotation matrix of theta degrees)
function new_state = RotateState(cur_state, cur_theta)
% Gates
%Gate Zero is zero degrees rotated from the identity matrix 
GATE_ZERO = [1 0 ; 0 1];
GATE_THETA = rotation(cur_theta,GATE_ZERO);

GATE_THETA = kron(GATE_THETA, GATE_THETA);
POST_THETA = GATE_THETA * cur_state;
new_state = POST_THETA;

%Rotate by theta and have B

end
%try by multiple rotations 


