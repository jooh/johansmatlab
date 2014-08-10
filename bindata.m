% rescore data to nbin unique values by linear quantization. The bins will
% be equidistant in units x but may contain different number of elements.
%
% see also bindata_prc.
%
% x = bindata(x,nbin);
function x = bindata(x,nbin);

xr = range(x) ./ (nbin-1);
% rescore to units xr, and round up/down to nearest. Then scale back to
% original units.
x = round(x ./ xr) * xr;
