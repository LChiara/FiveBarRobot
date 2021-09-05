function [q, jointWaypoints, execTime] = trajectoryPlannigJointSpace(bodyLengths, waypoints, trajType, plotFlag)

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
waypointAccelTimes = diff(waypointTimes)/4; % Acceleration times (trapezoidal only)

% Solve IK for each joint waypoint
numWaypoints = size(waypoints, 2);
numJoints = 4;
jointWaypoints = zeros(numJoints, numWaypoints);
for idx = 1:numWaypoints
    solution = FBR.solveIK(bodyLengths.La, bodyLengths.Lb, bodyLengths.Lc, waypoints(1,idx), waypoints(2,idx));
    config = FBR.searchConfiguration(solution);
    jointWaypoints(:, idx) = [config.th1; config.th2; config.th3; config.th4];
end

% Generate trajectory
fprintf('Generating trajectory (input=%s)...\n', trajType);
q = FBR.fun_generateTrajectory_JointSpace(trajType, jointWaypoints, waypointTimes, trajTimes, numJoints, waypointAccelTimes);
qSolution = array2table(q', 'VariableNames', {'th1', 'th2', 'th3', 'th4'});

execTime = toc;

if ~plotFlag
    disp('Plotting skipped.');
    disp('Done.');
    return;
end
disp('Plotting...');
for idx=1:size(q, 2)
    FBR.plotConfiguration(bodyLengths, qSolution(idx, :), waypoints);
    title('TrajectoryPlanning: Joint Space');
    subtitle(['t = ' num2str(trajTimes(idx))]);
    drawnow();
end
disp('Done.');

end

