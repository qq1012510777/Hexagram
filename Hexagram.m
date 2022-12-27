clc
clear all
close all

currentPath = fileparts(mfilename('fullpath'));
% get the current path of the .m file

addpath(genpath([currentPath, '/Quaternion']));
addpath(genpath([currentPath, '/Intersection']));

pnt = [];

for i = 0:5
    pnt1 = Quaternion_Rotation(i * 60, 0, 0, 1, 0.0, 0.4, 0);
    pnt = [pnt; pnt1 + [0.4, 0.4, 0]];
end

figure(1)
pbaspect([1 1 1])

jk = [3, 4, 5, 6, 1, 2];

% for i = 1:6
%     plot(pnt([i, jk(i)], 1), pnt([i, jk(i)], 2), '-'); hold on
% end

pnt12 = pnt(:, [1, 2]);

% for i = 1:6
%
%     disp(['(', num2str(pnt12(i, 1)), 'em, ', num2str(pnt12(i, 2)), 'em)', ' -- ', '(', num2str(pnt12(jk(i), 1)), 'em, ', num2str(pnt12(jk(i), 2)), 'em)'])
%
% end

gk = [6, 1, 2, 3, 4, 5];
hk = [2, 3, 4, 5, 6, 1];

pnt34 = zeros(12, 2);

for i = 1:6
    pnt34(2 * i - 1, :) = pnt12(i, :);
end

for i = 1:6
    [E, lambda, gamma, isConvex] = lineIntersection(pnt12(i, :)', pnt12(jk(i), :)', pnt12(gk(i), :)', pnt12(hk(i), :)');

    scatter(E(1), E(2), 'o'); hold on

    pnt34(2 * i, :) = E';
end

lk = [2:12, 1];

% for i = 1:12
% 
%     disp(['(', num2str(pnt34(i, 1)), 'em, ', num2str(pnt34(i, 2)), 'em)', ' -- ', '(', num2str(pnt34(lk(i), 1)), 'em, ', num2str(pnt34(lk(i), 2)), 'em)'])
% 
% end

for i = 1:12
    plot(pnt34([i, lk(i)], 1), pnt34([i, lk(i)], 2), '-'); hold on
end