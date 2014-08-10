function [outx,outy,bootx,booty] = movingaverage(x,y,n,nboot)

if ieNotDefined('nboot')
  nboot = 0;
end

% make rows
[xs,ind] = sort(x(:));
y = y(:);
ys = y(ind);
nr = numel(x);

step = (n-1)/2;
stepdown = floor(step);
stepup = ceil(step);

outx = xs;
outy = ys;

bootx = [];
booty = [];

nr = numel(x);
for r = 1:nr
  inds = max([1 r-stepdown]):min([nr r+stepup]);
  nind = numel(inds);
  outx(r) = mean(xs(inds));
  outy(r) = mean(ys(inds));
  parfor b = 1:nboot
    % sample the indices in this window with replacement
    bootind = inds(ceil(rand(1,nind)*nind));
    bootx(r,b) = mean(xs(bootind));
    booty(r,b) = mean(ys(bootind));
  end
end
