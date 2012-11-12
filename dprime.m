% Score a set of data according to good old signal detection theory
% d = dprime(hits,misses,falsealarms,corrrejs)
function d = dprime(hits,misses,falsealarms,corrrejs)

pHits = hits ./ (hits + misses) ;
pHits(isnan(pHits)) = 0;
pFAs = falsealarms ./ (falsealarms + corrrejs);
pFAs(isnan(pFAs)) = 0;
modifier = .01;

% Avoid infinity (effectively caps d at 4.65)
zHits = norminv(pHits);
zHits(isinf(zHits)) = norminv(1-modifier);
zFAs = norminv(pFAs);
zFAs(isinf(zFAs)) = norminv(modifier);

d = zHits - zFAs;
