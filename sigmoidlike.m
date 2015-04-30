% return a sigmoid-like function of the form
% y = 1 ./ (1+exp((-x+offset)./10^-s));
%
% s controls the steepness of the saturation (smaller for more linear,
% larger for more step-like), and is scored in negative powers of 10. 
% offset is the horizontal offset of the function (its steepest portion).
%
% y = sigmoidlike(x,s,offset)
function y = sigmoidlike(x,s,offset)

y = 1 ./ (1+exp((-x+offset)./10^-s));
