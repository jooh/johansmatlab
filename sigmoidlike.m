% return a sigmoid-like function of the form
% y = 1 ./ (1+exp((-x+offset)./s));
%
% s controls the steepness of the saturation (smaller for more step-like,
% larger for more linear). Note that negative values flips the direction of
% the function.
%
% y = sigmoidlike(x,s,offset)
function y = sigmoidlike(x,s,offset)

y = 1 ./ (1+exp((-x+offset)./s));
