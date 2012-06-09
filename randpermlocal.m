% Local randperm within a certain step size. The resulting vector is
% unpredictable but locally coherent
% vec = randpermlocal(n,step)
function res = randpermlocal(n,step)

assert(step<n,'stepsize must be smaller than n');

res = NaN([1 n]);
steps = 1:step:n;

for s = 1:length(steps)
    % make sure the final remainder doesn't break things
    ssize = min([step 1+n-steps(s)]);
    res(steps(s):steps(s)+ssize-1) = randperm(ssize)+steps(s)-1;
end
