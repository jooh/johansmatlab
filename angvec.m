% Return the angle between two vectors in radians. Note that because we use
% cosine, precision close to 0 and close to pi will not be perfect (see
% reduceprecision).
% ang = angvec(a,b)
function ang = angvec(a,b)

assert(numel(a)==numel(b) && all(size(a)==size(b)),...
    'a and b must be the same shape');

assert(isvector(a),'inputs must be row or column vectors');

% catch special case to avoid weird problems with identical vectors
% producing non-zero angles
if all(a==b)
    ang = 0;
    return
end

ang = acos(dot(a,b) / (norm(a)*norm(b)));
