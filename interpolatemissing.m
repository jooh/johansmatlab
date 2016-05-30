% Perform linear interpolation on missing values (value==target, default
% NaN) in vector d operating along the columns of d
%
% Missing values at the beginning and end of the time series get
% replaced with a constant (first/last valid value).
%
% dclean = interpolatemissing(d,target)
function alld = interpolatemissing(alld,target)

if ieNotDefined('target')
  target = NaN;
end

if isnan(target)
  missing = isnan(alld);
else
  missing = alld == target;
end
valid = ~missing;

for c = 1:size(alld,2)
    d = alld(:,c);
    if all(missing(:,c))
        logstr('column %d is all missing, skipping...\n',c);
        continue
    end
    % check for missing start/end, replace with constant
    if missing(1,c)
      firstvalid = find(valid(:,c),1,'first');
      d(1:firstvalid) = d(firstvalid);
      valid(1:firstvalid) = true;
      missing(1:firstvalid,c) = false;
    end
    if missing(end,c)
      lastvalid = find(valid(:,c),1,'last');
      d(lastvalid:end) = d(lastvalid);
      valid(lastvalid:end,c) = true;
      missing(lastvalid:end,c) = false;
    end

    % do linear interpolation on the rest
    d(missing(:,c)) = interp1(find(valid(:,c)),d(valid(:,c)),...
        find(missing(:,c)),'linear');
    alld(:,c) = d;
end
