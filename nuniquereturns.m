% call funhand nret times and return only once all nret draws in the cell
% array r are unique. outshape defines the size of the expected output from
% funhand (we figure this out by calling once if you leave it undefined).
%
% we return niter mainly for testing purposes - this function does not
% explicitly test the feasibility of the request you make so it can be
% useful to check niter with different parameters to get a feeling for what
% constraints are practical. 
%
% this function is useful for generating unique sets of random
% samples for e.g. trial randomisation or permutation
% testing.
%
% For example, generate 100 unique sets of indices between 1 and 6:
% [r,niter] = nuniquereturns(@()randperm(6),100);
%
% [r,niter] = nuniquereturns(funhand,nret,[outshape])
function [r,niter] = nuniquereturns(funhand,nret,outshape)

if ieNotDefined('outshape')
    outshape = size(feval(funhand));
end

done = false;
r = repmat({NaN(outshape)},[1 nret]);
outvec = prod(outshape);
% super-explicit indexing for parfor support
outind = 1:outvec;
rmat = NaN([nret,outvec]);
niter = 0;
while ~done
    % generate the nret function returns
    for n = 1:nret
        % store in both original and vectorised form
        r{n} = feval(funhand);
        rmat(n,outind) = r{n}(:);
    end
    % use pdist to test equality of all pairs (euclidean distance==0)
    if ~any(pdist(rmat)==0)
        done = true;
    end
    niter = niter + 1;
    assert(niter < 1e4,'iteration limit exceeded, no uniques sets found')
end
