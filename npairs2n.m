% Given that scalar np is the number of all possible pairs between a set of
% n variables, find n.
% n = npairs2n(npairs)
function n = npairs2n(npairs)

n = (sqrt(8*npairs+1)-1)/2+1;
