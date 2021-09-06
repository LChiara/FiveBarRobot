function solution_info = solveIK(La, Lb, Lc, xEE, yEE)

E1 = -2*La*xEE;
F1 = -2*La*yEE;
G1 = La^2 - Lb^2 + xEE^2 + yEE^2;

E4 = 2*La*(-xEE + Lc);
F4 = -2*La*yEE;
G4 = Lc^2 + La^2 - Lb^2 + xEE^2 + yEE^2 - 2*Lc*xEE;

th11 = 2*atan((-F1 + sqrt(E1^2 + F1^2 - G1^2))/(G1-E1));
th21 = asin((yEE-La*sin(th11))/Lb);
th41 = 2*atan((-F4 + sqrt(E4^2 + F4^2 - G4^2))/(G4-E4));
th31 = acos((xEE-Lc-La*cos(th41))/Lc);

th12 = 2*atan((-F1 - sqrt(E1^2 + F1^2 - G1^2))/(G1-E1));
th22 = asin((yEE-La*sin(th12))/Lb);
th42 = 2*atan((-F4 - sqrt(E4^2 + F4^2 - G4^2))/(G4-E4));
th32 = acos((xEE-Lc-La*cos(th42))/Lc);

if sign(th11) == 1
    th1p = th11; th2p = th21;
    th1m = th12; th2m = th22;
else
    th1p = th12; th2p = th22;
    th1m = th11; th2m = th21;
end
if sign(th41) == 1
    th4p = th41; th3p = th31;
    th4m = th42; th3m = th32;
else
    th4p = th42; th3p = th32;
    th4m = th41; th3m = th31;
end

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
