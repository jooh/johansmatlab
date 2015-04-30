% outstruct = indexstructbyfield(instruct,fieldname,val)
function outstruct = indexstructbyfield(instruct,fieldname,val)

if ischar(val)
    ind = strcmp({instruct.(fieldname)},val);
else
    ind = cellfun(@(thisv)isequal(thisv,val),{instruct.(fieldname)});
end
outstruct = instruct(ind);
