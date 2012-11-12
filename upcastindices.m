% Upcasts inds by factor n. The resulting upinds vector is n times the
% length of inds. For instance, the indices [1 3 4] becomes [1 2 5 6 7 8]
% with n=2, or [1 2 3 7 8 9 10 11 12] with n=3. Mainly useful for cases
% where for every entry in vector x you want to retrieve 2 entries in y (a
% vector with twice the length of x).
% upinds = upcastindices(inds,n)
function upinds = upcastindices(inds,n)

inds = asrow(inds);
upinds = sort(repmat((inds-1)*n+1,[1 n])) + ...
    repmat(0:(n-1),[1 length(inds)]);
