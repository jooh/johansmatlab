% return diagonal indices for a 2D or 3D matrix of size sz (must be square
% in first and second dimensions).
%
% ind = diagind(sz)
function ind = diagind(sz)

assert(sz(1)==sz(2),'matrix must be square in first two dims');

ndim = numel(sz);
assert(ndim<4,'matrix must be 3D at most');

if ndim==2
    sz(3) = 1;
end

ind = repmat(logical(eye(sz(1))),[1 1 sz(3)]);
