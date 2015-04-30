% find the level of precision (in terms of number of decimal places) that
% is required to plot the data in x without any value rounding to 0. Can be
% used in conjunction with e.g. roundplotlimits and reduceprecision to set
% plot limits and ticks adaptively.
%
% n = findprecision(x)
function n = findprecision(x)

% so to appreciate why this works...
% 1. max because we want to take the largest n out of the possibly many
% numbers in the input array x
% 2. ceil and -log10 to get to the nearest log10, again rounding up so that
% even .099 evaluates to 2
% 3. abs because -log10 is only real for positive numbers
% 4. + eps(0) because we want to avoid Inf for x==0 case (instead you will
% get 254 digits precision but hey, at least you will get a result).
n = max(ceil(-log10(abs(x(:)+eps(0)))));
