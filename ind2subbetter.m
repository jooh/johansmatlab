% similar functionality to ind2sub, but returns a numel(ind) by numel(sz)
% matrix as a single output instead of returning each dimension as its own
% varargout. This is useful for flexibly working with matrices where
% dimensionality may vary.
%
% x = ind2subbetter(sz,ind)
function x = ind2subbetter(sz,ind)

nd = numel(sz);
x = cell(1,nd);
[x{1:nd}] = ind2sub(sz,ind(:));
x = cell2mat(x);
