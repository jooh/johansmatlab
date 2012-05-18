% Use Justin's getArgs code to assign a set of arguments (from varargin) as
% fields in a struct. We assume that the valid arguments are the output's
% fieldnames. If the output is not provided any argument is accepted. verbose
% (default 0) shows which arguments are being set.
% output = varargs2structfields(input,[output],[verbose])
function output = varargs2structfields(input,output,verbose)

% Nothing to do here
if isempty(input)
    return
end

if ieNotDefined('verbose')
    verbose = 0;
end

if ieNotDefined('output')
    output = struct;
    valid = [];
else
    valid = fieldnames(output);
end

[properties,values] = getArgs(input,valid,...
    'doAssignment=0','verbose',verbose);

for p = 1:length(properties)
    output.(properties{p}) = values{p};
end
