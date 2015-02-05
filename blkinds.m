% return the logical indices for the block diagonal of size n for a matrix
% with size matsize. If n is scalar we assume the same value should be used
% for all dimensions of matsize.
%
% EXAMPLES
% % 2x2 blocks in a [10 10] matrix
% blkinds([10 10],2);
%
% % [4 3] blocks into a matrix of size [12 9]
% blkinds([12 9],[4 3]);
%
% ind = blkinds(matsize,n)
function ind = blkinds(matsize,n)

if isscalar(n)
    n = repmat(n,size(matsize));
end
assert(isequal(size(n),size(matsize)),...
    'n must be equal shape as matsize or scalar')
nrep = matsize ./ n;
assert(isequal(nrep,round(nrep)),'matsize must be divisible by n');

for d = 1:ndims(matsize)
    dimind{d} = repinds(1,nrep(d),n(d));
end
ind = logical(eye(matsize));
ind = ind(dimind{:});
