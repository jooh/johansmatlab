% Perform linear interpolation on missing values (value==target, default
% NaN) in 1D vector d.
%
% Missing values at the beginning and end of the time series get
% replaced with a constant (first/last valid value).
%
% dclean = interpolatemissing(d,target)
function d = interpolatemissing(d,target)

if ieNotDefined('target')
  target = NaN;
end

if isnan(target)
  missing = isnan(d);
else
  missing = d == target;
end
valid = ~missing;

% check for missing start/end, replace with constant
if missing(1)
  firstvalid = find(valid,1,'first');
  d(1:firstvalid) = d(firstvalid);
  valid(1:firstvalid) = true;
  missing(1:firstvalid) = false;
end
if missing(end)
  lastvalid = find(valid,1,'last');
  d(lastvalid:end) = d(lastvalid);
  valid(lastvalid:end) = true;
  missing(lastvalid:end) = false;
end

% do linear interpolation on the rest
d(missing) = interp1(find(valid),d(valid),find(missing),'linear');
