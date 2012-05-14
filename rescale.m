% Rescale data matrix to range between ra(1) and ra(2), working along dim.
% x = rescale(x,ra,dim)
function x = rescale(x,ra,dim)

if ieNotDefined('dim')
    dim = find(size(x)>1);
    assert(length(dim)==1,'ambiguous dim')
end

xmin = min(x,[],dim);
xmax = max(x,[],dim);
xra = xmax - xmin;

ds = size(x);
dimlog = ones(1,length(ds));
dimlog(dim) = ds(dim);

% desired range
dra = range(ra);

% First shift so data start at 0
x = x - repmat(xmin,dimlog);
% Then rescale to desired range
x = (x ./ repmat(xra,dimlog)) * dra;
% Finally, reintroduce minimum
x = x + ra(1);
% 
