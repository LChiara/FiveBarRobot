cd(fullfile('D:\cleo\FBR'));
addpath(fullfile('srcs'));
addpath(fullfile('srcs\matlab'));
addpath(fullfile('srcs\simulink'));

% load config in the workspace
disp('Loading start configurations...');
%Define configuration for the Five Bar Robot simulation
disp('Loading BodyLengths and JointAngles...');
bodyLengths.La = 42.78; %value from freeCAD
bodyLengths.Lb = 42.78; %value from freeCAD
bodyLengths.Lc = 42.78; %value from freeCAD
disp('Link lengths: '); disp(bodyLengths);

% define start configuration of FBR (regular pentagon)
jointAngles.th1d = 108;         jointAngles.th1 = jointAngles.th1d*pi/180;
jointAngles.th2d = 108/3;       jointAngles.th2 = jointAngles.th2d*pi/180;
jointAngles.th3d = 180-108/3;   jointAngles.th3 = jointAngles.th3d*pi/180;
jointAngles.th4d = 180-108;     jointAngles.th4 = jointAngles.th4d*pi/180;
disp('Joint angles: '); disp(jointAngles);

%Initialize the FBR RigidBody used for validation
%Please note: The creation of a FiveBarRobot is based on the adaptation of 
%the example provided by Mathworks 
%>> openExample('robotics/SolveInveseKinematicsForAFourBarLinkageExample').
disp('Creating FBR RigidBody...');
[fbrRigidBody, qInitRigidBody] = FBR.RigidBody.generateBody(bodyLengths, jointAngles);

disp('Loading Busses...');
load('busObjects.mat');

IsFBRInitialized = true;

disp('Initialization Done.');