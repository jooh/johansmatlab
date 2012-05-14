% Likely superfluous in more recent Matlab versions
% yes = iscol(x)
function yes = iscol(x)

sz = size(x);

yes = false;
if sz(1)>1 && sz(2)==1
    yes = true;
end
