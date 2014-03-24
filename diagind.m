function ind = diagind(sz)

assert(sz(1)==sz(2),'matrix must be square in first two dims');
if numel(sz)==2
    sz(3) = 1;
end

ind = repmat(logical(eye(sz(1))),[1 1 sz(3)]);
