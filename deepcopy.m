% As of R2009a, Matlab has no solution for deep-copying handle classes
% (obj2=obj will not give you a copy, just another handle on the same
% data). Once you get over your disillusion and shelve the plans to switch
% to Python once and for all, you can use this hacky solution based on
% writing out the instance to a mat file, reloading said mat and deleting
% the temp file. Obviously this is very slow so use only if absolutely
% necessary.
%
% obj = deepcopy(obj)
function obj = deepcopy(obj)

% use system's tempdir if possible
td = tempdir;
if ieNotDefined('td')
    % if not, use function dir
    td = fileparts(which('deepcopy'));
end

tp = fullfile(td,'tmp.mat');

save(tp,'obj');
load(tp);
delete(tp);
