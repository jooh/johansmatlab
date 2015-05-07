function r = pdf2rand(pdf,x,n)

assert(isvector(pdf),'only 1D pdfs are supported');

if isvector(n)
    % assume input for rand
    n = rand(n);
end
% otherwise we assume n is the input we want to convert (e.g., pre-cooked
% random numbers, numbers of a non-standard class etc)

pdf = pdf(:);
x = x(:);
% ensure valid pdf (probabilities sum to 1)
pdf = pdf ./ sum(pdf);
cdf = cumsum(pdf);
% remove non-unique values (otherwise the interpolation will exaggerate
% repeated values)
[cdf, mask] = unique(cdf);
x = x(mask);
r = interp1(cdf,x,n);
