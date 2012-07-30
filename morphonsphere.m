% Morph coordinates a with respect to b by scalar s while staying on the
% shortest path along the surface of a hypersphere that both a and b are
% assumed to be on. s==1 gives all a, s==0 gives all b. 
%
% This should be solvable analytically but in the absence of such a
% solution we use some ugly while loops to approximate the desired ratio of
% euclidean distances, (ie pdist([a c]) / pdist([b c])). You can customise
% the search precision by setting tolerance (default 1e-2) and number of
% iterations to try before crashing (default 10e3). 
%
% c = morphonsphere(a,b,s,[tolerance],[totiter]);
function c = morphonsphere(a,b,s,tolerance,totiter)

if ieNotDefined('tolerance')
    tolerance = 1e-2;
end

if ieNotDefined('totiter')
    totiter = 10e3;
end

assert(ndims(a)==ndims(b),'coordinates must have same dimensionality')
assert(all(size(a)==size(b)),'coordinates a and b must be the same size')

a = ascol(a);
b = ascol(b);

normdist = norm(a);
% we allow some rounding error here because otherwise this check nearly
% always fails
assert(reduceprecision(normdist,3)==reduceprecision(norm(b),3),...
    'a and b must be on the same hypersphere!')

assert(isscalar(s),'scale factor s must be scalar')
% sadly no support for caricaturing/anticaricaturing at present
assert(inrange(s,[0 1])==s,'scale factor s must be in 0:1 range')

% start out at the right point in euclidean space to speed things up
c = seteccentricity(morph(a,b,s),normdist);

% shortcircuit processing for speed when in simple cases where the
% euclidean distance is the same as the surface distance
if any(s == [0 1 .5])
    return
end

% The tricky thing here is that the euclidean distance is necessarily LESS
% than the surface distance so if you only optimise ac or bc you will end
% up stopping short of the correct point. Instead, optimise the ratio of
% bc/ba
targrate = s / (1-s);

niter = 0;
m = 1;
corg = c;
distratefun = @(a,b,c) pdist([c b]') / pdist([c a]');
distrate = distratefun(a,b,c);
distdiff = distrate - targrate;
while abs(distdiff) > tolerance
    niter = niter+1;
    if distdiff<0
        m = m * 1.01;
    else
        m = m * 0.99;
    end
    c = seteccentricity(morph(corg,b,m),normdist);
    distrate = distratefun(a,b,c);
    distdiff = distrate - targrate;
    assert(niter < totiter,'failed to converge')
end
