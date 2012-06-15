% Create a x:y vector which repeats each integer r times.
% v = repinds(x,y,r)
function v = repinds(x,y,r)

x = repmat(x:y,[r 1]);
v = x(:);
