% convenience function for setting values only to uninitialised variables.
% If v is empty, its input gets overwritten with val. If v is not empty we
% either do nothing, or, if assertconsistent, check that the value we were
% trying to set is is equal to the value we already had.
%
% EXAMPLES
% setifunset([],1)
% ans = 1
%
% setifunset(2,1)
% ans = 2
%
% setifunset([],1,true)
% ans = 1
%
% setifunset(2,1,true)
% Error
%
% v = setifunset(v,val,[assertconsistent=0])
function v = setifunset(v,val,assertconsistent)

if isempty(val)
    % nothing to do here
    return
end

% set unset values
if isempty(v)
    v = val;
end

if exist('assertconsistent','var') && assertconsistent==1
    assert(isequal(v,val),['v and val inputs are set to inconsistent ' ...
        'values']);
end
