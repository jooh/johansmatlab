% a (abs) mean distance function to be used with pdist(x,@meandist). Mainly
% useful for getting differences between scalars.
% % D = meandist(a,b)
function  D = meandist(XI,XJ)

nj = size(XJ,1);

D = NaN([1 nj]);
for n = 1:nj
    D(n) = abs(mean(XI,2) - mean(XJ(n,:),2));
end
