% Quick, loopy convenience function for converting all the data fields
% (logical or numeric) of a struct or object instance to
% gpuArray. Non-numeric fields get ignored but we attempt recursion for any
% field that can handle a fieldnames call.
%
% m = structdata2gpu(m)
function m = structdata2gpu(m)

n = numel(m);

if n==1
    % this is to avoid hitting operator overloading problems
    numerictest = @(x,s)isnumeric(x.(s)) || islogical(x.(s));
else
    numerictest = @(x,s)isnumeric(x(1).(s)) || islogical(x(1).(s));
end

for fn = fieldnames(m)'
    fnstr = fn{1};
    % type of data that go to gpu
    if numerictest(m,fnstr)
        fieldclass = cellfun(@(c)class(c),{m.(fnstr)},'uniformoutput',...
            false);
        assert(numel(fieldclass)==1 || isequal(fieldclass{:}),...
            'mismatched classes for %s',fnstr);
        if n==1
            % more special case dribbling to avoid operator overloading
            m.(fnstr) = gpuArray(m.(fnstr));
        else
            for ind = 1:n
                m(ind).(fnstr) = gpuArray(m(ind).(fnstr));
            end
        end
    end
    try fieldnames(m.(fnstr));
        m.(fnstr) = structdata2gpu(m.(fnstr));
    catch
        % meh
    end
end
