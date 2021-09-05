function [configs, waypoints, execTime] = trajectoryPlanningTaskSpace(bodyLengths, waypoints, trajType, plotFlag)
if nargin < 3
    trajType = 'trap';
end
if nargin < 4
    plotFlag = true;
end

tic;
% Generate waypoints
disp('Generating waypoints...');
waypointTimes = 0:4:(size(waypoints, 2)-1)*4; % Array of waypoint times
ts = 0.2;
trajTimes = 0:ts:waypointTimes(end); % Trajectory sample time
% Boundary conditions (for polynomial trajectories)
waypointVels = 0.1 *[0  1; -1  0; 0 -1; 1  0; 0  1; 0  1; -1  0; 0 -1; 1  0; 0  1]'; % Velocity (cubic and quintic)
waypointAccels = zeros(size(waypointVels)); % Acceleration (quintic only)
waypointAccelTimes = diff(waypointTimes)/4; % Acceleration times (trapezoidal only)

% Generate trajectory
fprintf('Generating trajectory (input=%s)...\n', trajType);
q = FBR.fun_generateTrajectory_TaskSpace(trajType, ...
    waypoints, ...
    waypointTimes, ...
    trajTimes, ...
    waypointVels, ...
    waypointAccels, ...
    waypointAccelTimes);

% Solve IK for each trajectory point
disp('Running IK...');
configs = struct('th1', [], 'th1d', [], 'th2', [], 'th2d', [], 'th3', [], 'th3d', [], 'th4', [], 'th4d', []);
for idx = 1:numel(trajTimes)
    solution = FBR.solveIK(bodyLengths.La, bodyLengths.Lb, bodyLengths.Lc, q(1,idx), q(2,idx));
    configs(idx) = FBR.searchConfiguration(solution);
end

execTime = toc;

if ~plotFlag
    disp('Plotting skipped.');
    disp('Done.');
    return;
end
disp('Plotting...');
for idx=1:numel(configs)
    FBR.plotConfiguration(bodyLengths, configs(idx), waypoints);
    title('TrajectoryPlanning: Task Space');
    subtitle(['t = ' num2str(trajTimes(idx))]);
    drawnow();
end
disp('Done.');
end