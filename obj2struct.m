% convert an object instance to struct form. Typically used for save, since
% Matlab struggles to save handle object classes with sensible performance.
% Uses recursion to find nested objects. Converts function handles to char
% since these tend not to save well.
%
% Note that if your class includes non-public properties these will likely
% be lost.
%
% outstruct = obj2struct(inobj)
function outstruct = obj2struct(inobj)

assert(isobject(inobj) || isstruct(inobj),'inobj must be object class');

props = fieldnames(inobj)';
assert(~any(strcmp(props,'obj2structclass')),...
    'object cannot contain obj2structclass property');

% support object array
for n = 1:numel(inobj)
    % support recursion into structs but do not add building tag to these
    if ~isstruct(inobj)
        outstruct(n).obj2structclass = class(inobj(n));
    end
    for p = props
        pstr = p{1};
        if isobject(inobj(n).(pstr)) || isstruct(inobj(n).(pstr))
            % recurse deeper
            outstruct(n).(pstr) = obj2struct(inobj(n).(pstr));
        elseif isa(inobj(n).(pstr),'function_handle')
            % function handles also do not save well
            fstr = func2str(inobj(n).(pstr));
            if ~strcmp(fstr(1),'@')
                % anonymous functions get converted with @ but regular
                % function handles do not. We need the @ to detect these
                % and convert them back to handles on load (str2func
                % doesn't care if the @ is there or not)
                fstr = ['@' fstr];
            end
            outstruct(n).(pstr) = fstr;
        else
            % NB, we do not support cell array recursion here. so if you've
            % packed object instances in cell arrays these will probably
            % not get handled properly
            outstruct(n).(pstr) = inobj(n).(pstr);
        end
    end
end
