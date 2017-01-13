% rename a field in a struct array. Supports struct arrays, empty arrays.
%
% st = renamefield(st,oldname,newname)
function st = renamefield(st,oldname,newname)

[st(:).(newname)] = deal(st.(oldname));
st = rmfield(st,oldname);
