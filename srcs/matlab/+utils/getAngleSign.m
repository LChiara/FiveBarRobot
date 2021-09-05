function thetaSign = getAngleSign(theta)
if sign(theta) == 1
    thetaSign = '+';
elseif sign(theta) == -1
    thetaSign = '-';
else
    thetaSign = '0';
end

