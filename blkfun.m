% Iterate over blocks (ie subsets) of mat and replace the values in each
% block with the output of calling the handle funhand with the vectorised
% block values. This function is mainly useful for decomposing RDMs.
%
% EXAMPLES
% % average each [3 3] block in a [12 12] matrix
% blkfun(rand(12,12),[3 3],@mean);
%
% % return the min of each [2 4 2] block in a [10 12 20] matrix
% blkfun(rand([10 12 20]),[2 4 2],@min);
%
% mat = blkfun(mat,blocksize,funhand)
function mat = blkfun(mat,blocksize,funhand)

% prepare arguments for quirky mat2cell syntax
matsz = size(mat);
n = matsz ./ blocksize;
nd = ndims(mat);

args = cell(1,nd);
for d = 1:nd
    args{d} = ones(n(d),1)*blocksize(d);
end

% convert to one cell per block
matc = mat2cell(mat,args{:});

% iterate over blocks, replace all entries with the output of funhand
for c = 1:numel(matc)
    matc{c}(:) = funhand(matc{c}(:));
end

mat = cell2mat(matc);
