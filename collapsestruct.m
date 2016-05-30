% collapse the numeric data across entries in a possibly nested struct
% array. collapsefun (default @matmean) is a handle to a function that defines
% the operation to apply (any function that takes data as varargin).
%
% Non-numeric entries are ignored (we take the entry from the first array
% and ignore all subsequent entries).
%
% out = collapsestruct(in,[collapsefun],[docell])
function out = collapsestruct(in,collapsefun,docell)

if ieNotDefined('collapsefun')
    collapsefun = @matmean;
end

if ieNotDefined('docell')
    docell = false;
end

out = in(1);
n = numel(in);
if n == 1
    return;
end

for fn = fieldnames(in)'
    fnstr = fn{1};
    d = {in.(fnstr)};
    % check class consistency
    fieldclass = cellfun(@(c)class(c),d,'uniformoutput',false);
    assert(isequal(fieldclass{:}),'mismatched classes for %s',fnstr);
    % numeric and logicals get processed, all others just get ignored (take
    % first value)
    if isnumeric(out.(fnstr)) || islogical(out.(fnstr)) || (docell && iscell(out.(fnstr)))
        out.(fnstr) = feval(collapsefun,d{:});
    end
end
