% set vectors to unit length (norm=1, approximately). Supports matrix
% inputs (each column is normed separately).
%
% x = unitlen(x)
function x = unitlen(x)

x = bsxfun(@rdivide,x,sqrt(sum(x.^2)));
