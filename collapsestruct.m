% collapse the numeric data across entries in a possibly nested struct
% array. collapsefun (default @mean) is a handle to a function that defines
% the operation to apply (any function that takes data as first input and a
% dimension to operate over as the second input).
%
% Non-numeric entries are ignored (we take the entry from the first array
% and ignore all subsequent entries).
%
% out = collapsestruct(in,[collapsefun])
function out = collapsestruct(in,collapsefun)

if ieNotDefined('collapsefun')
    collapsefun = @mean;
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
    if isnumeric(out.(fnstr)) || islogical(out.(fnstr))
        targetdim = ndims(out.(fnstr))+1;
        fullmat = cat(targetdim,d{:});
        out.(fnstr) = feval(collapsefun,fullmat,targetdim);
    end
end
