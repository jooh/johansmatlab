% Use Justin's getArgs code to assign a set of arguments (from varargin) as
% fields in a struct. We assume that the valid arguments are the
% outstruct's fieldnames
% output = varargs2structfields(input,output)
function output = varargs2structfields(input,output)

% Nothing to do here
if isempty(input)
    return
end

valid = fieldnames(output);

[properties,values] = getArgs(input,valid,...
    'doAssignment=0','verbose=0');

for p = 1:length(properties)
    output.(properties{p}) = values{p};
end
