% replacement for dir with behaviour that more closely resembles unix ls or
% python glob.
%
% Changes relative to dir:
% 1) file.abspath preserves input pattern path
% 2) '.' and '..' outputs are suppressed. Note that this has consequences
%   if you were using something like isempty(dir(x)) to test for valid
%   paths.  You should probably use isdir or exist for this instead.
% 3) multi-level wildcards are supported. Behaviour here is more like unix
%   ls than find - we don't recurse into sub-directories beyond what the
%   search pattern specifies.
%
% EXAMPLES:
% dirbetter('~/temp/*/*/*.png') % return PNGs 2 directories down from
% ~/temp.  
% dirbetter('~/temp/*') % return any file/directory inside ~/temp itself
%
% 2016-12-06 J Carlin
%
% file = dirbetter(pattern)
function file = dirbetter(pattern)

wildcard = find(pattern=='*');
dirsep = find(pattern==filesep);
% matlab's dir has a very straightforward limitation: filesep AFTER
% wildcard is not supported
badwild = find(wildcard < max(dirsep),1,'first');
if isempty(badwild)
    % so in this scenario all is well
    file = absdir(pattern);
    return
end

% we need to unpack the wildcards
% first work out how far we can go before we hit a problem
targetsep = dirsep(dirsep > wildcard(badwild));
[~,ind] = min(targetsep-wildcard(badwild));
finalind = targetsep(ind);
partialpattern = pattern(1:finalind-1);
remainingpattern = pattern(finalind+1:end);

partialhit = absdir(partialpattern);
wasdir = find(arrayfun(@(x)x.isdir,partialhit,'uniformoutput',1));
file = struct('name',{},'date',{},'bytes',{},'isdir',{},...
    'datenum',{},'abspath',{});
for w = 1:numel(wasdir)
    % construct a new search pattern (which resolves out the first
    % wildcard)
    newpattern = fullfile(partialhit(wasdir(w)).abspath,remainingpattern);
    % fullfile sometimes adds a filesep to the end of the path
    if newpattern(end)==filesep
        newpattern(end) = [];
    end
    % and recurse to collect all the hits (so we will recurse to the same
    % number of levels as the nuber of wildcards)
    newhit = dirbetter(newpattern);
    if ~isempty(newhit)
        % this extra conditional is needed to avoid growing a [0,n] struct
        % array. 
        file = [file; newhit];
    end
end

function hits = absdir(pattern)

hits = dir(pattern);
% need this so that empty structs (no hits) also have this field
[hits.abspath] = deal([]);
% always eliminate parent dir and current dir
hits(strcmp({hits.name},'..')) = [];
hits(strcmp({hits.name},'.')) = [];

root = pattern;
if ~isdir(root)
    root = fileparts(pattern);
end

for thishit = 1:numel(hits)
    hits(thishit).abspath = fullfile(root,hits(thishit).name);
end
