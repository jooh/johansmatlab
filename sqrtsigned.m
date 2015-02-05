% Returned the signed square root of the values in x. This is mainly useful
% when transforming cross-validated estimates of squared distances (ie,
% cases where negative values are meaningful as representing part of a null
% distribution of cross-validated distances).
%
% x = sqrtsigned(x)
function x = sqrtsigned(x)

x = sqrt(abs(x)) .* sign(x);
