function configurations = getAllConfigurations(solution)
configurationsArray = [solution.th1p, solution.th2p, solution.th3p, solution.th4p;
    solution.th1m, solution.th2m, solution.th3p, solution.th4p;
    solution.th1p, solution.th2p, solution.th3m, solution.th4m;
    solution.th1m, solution.th2m, solution.th3m, solution.th4m];
configurations = array2table(configurationsArray, 'VariableNames', {'th1', 'th2', 'th3', 'th4'});
configurations = sortrows(configurations, [-1, -4]);
end
