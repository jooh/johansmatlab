% Morph coordinates a with respect to b by scalar s. s=1 gives all a, s=0
% gives all b, -1 gives the 'anti-a' in b-norm space, 2 gives the
% caricatured a in b-norm, etc etc...
% c = morph(a,b,s);
function c = morph(a,b,s);

assert(isscalar(s),'scale factor s must be scalar')

% to intuit what happens here, b is made the norm of the space by
% subtraction. The normed a is then multiplied by a scalar to move
% away/towards normed b. Finally, b is added to translate the space back to
% it original norm.
% c = (a-b)*s+b;
% below we add array expansion - so as long as the inputs share one
% dimension length we can morph. This is useful for e.g. translating each
% row or column toward its average, or shrinking toward zero.
c = bsxfun(@plus,bsxfun(@minus,a,b)*s,b);
