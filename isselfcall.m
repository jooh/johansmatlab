% Return true if the caller function/method appears more than once in the
% stack. Useful for preventing unwanted recursion.
% selfcall = isselfcall()
function selfcall = isselfcall()

st = dbstack;
% catch calls from base
if length(st) < 2
    selfcall = 0;
    return
end
parent = st(2).name;
selfcall = length(findStrInArray({st.name},parent,1)) > 1;
