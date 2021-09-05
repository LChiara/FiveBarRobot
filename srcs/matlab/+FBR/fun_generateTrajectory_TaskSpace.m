function [q, qd, qdd] = fun_generateTrajectory_TaskSpace(trajType, waypoints, waypointTimes, trajTimes, waypointVels, waypointAccels, waypointAccelTimes)
% Code copied from function manipTrajCartesian provided by Mathworks:
% https://github.com/mathworks-robotics/trajectory-planning-robot-manipulators/blob/master/matlab/manipTrajCartesian.m

switch trajType
    case 'trap'
        [q,qd,qdd] = trapveltraj(waypoints,numel(trajTimes), ...
            'AccelTime',repmat(waypointAccelTimes,[size(waypoints, 1) 1]), ...
            'EndTime',repmat(diff(waypointTimes),[size(waypoints, 1) 1]));
        
    case 'cubic'
        [q,qd,qdd] = cubicpolytraj(waypoints,waypointTimes,trajTimes, ...
            'VelocityBoundaryCondition',waypointVels);
        
    case 'quintic'
        [q,qd,qdd] = quinticpolytraj(waypoints,waypointTimes,trajTimes, ...
            'VelocityBoundaryCondition',waypointVels, ...
            'AccelerationBoundaryCondition',waypointAccels);
        
    case 'bspline'
        ctrlpoints = waypoints; % Can adapt this as needed
        [q,qd,qdd] = bsplinepolytraj(ctrlpoints,waypointTimes([1 end]),trajTimes);
        
    otherwise
        error('Invalid trajectory type! Use ''trap'', ''cubic'', ''quintic'', or ''bspline''');
end
end

