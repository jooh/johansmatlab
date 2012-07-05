% Return the input scalar x bounded by the [1 2] array lims.
% x = inrange(x,lims)
function y = inrange(x,lims)

assert(lims(1)<lims(2),'min lims must be less than max lims')

xl = sort([lims x]);
% If all is well, x is in the middle. If all is not well, we will get one
% of the lims instead
y = xl(2);
