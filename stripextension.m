% strip file extension from file name, if any. Surely matlab does this already?
% Nope, fileparts is not robust to paths where directory names (e.g. user home
% directories) contain full stops. This function is.
%
% fn = stripextension(fn)
function fn = stripextension(fn)

if iscell(fn)
    fn = cellfun(@stripextension,fn,'uniformoutput',0);
    return
end

% filter out anything before the last file separator for the purposes of the
% test
lastsep = find(fn == filesep,1,'last');
if isempty(lastsep)
    lastsep = 0;
end

% take the first full stop of the remainder (to catch double extensions a la
% tar.gz).
extind = find(fn(lastsep+1:end) == '.',1,'first');
if isempty(extind)
    % nothing to do here
    return
end
% cut off the extension
fn = fn(1:(lastsep+extind-1));
