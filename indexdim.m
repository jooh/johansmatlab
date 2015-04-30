% index along dims dim of matrix x while preserving all other dimensions.
% This is useful for cases where the meaning of each dimension is known but
% the number of dimensions may vary (e.g. conventional x(:,2,:) style
% indexing may not produce the intended result if x is sometimes 3D,
% sometimes 4D). Supports numerical or logical indices. You can specify
% multiple dim inputs which will be indexed similarly.
%
% EXAMPLES:
% % slice out the second and third columns in 3D matrix
% indexdim(rand(3,4,3),[1 3],2);
%
% % pick the first 2 entries from the first and third dims
% indexdim(rand(3,4,3),[1 2],[1 3])
%
% see also dimindices.
%
% x = indexdim(x,ind,dim)
function x = indexdim(x,ind,dim)

xsz = size(x);

allinds = arrayfun(@(n)1:n,xsz,'uniformoutput',0);
ind = repmat({ind},[1 numel(dim)]);
[allinds{dim}] = deal(ind{:});

x = x(allinds{:});
