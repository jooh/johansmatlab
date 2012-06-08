% Morph coordinates a with respect to b by scalar s. s=1 gives all a, s=0
% gives all b, -1 gives the 'anti-a' in b-norm space, 2 gives the
% caricatured a in b-norm, etc etc...
% c = morph(a,b,s);
function c = morph(a,b,s);

assert(isscalar(s),'scale factor s must be scalar')
assert(ndims(a)==ndims(b),'coordinates must have same dimensionality')
assert(all(size(a)==size(b)),'coordinates a and b must be the same size')

% to intuit what happens here, b is made the norm of the space by
% subtraction. The normed a is then multiplied by a scalar to move
% away/towards normed b. Finally, b is added to translate the space back to
% it original norm.
c = (a-b)*s+b;
