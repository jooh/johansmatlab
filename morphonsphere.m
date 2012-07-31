% Morph coordinates a with respect to b by scalar s while staying on the
% shortest path along the surface of a hypersphere that both a and b are
% assumed to be on. s==1 gives all a, s==0 gives all b. 
%
% This should be solvable analytically but in the absence of such a
% solution we use a fminbnd search to find the appropriate morph level to
% achieve the desired ab angle, ie angvec(a,b)*s.
%
% c = morphonsphere(a,b,s)
function c = morphonsphere(a,b,s)

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

% shortcircuit processing for speed when in simple cases where the
% euclidean distance is the same as the surface distance
c = seteccentricity(morph(a,b,s),normdist);
if any(s == [0 1 .5])
    return
end
halfdist = seteccentricity(morph(a,b,.5),normdist);

% Rather than morphing between a and b, morph between ac or bc. This is
% useful for cases where b is near-opposite a
if s < .5
    % somewhere between b and halfdist
    org = b;
    % the angle we originally wanted was between b (0) and a (1). Now it's
    % between b (0) and halfdist (.5), so need to scale things up.
    ang_target = angvec(org,halfdist) * s*2;
else
    % somewhere between a and halfdist
    org = a;
    % the angle we originally wanted was between b (0) and a (1). Now it's
    % between a (1) and halfdist (.5), so need to change sign and scale
    ang_target = angvec(org,halfdist) * (1-s)*2;
end

% optimise the absolute difference between the org-c angle and the target
% angle
ofun = @(m) abs(angvec(org,morph(org,halfdist,m))-ang_target);
% minute changes in morph level produce huge angle changes so need to
% iterate to fairly high precision
opts = optimset('TolX',1e-100,'TolFun',1e-100,'MaxIter',10e3);
[m,angdiff,exflag,output] = fminbnd(ofun,0,1,opts);
assert(exflag==1,'optimisation did not converge')
% produce the output vector with the same length as the hypersphere radius
c = seteccentricity(morph(org,halfdist,m),normdist);
