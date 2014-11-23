% wrapper for unique that enables NaN support. See also the built-in
% isequaln.
%
% varargout = uniquen(varargin)
function varargout = uniquen(varargin)

nanresc = max(varargin{1}(:))+111;
varargin{1}(isnan(varargin{1})) = nanresc;
[varargout{1:nargout}] = unique(varargin{:});
varargout{1}(varargout{1}==nanresc) = NaN;
