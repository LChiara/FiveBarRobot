function plotConfiguration(bodyLengths, jointAngles, waypoints, endEffector)

if nargin < 3
    waypoints = [];
end
if nargin  < 4
    jEE = [bodyLengths.La*cos(jointAngles.th1) + bodyLengths.Lb*cos(jointAngles.th2);
        bodyLengths.La*sin(jointAngles.th1) + bodyLengths.Lb*sin(jointAngles.th2)];
else
    jEE = [endEffector.xP; endEffector.yP];
end

jA1 = [0; 0];
jB1 = [bodyLengths.La*cos(jointAngles.th1);
    bodyLengths.La*sin(jointAngles.th1)];
jB2 = [bodyLengths.Lc + bodyLengths.La*cos(jointAngles.th4);
    bodyLengths.La*sin(jointAngles.th4)];
jA2 = [bodyLengths.Lc; 0];
jointPositions = [jA1, jB1, jEE, jB2, jA2, jA1];
% shape = polyshape(jointPositions(1, :), jointPositions(2, :));
% plot(shape);

for i=1:size(jointPositions, 2)-1
    plot(jointPositions(1, i:i+1), jointPositions(2, i:i+1), 'Color', '#66B2FF', 'LineWidth', 2); hold on;
    scatter(jointPositions(1, i), jointPositions(2, i), 75, 'MarkerEdgeColor', [0 .5 .5], 'MarkerFaceColor', [0 .7 .7], 'LineWidth', 1.5);
end

if ~isempty(waypoints)
    for i=1:size(waypoints, 2)
        scatter(waypoints(1, i), waypoints(2, i), 75, 'MarkerEdgeColor', 'b', 'LineWidth', 1.5);
    end
end
xlim([-50 100]);
ylim([-50 100]);

hold off;

end