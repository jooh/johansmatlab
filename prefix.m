% x = prefix(x,p)
function x = prefix(x,p)

switch class(x)
    case 'cell'
        x = cellfun(@(thisx)[p thisx],x,'uniformoutput',0);
    case 'char'
        error('not yet implemented')
    otherwise
        error('prefix is not supported for format: %s',class(x));
end
