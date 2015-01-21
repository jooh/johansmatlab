% Lazy man's concatenation - find a dimension over which to concatenate,
% don't care which. Useful in non-performance critical code where the
% exact shape of the arrays don't matter (e.g. if you are going to iterate
% over the linear indices anyway).
%
% This means picking the first available dim when all dims match, or the
% one non-discrepant dim when all but one dims match. If more than 2 dims
% are discrepant concatenation is not possible and we raise an exception.
%
% [x,matchdim] = justcat(varargin)
function [x,matchdim] = justcat(varargin)

shapes = cellfun(@size,varargin,'uniformoutput',0);
if isequal(shapes{1},shapes{:})
    % if all the dims match we simply use the first
    matchdim = 1;
else
    % when there are mismatched dims we need to work out how to concatenate
    nd = cellfun(@numel,shapes);
    shapemat = ones([nargin,max(nd)]);
    % this extra bit of dribbling is necessary to deal with cases where
    % ndims varies (due to Matlab squeezing off the last dimensions when 1)
    for n = 1:nargin
        shapemat(n,1:numel(shapes{n})) = shapes{n};
    end
    % dims where the inputs do not match
    matchdim = find(~all(bsxfun(@eq,shapemat,shapemat(1,:)),1));
    assert(numel(matchdim)==1,...
        'no concatenation possible if more than one dim is discrepant');
end
x = cat(matchdim,varargin{:});
