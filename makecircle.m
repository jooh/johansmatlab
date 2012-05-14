% circ = makeCircle(diameter)
% Adapted from Kamitani
% 2/2/2012 J Carlin

function circ = makecircle(x)

%if isodd(x)
    %x = x+1;
%end

X = ones(x,1) * [-floor(x/2):(ceil(x/2)-1)];
Y = [-floor(x/2):(ceil(x/2)-1)]' * ones(1,x);

Z = X.^2 + Y.^2;

circ = Z <= round(x/2)^2;
