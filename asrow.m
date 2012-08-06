% Return as a row, optionally only first n elements.
% x = asrow(x,[n])
function x = asrow(x,n)
x = x(:)';
if ~ieNotDefined('n')
    x = x(1:n);
end
