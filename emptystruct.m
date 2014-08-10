% initialise an empty struct with a specified set of fields.
%
% For general struct pre-allocation cell2struct is probably faster
% (although difficult to call correctly). This function is specifically for
% the case of creating an empty struct, which cell2struct does not support.
%
% s = emptystruct(varargin)
function s = emptystruct(varargin)

% lots of interesting matlab indexing voodoo here
% note that you need double cell here - otherwhise this returns a single {}
% regardless of nargin (if this behaviour makes sense to you you probably
% work for Mathworks)
v = repmat({{}},[1 nargin]);
% expand the two cell arrays into lists, which we reassemble as columns in
% a new cell array
l = {varargin{:}; v{:}};
% now the vectorisation of that 2d array gives us the required name-value
% pairs that struct requires
s = struct(l{:});
