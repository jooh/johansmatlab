% function [d,pfit] = polydetrend(d,deg)
function [d,pfit] = polydetrend(d,polydeg)

dsize = size(d);
pmat = constructpolynomialmatrix(dsize(1),0:polydeg);
pfit = pmat * (pmat \ d);
d = d - pfit;
