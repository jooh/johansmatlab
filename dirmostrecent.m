% convenience function for returning the full path to the most recent hit
% matching the search pattern in path. Useful e.g. for cases where multiple
% analyses are stored in a master directory and you want to quickly
% retrieve the most recent one.
%
% d = dirmostrecent(path)
function d = dirmostrecent(path)

hits = dir(path);
assert(~isempty(hits),'nothing found for %s',path);

[m,ind] = max([hits.datenum]);
d = fullfile(fileparts(path),hits(ind).name);
