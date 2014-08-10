% signed difference between two angles (inputs and outputs in radians).
%
% d = raddiff(a,b)
function d = raddiff(a,b)

% another, slightly slower solution is
% d = atan2(sin(a-b),cos(a-b));
d = mod((a-b)+pi,2*pi)-pi;
