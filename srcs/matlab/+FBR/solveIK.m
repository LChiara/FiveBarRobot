function solution_info = solveIK(La, Lb, Lc, xEE, yEE)

E1 = -2*La*xEE;
F1 = -2*La*yEE;
G1 = La^2 - Lb^2 + xEE^2 + yEE^2;

E4 = 2*La*(-xEE + Lc);
F4 = -2*La*yEE;
G4 = Lc^2 + La^2 - Lb^2 + xEE^2 + yEE^2 - 2*Lc*xEE;

th1p = 2*atan((-F1 + sqrt(E1^2 + F1^2 - G1^2))/(G1-E1));
th2p = asin((yEE-La*sin(th1p))/Lb);
th4p = 2*atan((-F4 + sqrt(E4^2 + F4^2 - G4^2))/(G4-E4));
th3p = acos((xEE-Lc-La*cos(th4p))/Lc);

th1m = 2*atan((-F1 - sqrt(E1^2 + F1^2 - G1^2))/(G1-E1));
th2m = asin((yEE-La*sin(th1m))/Lb);
th4m = 2*atan((-F4 - sqrt(E4^2 + F4^2 - G4^2))/(G4-E4));
th3m = acos((xEE-Lc-La*cos(th4m))/Lc);

solution_info = struct( ...
    'th1p', th1p, ...
    'th2p', th2p, ...
    'th3p', th3p, ...
    'th4p', th4p, ...
    'th1m', th1m, ...
    'th2m', th2m, ...
    'th3m', th3m, ...
    'th4m', th4m);
% 
% solution_info.th1p = ;
% solution_info.th2p = ;
% 
% solution_info.th3p = acos((xEE-Lc-La*cos(th4p))/Lc);
% solution_info.th4p = th4p;
% 
% solution_info.th1m = 2*atan((-F1 - sqrt(E1^2 + F1^2 - G1^2))/(G1-E1));
% solution_info.th2m = asin((yEE-La*sin(solution_info.th1m))/Lb);
% th4m = 2*atan((-F4 - sqrt(E4^2 + F4^2 - G4^2))/(G4-E4));
% solution_info.th3m = acos((xEE-Lc-La*cos(th4m))/Lc);
% solution_info.th4m = th4m;
end
