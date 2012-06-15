% When passing varargin from function A to another function B, Matlab
% helpfully wraps varargin in a cell, thus breaking standard varargin
% parsing behaviour in B (e.g., varargs2structfields). This function
% unpacks any nested cell structure to return a sensible varargin (ie, a
% cell array with length>1). Note that if you do pass a single cell array
% to varargin this function will probably unpack too much.
% args = unpackvarargin(args)
function args = unpackvarargin(args)

assert(iscell(args),'incorrect input')

while length(args)==1 && iscell(args)
    args = args{1};
end
