% write the entries of the struct array colstruct into columns of the outfile,
% using the delimiter del. colstruct must have the fields name, value, and
% format.
%
% INPUT         DEFAULT DESCRIPTION
% outfile       -       output file name
% colstruct     -       struct array with the fields 'name' (string defining
%                           column label),'value' (one element per row - wrap
%                           strings in cell arrays) and 'format' (e.g., '%.1f')
% del           '\t'    output delimiter
%
% 2017-05-24 J Carlin
%
% columns2file(outfile,colstruct,del)
function columns2file(outfile,colstruct,del)

if ~exist('del','var') || isempty(del)
    del= '\t';
end

nrow = arrayfun(@(x)numel(x.value),colstruct);
assert(all(nrow(1)==nrow),...
    'all colstruct.value must contain the same number of values');
nrow = nrow(1);

% write out header row
f = fopen(outfile,'w');
header = cellfun(@(x)[x del],{colstruct.name},'uniformoutput',0);
header = horzcat(header{:});
header(end) = 'n';
fprintf(f,header);

% figure out how to format the remaining rows
rowformat = cellfun(@(x)[x del],{colstruct.format},'uniformoutput',0);
rowformat = horzcat(rowformat{:});
% replace final delimiter with new row
rowformat(end-(numel(del)-1):end) = [];
rowformat = [rowformat '\n'];

% it's easier if everything is a cell array
notcell = find(~cellfun(@iscell,{colstruct.value},'uniformoutput',1));
for cind = notcell(:)'
    colstruct(cind).value = num2cell(colstruct(cind).value(:));
end

for n = 1:nrow
    data = arrayfun(@(x)x.value{n},colstruct,'uniformoutput',0);
    fprintf(f,rowformat,data{:});
end
fclose(f);
