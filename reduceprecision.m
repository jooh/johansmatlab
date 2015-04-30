% round input x to y decimal places by operation. Default round but ceil
% and floor are also useful (e.g. for rounding p values)
%
% for an algorithmic way to identify how many digits precision is needed,
% see findprecision
%
% x = reduceprecision(x,y,func)
function x = reduceprecision(x,y,func)

% Infinite precision with floating point? Good luck with that.
if isinf(y)
    return
end

if ieNotDefined('func')
    func = @round;
end

x = func(x*(10^y))/(10^y);
