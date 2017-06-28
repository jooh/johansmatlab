% assign a set of arguments (from varargin) as fields in a struct. We assume
% that the valid arguments are the default's fieldnames. If default is not
% provided any argument is accepted.
%
% NB, if passing varargin in more than one level, be sure to pass
% varargin{:} for correct behaviour.
%
% output = varargs2structfields(incell,[defaults])
function output = varargs2structfields(incell,defaults)

% Nothing to do here
if ~exist('incell','var') || isempty(incell)
    output = struct;
    return
end

if ~exist('defaults','var') || isempty(defaults)
    % run in keepunmatched mode, catch the second output (unmatched outputs)
    [~,output] = varargparse(incell{:},[],true);
    return
end
% run in ~keepunmatched mode, take the first (matched outputs)
output = varargparse(incell{:},defaults,false);
