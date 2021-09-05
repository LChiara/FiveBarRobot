function solutionFound = searchConfiguration(solution_info, rigidBodySolution)
    if nargin < 2
        solutionFound = struct( ...
            'th1', solution_info.th1p, ...
            'th1d', solution_info.th1p*180/pi, ...
            'th2', solution_info.th2p, ...
            'th2d', solution_info.th2p*180/pi, ...
            'th3', solution_info.th3m, ...
            'th3d', solution_info.th3m*180/pi, ...
            'th4', solution_info.th4m, ...
            'th4d', solution_info.th4m*180/pi);
        return;
    end
    
    angles.theta1p = solution_info.th1p;
    angles.theta1m = solution_info.th1m;
    angles.theta4p = solution_info.th4p;
    angles.theta4m = solution_info.th4m;
    angles_fieldnames = fieldnames(angles);

    solutionFound = struct('th1', [], 'th1d', [], 'th4', [], 'th4d', []);
    for i=1:numel(angles_fieldnames)
        th_degree = angles.(angles_fieldnames{i})*180/pi;
        if abs(th_degree-rigidBodySolution.th1d) < 1e-4
            solutionFound.th1d = th_degree;
            solutionFound.th1 = angles.(angles_fieldnames{i});
            fprintf('th1=%s -> %3.1f (rad=%1.4f)\n', angles_fieldnames{i}, th_degree, angles.(angles_fieldnames{i}));
            continue;
        end
        if abs(th_degree-rigidBodySolution.th4d) < 1e-4
            solutionFound.th4d = th_degree;
            solutionFound.th4 = angles.(angles_fieldnames{i});
            fprintf('th4=%s -> %3.1f (rad=%1.4f)\n', angles_fieldnames{i}, th_degree, angles.(angles_fieldnames{i}));
            
        end
    end
    if isempty(solutionFound.th1)
        warning('No solution could be found for th1.');
    end
    if isempty(solutionFound.th4)
        warning('No solution could be found for th4.');
    end
end