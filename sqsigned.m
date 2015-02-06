% square while preserving sign (see also sqrtsigned)
% x = sqsigned(x)
function x = sqsigned(x)

x = abs(x).^2 .* sign(x);
