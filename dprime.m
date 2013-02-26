% Score a set of data according to good old signal detection theory
% d = dprime(hits,misses,falsealarms,corrrejs)
function d = dprime(hits,misses,falsealarms,corrrejs)

modifier = .0001;
hits(hits==0) = modifier;
misses(misses==0) = modifier;
falsealarms(falsealarms==0) = modifier;
corrrejs(corrrejs==0) = modifier;
pHits = hits ./ (hits + misses) ;
pHits(isnan(pHits)) = 0;
pFAs = falsealarms ./ (falsealarms + corrrejs);
pFAs(isnan(pFAs)) = 0;

% Avoid infinity (effectively caps d at 4.65)
zHits = norminvinfcorrect(pHits);
zFAs = norminvinfcorrect(pFAs);

d = zHits - zFAs;

function z = norminvinfcorrect(ps)
modifier = .001;
z = norminv(ps);
infpos = isinf(z) & z>0;
infneg = isinf(z) & z<0;
z(infpos) = norminv(ps(infpos)-modifier);
z(infneg) = norminv(ps(infneg)+modifier);