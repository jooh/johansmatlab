% Given a start (x) and an end (y), generate a vector with nsteps
% intermediate points (including x and y).
% z = vecsteps(x,y,nsteps)
function z = vecsteps(x,y,nsteps)

% Need to catch this special case to avoid div0 problems
if x==y
    z = repmat(x,[1 nsteps]);
    return
end

sr = y-x;
z = x:sr/(nsteps-1):y;

% This little debug check can probably be removed once we have more faith
% that this function is working as intended
assert(length(z)==nsteps,'failed to find correct increment!');
