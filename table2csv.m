% write out a table (2d matrix), potentially with row and/or column labels.
%
% INPUT         DEFAULT         DESCRIPTION
% data          -               2d numeric matrix
% filename      -               full path to output file
%
% NAMED INPUT       DEFAULT         DESCRIPTION
% precision         []              if present, round to precision decimal points
% precfun           @round          function for rounding (ceil is good for p)
% collabels         {}              if present, insert a header with these
%                                       above the first row
% rowlabels         {}              if present, prepend each row with these
%
% table2csv(data,filename,varargin)
function table2csv(data,filename,varargin)

getArgs(varargin,{'precision',[],'precfun',@round,'collabels',{},...
    'rowlabels',{}});

dsz = size(data);
assert(ismatrix(data),'input data must be 2D matrix');

hascol = ~isempty(collabels);
hasrow = ~isempty(rowlabels);
% NB we assume that if you have rowlabels, you will specify the label for
% the rowlabels as the first entry in collabels
assert(~hascol || numel(collabels)==(dsz(2)+hasrow),...
    'collabels do not match size of input data')
assert(~hasrow || numel(rowlabels)==dsz(1),...
    'rowlabels do not match size of input data')

floatformat = '%f';
if ~isempty(precision)
    data = reduceprecision(data,precision,precfun);
    floatformat = ['%.' num2str(precision) 'f'];
end

datac = num2cell(data);
% swap out any NaNs to blanks for better Excel/SPSS compatibility
datac(isnan(data)) = {''};


% get ready to do some writing
fid = fopen(filename,'w');

% maybe a title row?
if hascol
    formatter = [repmat(',%s',[1 numel(collabels)]) '\n'];
    fprintf(fid,formatter(2:end),collabels{:});
end

% now data
formatter = [repmat([',' floatformat],[1 dsz(2)]) '\n'];
if hasrow
    % insert the labels
    formatter = [',%s' formatter];
    datac = [rowlabels(:) datac];
end
formatter = formatter(2:end);

% and write it out
for row = 1:dsz(1)
    fprintf(fid,formatter,datac{row,:});
end

fclose(fid);
