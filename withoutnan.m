% x = withoutnan(x)
function x = withoutnan(x)

x = x(~isnan(x));
