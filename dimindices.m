% return logical indices correspond to logical indices along some dim. This
% is useful for updating the content of some matrix where the
% dimensionality may vary (e.g. conventional x(:,2,:) = y indexing may not
% work if x is sometimes 3D, sometimes 4D).
%
% EXAMPLES:
% %% indices for second row in a [4 3 2] matrix
% xind = dimindices([4 3 2],2,1)
%
% see also indexdim.
%
% xind = dimindices(x,ind,dim)
function xind = dimindices(xsz,ind,dim)

xind = false(xsz);

allinds = arrayfun(@(n)1:n,xsz,'uniformoutput',0);
allinds{dim} = ind;

xind(allinds{:}) = true;
