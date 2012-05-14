% Blend matrices a and b by scalar prop. prop 1 means all a, prop 0 all b.
function c = blend(a,b,prop)

assert(prop >= 0 && prop <= 1);

c = (a*prop) + (b*(1-prop));
