% concatenate inputs in third dimension (ie cat(3,varargin{:})) mostly a
% convenient extention of horzcat and vertcat for e.g. collapsestruct.
%
% x = zcat(varargin)
function x = zcat(varargin)

x = cat(3,varargin{:});
