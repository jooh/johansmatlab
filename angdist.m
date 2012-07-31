% an angle distance function to be used with pdist(x,@angdist). NB, reduces
% precision to 3 decimal places since angvec is inherently imprecise. So
% can't estimate extremely fine angle distances
% D = angdist(a,b)
function  D = angdist(XI,XJ)

nj = size(XJ,1);

D = NaN([1 nj]);
for n = 1:nj
    D(n) = angvec(XI,XJ(n,:));
end
% unfortunately angle precision isn't what it should be so can't trust
% measures beyond this
D = reduceprecision(D,3);
