function [q, qd, qdd] = fun_generateTrajectory_JointSpace(trajType, jointWaypoints, waypointTimes, trajTimes, numJoints, waypointAccelTimes)
% Code copied from function manipTrajJoint provided by Mathworks:
% https://github.com/mathworks-robotics/trajectory-planning-robot-manipulators/blob/master/matlab/manipTrajJoint.m

switch trajType
    case 'trap'
        [q,qd,qdd] = trapveltraj(jointWaypoints,numel(trajTimes), ...
            'AccelTime',repmat(waypointAccelTimes,[numJoints 1]), ...
            'EndTime',repmat(diff(waypointTimes),[numJoints 1]));
        
    case 'cubic'
        [q,qd,qdd] = cubicpolytraj(jointWaypoints,waypointTimes,trajTimes, ...
            'VelocityBoundaryCondition',zeros(numJoints,numWaypoints));
        
    case 'quintic'
        [q,qd,qdd] = quinticpolytraj(jointWaypoints,waypointTimes,trajTimes, ...
            'VelocityBoundaryCondition',zeros(numJoints,numWaypoints), ...
            'AccelerationBoundaryCondition',zeros(numJoints,numWaypoints));
        
    case 'bspline'
        ctrlpoints = jointWaypoints; % Can adapt this as needed
        [q,qd,qdd] = bsplinepolytraj(ctrlpoints,waypointTimes([1 end]),trajTimes);
        
    otherwise
        error('Invalid trajectory type! Use ''trap'', ''cubic'', ''quintic'', or ''bspline''');
end
end

