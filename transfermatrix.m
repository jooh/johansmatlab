% Compute a second-order transfer matrix for vector v
% tmat = transfermatrix(v)
function tmat = transfermatrix(v)

assert(isvector(v),'input v must be row or column vector')
tmat = full(sparse(v(1:end-1),v(2:end),1));
