% check for the availability of a parpool in a somewhat Matlab version-agnostic
% way.
%
% yes = hasparpool()
function yes = hasparpool()

yes = true;
% check that parfor is available
try 
    n = numel(gcp('nocreate'));
catch
    n = matlabpool('size');
end
if ~n
    yes = false;
end
