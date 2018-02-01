% generate random cartesian coordinates that are uniformly distributed on a
% hypersphere's surface (radius 1, m 0). Uses a method from Muller (1959)
% described on Wolfram entry on HyperspherePointPicking.
% TODO: make matrix operation.
% cart = randhyperspherepoint(ndims,npoints)
function cart = randhyperspherepoint(ndim,npoints)

norms = randn(ndim,npoints);
norms_sq = norms.^2;
dimssq = 1 ./ sqrt(sum(norms_sq,1));
dimssq_mat = repmat(dimssq,[ndim 1]);

cart = dimssq_mat .* norms;
