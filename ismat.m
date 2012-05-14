% Likely superfluous in more recent Matlab versions
% yes = ismat(x)
function yes = ismat(x)

sz = size(x);

yes = false;
if sz(2)>1 && sz(1)>1
    yes = true;
end
