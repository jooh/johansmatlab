% Remove characters that matlab tends to choke on, replace all with second
% input (or by default nothing). Uses Matlab's builting strrep so x can be a
% cell array or string.
% x = stripbadcharacters(x,r)
function x = stripbadcharacters(x,r)

% strrep crashes on empty inputs so short-circuit to avoid this
if isempty(x) || iscell(x) && length(x)==1 && isempty(x{1})
    return
end

if ieNotDefined('r')
  r = '';
end

badchars = '() _-/:\~`';

for b = badchars
  x = strrep(x,b,r);
end
