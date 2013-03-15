%  plugin for pdist to summarise overlap between non-zero entries in
%  vectors (0 for no overlap).
%  D = overlapdist(XI,XJ)
function  D = overlapdist(XI,XJ)

XI = XI~=0;
XJ = XJ~=0;

nj = size(XJ,1);

D = NaN([1 nj]);
for n = 1:nj
    D(n) = sum(XI & XJ(n,:));
end
