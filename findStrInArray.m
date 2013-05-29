% Quick utility function for finding indices for all entries in a cell array x
% that contain a string matching pattern p. exactmatch defaults to 0 (if 1
% you get a slower loop-based search)
% inds = findStrInArray(x,p,exactmatch)
% 13/2/2012 J Carlin
function inds = findStrInArray(x,p,exactmatch)

if isempty(x) || isempty(p)
  inds = [];
  return
end

if ieNotDefined('exactmatch') || ~exactmatch
	inds = find(1-cellfun('isempty',strfind(x,p)));
else
	% Slow but precise search
	inds = [];
	for r = 1:length(x)
		if length(x{r}) == length(p) && all(x{r}==p)
			inds(end+1) = r;
		end
	end
end


