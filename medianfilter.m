% Matlab's builtin medfilt1 is curiously slow. This runs a lot faster. d is
% assumed to be a 2D matrix where the filter should be applied along each
% row. n must be an odd, positive integer.
% outd = medianfilter(d,n)
function outd = medianfilter(d,n)

step = (n-1)/2;
stepdown = floor(step);
stepup = ceil(step);
outd = d;

[nr,nf] = size(d);
colind = 1:nf;
% could do parfor here but in my experience there's little gain
for r = 1:nr
    outd(r,colind) = median(d(max([1 r-stepdown]):min([nr r+stepup]),...
        colind),1);
end
