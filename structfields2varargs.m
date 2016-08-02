% convert a struct to a cell array of named input arguments. See also
% varargs2structfields.
% 
% args = structfields2varargs(instruct)
function args = structfields2varargs(instruct)

assert(numel(instruct)==1,'instruct must be single entry struct array');

args = {};
for fn = fieldnames(instruct)'
    fnstr = fn{1};
    args = [args {fnstr,instruct.(fnstr)}];
end
