% Return function's name and directory (or optionally the name/path of the
% function n steps up the stack)
% [fname,fpath] = namepath(n)
function [fname,fpath] = namepath(n)

if ieNotDefined('n')
    n = 1;
end
n = n+1;
st = dbstack;
assert(length(st)>=n,'n exceeds stack length');
fname = st(n).name;
fpath = fileparts(which(fname));
