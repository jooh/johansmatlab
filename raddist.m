% return the mean absolute difference in radians between the phase values
% in XI and each set of phase values in XJ (stacked in rows). Can be used
% as custom distance function for pdist.
% 
% D = raddist(XI,XJ)
function D = raddist(XI,XJ)

nj = size(XJ,1);

D = NaN([1 nj]);
for n = 1:nj
  % get the absolute signed difference in radians
  differences = abs(raddiff(XI,XJ(n,:)));
  % and average to get the MAD
  D(n) = mean(differences);
end
