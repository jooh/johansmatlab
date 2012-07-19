% Place c a distance of s from a in the direction of b, all the while
% staying on a hypersphere. NB, unlike cartesian morphs, you must take care
% with the order of arguments since morphing 5 units from a to b will land
% you in a different location from morphing 5 units from b to a - even if a
% and b are 10 units apart (since the spherical distance of 5 will be
% less). On the upside, caricaturing is possible (ie targetdistances
% greater than the distance between a and b) up to the diameter of the
% hypersphere.
%
% This should be solvable analytically but in the absence of such a
% solution we use some ugly while loops to approximate the desired ratio of
% euclidean distances, (ie pdist([a c]) / pdist([b c])). You can customise
% the search precision by setting tolerance (default 1e-3) and number of
% iterations to try before crashing (default 10e3). 
%
% c = pushonsphere(a,b,targetdist,[tolerance],[totiter]);
function c = pushonsphere(a,b,targetdist,tolerance,totiter)

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

abdist = pdist([a b]');

% start out halfway to get moving
m = targetdist/abdist;
c = seteccentricity(morph(a,b,m),normdist);

% shortcircuit processing for speed when in simple cases where the
% euclidean distance is the same as the surface distance
if all(targetdist==abdist)
    c = a;
    return
end
if all(targetdist==0)
    c = a;
    return
end
% catch opposites since these tend to break things and we can compute
% quickly regardless
if targetdist==(2*normdist)
    c = a * -1;
    return
end

% If we actually have to work this out...
assert(targetdist<(2*normdist),'cannot push beyond hypersphere diameter')
niter = 0;
distdifun = @ (a,c,targetdist) pdist([a c]') - targetdist;
distdiff = distdifun(a,c,targetdist);
while abs(distdiff) > tolerance
    niter = niter+1;
    if distdiff>0
        m = m * 1.01;
    else
        m = m * 0.99;
    end
    c = seteccentricity(morph(a,b,m),normdist);
    distdiff = distdifun(a,c,targetdist);
    assert(niter < totiter,'failed to converge')
end
