% Print a string with and printf formatting required (enter in varargin)
% depending on current settings. This function is basically a wrapper
% around fprintf, which additionally offers control over whether output is
% printed and what extra information gets added to the input string. So in
% practice all calls to fprintf can be replaced with this function with no
% change to existing functionality.
% 
% Print behavior is controlled by the logstr_verbose global variable, which
% can take the following values:
%   0: no display at all
%   1: display input text as is (standard fprintf behavior)
%   2: (default) as 1, also prepend function name in brackets
%   3: as 2, also prepend line number
%
% TODO: print to text file instead of screen functionality.
%
% logstr(txt,[varargin])
function logstr(txt,varargin)

global logstr_verbose

if isempty(logstr_verbose) 
  logstr_verbose = 2;
end

if logstr_verbose == 0
  return
end

[d,ind] = dbstack;
prefix = '';
if ind~=numel(d) && logstr_verbose > 1
  prefix = d(ind+1).name;
  if logstr_verbose>2
    prefix = sprintf('%s:%03d',prefix,d(ind+1).line);
  end
  prefix = ['(' prefix ') '];
end

fprintf(['%s' txt],prefix,varargin{:});
