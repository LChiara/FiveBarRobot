function solution_info = solveFK(La, Lb, Lc, th1, th4)
    % calculate coefficients for th3
    F = 2*La*Lb*(sin(th4) - sin(th1));
    E = 2*Lb*(Lc + La*(cos(th4) - cos(th1)));
    G = Lc^2 + 2*La^2 + 2*Lc*La*(cos(th4)-cos(th1)) - 2*La^2*cos(th4-th1);

    th3 = 2*atan2(-F + sqrt(E^2 + F^2 - G^2), G - E);
    th2 = asin((Lb*sin(th3) + La*sin(th4) - La*sin(th1)) / Lb);
    th3atan = 2*atan((-F + sqrt(E^2 + F^2 - G^2))/(G - E));

    [solution_info.xPp, solution_info.yPp] = calculateAndCheckPosition(La, Lb, Lc, th1, th2, th3, th4, th3atan);
    solution_info.th2p = th2;
    solution_info.th3p = th3;

    th3 = 2*atan2(-F - sqrt(E^2 + F^2 - G^2), G - E);
    th2 = asin((Lb*sin(th3) + La*sin(th4) - La*sin(th1)) / Lb);
    th3atan = 2*atan((-F - sqrt(E^2 + F^2 - G^2))/(G - E));

    [solution_info.xPm, solution_info.yPm] = calculateAndCheckPosition(La, Lb, Lc, th1, th2, th3, th4, th3atan);
    solution_info.th2m = th2;
    solution_info.th3m = th3;
end

function [xEE1, yEE1] = calculateAndCheckPosition(La, Lb, Lc, theta_1, theta_2, theta_3, theta_4, theta_3_atan)
    xEE1 = Lc + La*cos(theta_4) + Lb*cos(theta_3);
    yEE1 = La*sin(theta_4) + Lb*sin(theta_3);

    xEE2 = La*cos(theta_1) + Lb*cos(theta_2);
    yEE2 = La*sin(theta_1) + Lb*sin(theta_2);
    
    if abs(xEE1 - xEE2) > 1e-6
        warning('x_p (%2.7f) and x_p2 (%2.7f) diverges', xEE1, xEE2);
    end
    if abs(yEE1 - yEE2) > 1e-6
        warning('y_p (%2.7f) and y_p2 (%2.7f) diverges', yEE1, yEE2);
    end
    
    xEEatan = Lc + La*cos(theta_4) + Lb*cos(theta_3_atan);
    yEEatan = La*sin(theta_4) + Lb*sin(theta_3_atan);

    if abs(xEE1 - xEEatan) > 1e-6
        warning('x_p (%2.7f) and x_p_atan (%2.7f) diverges', xEE1, xEEatan);
    end
    if abs(yEE1 - yEEatan) > 1e-6
        warning('y_p (%2.7f) and y_p_atan (%2.7f) diverges', yEE1, yEEatan);
    end
end