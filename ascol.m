% Return as a column, optionally only first n elements.
% x = ascol(x,[n])
function x = ascol(x,n)
x = x(:);
if ~ieNotDefined('n')
    x = x(1:n);
end
