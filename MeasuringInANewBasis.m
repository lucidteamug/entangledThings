% We have two entangled qbits in basis B. We then choose to measure them both in basis K instead. What happens? 

%The trig functions are in RADIANS 
%We use the fact that a theta-rotation followed by a measurement in the standard basis can be
%used as an equivalent for measuring in a new basis theta off from our
%original basis
% A and B start in the Bell state

disp("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
disp("                                                         Rotations") 


%% MANUAL EXAMPLE %%

%Creating rotation gates by theta, 
GATE_ZERO = [1 0 ; 0 1];
theta = 2 * pi/3;
theta = (-1) * theta; %negate theta because we assume counter-clockwise-new-basis so we rotate our qbit-state vector clockwise-theta.
GATE_THIRD = [cos(theta) -sin(theta) ; sin(theta) cos(theta)] * GATE_ZERO;

%Here is a manual example of rotating the bell state's first qbit, A, by
%theta=(2*pi/3) and leaving B written in the standard basis
bellState = [1;0;0;1];

%Tensoring our rotation by 2pi/3 and rotation by 0 gates 
GATE_THIRD_ZERO = kron(GATE_THIRD, GATE_ZERO);
POST_THIRD_ZERO = GATE_THIRD_ZERO * bellState;

%Simulating measuring A in our new basis and getting a 0 ( [1;0]) which leaves us
%with B as a   [ -0.5000 ;  0.8660 ] if measuring in the standard basis 
%OR B as [ 1; 0] if measured in the rotation-by-2pi/3 basis
MEASUREA = [0 ; 0];
divisor = sum(abs(POST_THIRD_ZERO(1:2).^2));
MEASUREA(1:2) = POST_THIRD_ZERO(1:2)/divisor ;

%B in standard basis
B = MEASUREA

%B in rotation by 2pi/3 basis
B = GATE_THIRD * B


%% TRY IT YOURSELF ~ choose any theta to create a new basis!  %% 
disp("Measure A = 0 in new basis. What's B?") 
MeasureBothQBitsInTheta_AIsZero_OutputB(pi/3)
MeasureBothQBitsInTheta_AIsZero_OutputB(7)
MeasureBothQBitsInTheta_AIsZero_OutputB(1.234)
MeasureBothQBitsInTheta_AIsZero_OutputB(-4)
MeasureBothQBitsInTheta_AIsZero_OutputB(0)
MeasureBothQBitsInTheta_AIsZero_OutputB(pi/6)
MeasureBothQBitsInTheta_AIsZero_OutputB(pi/5)
MeasureBothQBitsInTheta_AIsZero_OutputB(pi/4)
MeasureBothQBitsInTheta_AIsZero_OutputB(pi/3)
MeasureBothQBitsInTheta_AIsZero_OutputB(pi/2)
MeasureBothQBitsInTheta_AIsZero_OutputB(pi)
MeasureBothQBitsInTheta_AIsZero_OutputB(1.5 * pi)
MeasureBothQBitsInTheta_AIsZero_OutputB(-pi/6)
MeasureBothQBitsInTheta_AIsZero_OutputB(2*pi)
MeasureBothQBitsInTheta_AIsZero_OutputB(-2*pi)
MeasureBothQBitsInTheta_AIsZero_OutputB(1.2 *pi)


disp("Measure A = 1 in new basis. What's B?s") 
MeasureBothQBitsInTheta_AIsOne_OutputB(pi/4)
MeasureBothQBitsInTheta_AIsOne_OutputB(pi/2)
MeasureBothQBitsInTheta_AIsOne_OutputB(pi)
MeasureBothQBitsInTheta_AIsOne_OutputB(-pi/2)
MeasureBothQBitsInTheta_AIsOne_OutputB(1.5 * pi)
MeasureBothQBitsInTheta_AIsOne_OutputB(2*pi)


%% Explanation of Functions %% 


% rotatedMatrix is a helper function to create a rotation matrix for a
% given theta
function rotatedMatrix = rotation(theta, origMatrix)
theta = (-1) * theta; %negate theta because we assume counter-clockwise-new-basis so we rotate our qbit-state vector clockwise-theta.
rotatedMatrix = [cos(theta) -sin(theta) ; sin(theta) cos(theta)] * origMatrix;
end 


% MeasureBothQBitsInTheta_AIsZero_OutputB measures A to be a zero in new basis (off by
% cur_theta) and prints out B's new position (in cur_theta basis)
%B will always print as a zero no matter the cur_theta chosen
% A and B start in the Bell state
function RotatedB = MeasureBothQBitsInTheta_AIsZero_OutputB(cur_theta)
disp("======================================================================================================================================================") 
disp("                                                                 A is Zero  = [1 ; 0]                                                                              ") 


% Gates
GATE_ZERO = [1 0 ; 0 1];
GATE_THETA = rotation(cur_theta,GATE_ZERO);

% Starting State
bellState = [1;0;0;1];



GATE_THETA_ZERO = kron(GATE_THETA, GATE_ZERO);
POST_THETA_ZERO = GATE_THETA_ZERO * bellState;

MEASUREA = [0 ; 0];
divisor = sum(abs(POST_THETA_ZERO(1:2).^2));
MEASUREA(1:2) = POST_THETA_ZERO(1:2)/divisor;


%Rotate by theta and have B
RotatedB = GATE_THETA * MEASUREA;

end
%try by multiple rotations 


% MeasureBothQBitsInTheta_AIsOne_OutputB measures A to be a one in new basis (off by
% cur_theta) and prints out B's new position (in cur_theta basis)
%B will always print as a one no matter the cur_theta chosen
% A and B start in the Bell state
function RotatedB = MeasureBothQBitsInTheta_AIsOne_OutputB(cur_theta)
disp("======================================================================================================================================================") 
disp("                                                                 A is One = [0;1]                                                                              ") 

% Start with a remind that rotate and measure is same as measure in new
% basis 

% Gates
GATE_ZERO = [1 0 ; 0 1];
GATE_THETA = rotation(cur_theta,GATE_ZERO);

% Starting State
bellState = [1;0;0;1];


GATE_THETA_ZERO = kron(GATE_THETA, GATE_THETA);
POST_THETA_ZERO = GATE_THETA_ZERO * bellState;

MEASUREA = [0 ; 0];
divisor = sum(abs(POST_THETA_ZERO(3:4).^2));
MEASUREA(1:2) = POST_THETA_ZERO(3:4)/divisor;
RotatedB =  MEASUREA;

end











