% given a (non-nested) struct and a class name, attempt to build an
% instance by calling the class with no arguments and then dealing the
% struct's fieldnames to the instance's properties. This will only work if
% a) your class supports instancing with no input arguments, b) your class
% has only public, writeable fields.
%
% Detects stored function handles by picking up chars that begin with '@'.
%
% Used to support struct2obj, which supports recursion to handle nested
% object instances - you should probably use this wrapper instead.
%
% obj = rebuildobj(instruct,objclass)
function outobj = rebuildobj(instruct,objclass)

for n = 1:length(instruct)
    try
        outobj(n) = feval(objclass);
    catch exception
        % this is necessary because these errors can be incredibly cryptic.
        % They often arise when attempting to use parfor loops on object
        % instances (where matlab internally will call load and save
        % methods), resulting in weird behaviour where a code runs fine
        % with for and fails with parfor.
        if strcmp(exception.identifier,'MATLAB:minrhs')
            error(['(rebuildobj) class %s does not support instancing ' ...
                'with no inputs.'],objclass);
        end
        rethrow(exception);
    end
end

for p = fieldnames(instruct)'
    pstr = p{1};
    if ~isempty(instruct(1).(pstr)) && ischar(instruct(1).(pstr)) && strcmp(instruct(1).(pstr)(1),'@')
        % function handle in char form
        for n = 1:length(instruct)
            instruct(n).(pstr) = str2func(instruct(n).(pstr));
        end
    end
    [outobj.(pstr)] = deal(instruct.(pstr));
end
