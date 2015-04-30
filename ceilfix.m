% matlab uses ceil and floor for rounding up and down, and fix for rounding
% toward 0 regardless of sign. This function supplies the missing special
% case of rounding away from 0 regardless of sign.
%
% x = ceilfix(x)
function x = ceilfix(x)

x = ceil(abs(x)).*sign(x);
