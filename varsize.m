% Return the size (in GB) of variable in caller's workspace.
%
% s = varsize(varname)
function s = varsize(varname)

whostruct = evalin('caller',sprintf('whos(''%s'')',varname));
s = [];
if ~isempty(whostruct)
    s = whostruct.bytes / 1024 ^ 3;
end
