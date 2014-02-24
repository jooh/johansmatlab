% convert linear indices into a logical array of size siz. 
%
% note that unlike ind2sub and sub2ind this conversion is destructive in
% that the order of the indices will be disrupted if you convert back to
% linear with find(logind).
%
% logind = ind2logical(siz,inds)
function logind = ind2logical(siz,inds)

logind = false(siz);
logind(inds) = true;
