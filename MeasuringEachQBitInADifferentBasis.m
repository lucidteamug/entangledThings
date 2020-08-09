% We measure one entangled qbit in basis K and the other in basis B. What
% happens? 


%The trig functions are in RADIANS 
%We use the fact that a theta-rotation followed by a measurement in the standard basis can be
%used as an equivalent for measuring in a new basis theta off from our
%original basis
% A and B start in the Bell state


%% MANUAL EXAMPLE %%

%Creating rotation gates by theta, 
GATE_ZERO = [1 0 ; 0 1];
theta = 2 * pi/3;
theta = (-1) * theta; %negate theta because we assume counter-clockwise-new-basis so we rotate our qbit-state vector clockwise-theta.
GATE_THIRD = [cos(theta) -sin(theta) ; sin(theta) cos(theta)] * GATE_ZERO;

%Here is a manual example of rotating the bell state's first qbit, A, by
%theta=(2*pi/3) and leaving B 
bellState = [1;0;0;1];

%Tensoring our rotation by 2pi/3 and rotation by 0 gates 
GATE_THIRD_ZERO = kron(GATE_THIRD, GATE_ZERO);
POST_THIRD_ZERO = GATE_THIRD_ZERO * bellState;

%Simulating measuring A in our new basis and getting a 1 which leaves us
%with B as a   [ -0.5000 ;  0.8660 ] if measuring in the standard basis 
%OR B as [ 1; 0] if measured in the rotation-by-2pi/3 basis
MEASUREA = [0 ; 0];
divisor = sum(abs(POST_THIRD_ZERO(1:2).^2));
MEASUREA(1:2) = POST_THIRD_ZERO(1:2)/divisor ;

%B in standard basis
B = MEASUREA

%B in rotation by 2pi/3 basis
B = GATE_THIRD * B




disp("Measure A = 0 in new basis. What's B in the standard basis?") 
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi/6)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi/4)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi/3)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi/2)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsZero(-pi/2)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsZero(1.5 * pi)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsZero(2 * pi)


disp("Measure A = 1 in new basis. What's B in the standard basis?") 
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi/6)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi/4)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi/3)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi/2)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(pi)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(1.5 * pi)
MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(2*pi)



% rotatedMatrix is a helper function to create a rotation matrix for a
% given theta
function rotatedMatrix = rotation(theta, origMatrix)
theta = (-1) * theta; %negate theta because we assume counter-clockwise-new-basis so we rotate our qbit-state vector clockwise-theta.
rotatedMatrix = [cos(theta) -sin(theta) ; sin(theta) cos(theta)] * origMatrix;
end 

%MeasureAInNewBasis_MeasureBInStandardBasis_AIsZero simulates measuring A
%in a new basis (a cur_theta rotation from standard basis) and getting a 0
%(which is [1;0])
%but writing B in the standard basis.
% A and B start in the Bell state

function RotatedB = MeasureAInNewBasis_MeasureBInStandardBasis_AIsZero(cur_theta)
disp("======================================================================================================================================================") 
disp("                                                                 A is 0 [1;0]                                                                                ") 
disp("                                                                cur_theta is " + cur_theta)


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
RotatedB = MEASUREA

end



%MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne simulates measuring A
%in a new basis (a cur_theta rotation from standard basis) and getting a 1
%(which is [0;1])
%but writing B in the standard basis.
% A and B start in the Bell state
function RotatedB = MeasureAInNewBasis_MeasureBInStandardBasis_AIsOne(cur_theta)
disp("======================================================================================================================================================") 
disp("                                                                 A is 1 [0;1]                                                                                ") 
disp("                                                                cur_theta is " + cur_theta)
% Gates
GATE_ZERO = [1 0 ; 0 1];
GATE_THETA = rotation(cur_theta,GATE_ZERO);

% Starting State
bellState = [1;0;0;1];

GATE_THETA_ZERO = kron(GATE_THETA, GATE_ZERO);
POST_THETA_ZERO = GATE_THETA_ZERO * bellState

MEASUREA = [0 ; 0];
divisor = sum(abs(POST_THETA_ZERO(3:4).^2));
MEASUREA(1:2) = POST_THETA_ZERO(3:4)/divisor


RotatedB = MEASUREA;

end








