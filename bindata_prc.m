% rescore data to nbin unique values by taking the mean of each
% percentile-defined bin. The bins will have an equal (or as close as
% possible to equal) number of elements but will not necessarily be
% equidistant in units x.
%
% see also bindata.
%
% TODO: repair. Does not handle non-unique vectors well at the moment.
%
% x = bindata_prc(x,nbin)
function newx = bindata_prc(x,nbin)

vals = prctile(x,linspace(0,100,nbin+1));
vals([1 end]) = [-Inf Inf];

[c,inds] = histc(x,vals);
% oddly, c returns an empty, unused final value so can't use this
newx = x;
for v = asrow(unique(inds))
  newx(inds==v) = mean(x(inds==v));
end
