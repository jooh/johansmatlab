% Set the eccentricity (length) of a vector relative to the origin
% x = seteccentricity(x,r);
function x = seteccentricity(x,r);

% normalise to unit, then multiply out to r
x = unitlen(x) * r;
