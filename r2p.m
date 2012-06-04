% Return one-tailed p for a given correlation coefficient and number of
% observations.
% p = r2p(rv,nv);
function p = r2p(rv,nv);

p = 1-tcdf(rv .* sqrt((nv-2) ./ (1 - rv.^2)),nv-2);
