% Return true if the caller function/method appears more than once in the
% stack. Useful for preventing unwanted recursion.
% selfcall = isselfcall()
function selfcall = isselfcall()

% get stack excluding this function
st = dbstack(1);
% catch calls from base
if length(st) < 2
    selfcall = 0;
    return
end
parent = st(1).name;
selfcall = any(strcmp({st(2:end).name},parent));
