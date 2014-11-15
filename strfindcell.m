% Return indices where pattern p (char) matches x (cell), or where patterns
% p (cell) matches x (char). Similar behavior to strcmp but with
% tolerance for inexact matches. Like strfind, this returns numerical
% rather than logical indices.
%
% EXAMPLES:
% To match a single pattern to a set of alternatives, enter alternatives as
% cell x and pattern as char p. 
% inds = strfindcell({'b_a','a_b'},'b_'); % returns 1
%
% To match multiple patterns to a single full alternative, enter
% alternatives as char x and patterns as cell p.
% inds = strfindcell('b_a',{'b_','a_'}); % returns 1
%
% inds = strfindcell(x,p)
%
% 15/11/2014 J Carlin
function inds = strfindcell(x,p)

if isempty(x) || isempty(p)
    % no match by definition
    inds = [];
    return
end

msg = 'either x or p must be char';
if iscell(x)
    % normal mode - x is a cell array of options, p is a char pattern
    assert(ischar(p),msg);
    cellind = strfind(x,p);
elseif iscell(p)
    % reverse mode - x is a char and p is a cell array of possible patterns
    assert(ischar(x),msg);
    % so need to be a little bit smarter
    cellind = cellfun(@(thisp)strfind(x,thisp),p,'uniformoutput',0);
else
    error(msg);
end

% return non-empties
inds = find(1-cellfun(@isempty,cellind));
