% reload a (potentially nested) object instance from struct form (output of
% obj2struct). By default, the instance is created with no input arguments
% and the properties are populated according to the fieldnames of instruct
% (see rebuildobj). Regular structs are recursed into and handled
% appropriately. 
%
% If your class requires custom processing during the build (e.g., if you
% have private properties or if your class does not support instancing
% without input arguments) you can specify a buildmethod (char), which is a
% static method of your class that gets called with the struct as input in
% place of the rebuildobj function.
%
% outobj = struct2obj(instruct,[buildmethod])
function outobj = struct2obj(instruct,buildmethod)

assert(isstruct(instruct),'instruct must be struct type');
props = fieldnames(instruct)';
remind = strcmp(props,'obj2structclass');

for n = 1:numel(instruct)
    % first check for recursion potential
    for p = props
        pstr = p{1};
        if isstruct(instruct(n).(pstr))
            % recursively build objects in instruct
            instruct(n).(pstr) = struct2obj(instruct(n).(pstr));
        end
    end
end

% if there was an object at this level
if any(remind)
    assert(~isempty(instruct),...
        'no support for reloading empty object arrays at present');
    buildclass = {instruct.obj2structclass};
    assert(isequal(buildclass{1},buildclass{:}),...
        'all instruct entries must be building same object class');
    if ieNotDefined('buildmethod')
        % get rid of this
        instruct = rmfield(instruct,'obj2structclass');
        rebuild = @(x)rebuildobj(x,buildclass{1});
    else
        rebuild = [buildclass{1} '.' buildmethod];
        assert(any(strcmp(methods(buildclass{1}),buildmethod)),...
        'class %s does not have %s method',buildclass{1},buildmethod);
    end
    % now rebuild!
    outobj = feval(rebuild,instruct);
else
    % assume we got a struct
    outobj = instruct;
end
