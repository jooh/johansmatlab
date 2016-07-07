% write out a table (2d matrix), potentially with row and/or column labels.
%
% INPUT         DEFAULT         DESCRIPTION
% data          -               2d numeric matrix
% filename      -               full path to output file
%
% NAMED INPUT       DEFAULT         DESCRIPTION
% precision         []              if present, round to precision decimal points
% precfun           @round          function for rounding (ceil is good for p)
% collabels         {}              [n, size(data,2)+size(rowlabels,2)] cell
%                                       array. If present, insert a header with
%                                       these above the first row. Multiple rows
%                                       are supported.
% rowlabels         {}              [size(data,1), n] cell array. If present,
%                                       prepend each row with these entries.
%                                       Multiple columns are supported.
%
% table2csv(data,filename,varargin)
function table2csv(data,filename,varargin)

getArgs(varargin,{'precision',[],'precfun',@round,'collabels',{},...
    'rowlabels',{}});

dsz = size(data);
assert(ismatrix(data),'input data must be 2D matrix');

hascol = ~isempty(collabels);
szcollab = size(collabels);
szrowlab = size(rowlabels);
hasrow = ~isempty(rowlabels);
% NB we assume that if you have rowlabels, you will specify the label for
% the rowlabels as the first entry in collabels
assert(~hascol || szcollab(2)==(dsz(2)+hasrow*szrowlab(2)),...
    'collabels do not match size of input data')
assert(~hasrow || szrowlab(1)==dsz(1),...
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
    formatter = [repmat(',%s',[1 szcollab(2)]) '\n'];
    for r = 1:szcollab(1)
        fprintf(fid,formatter(2:end),collabels{r,:});
    end
end

% now data
formatter = [repmat([',' floatformat],[1 dsz(2)]) '\n'];
if hasrow
    formatter = [repmat(',%s',[1 szrowlab(2)]) formatter];
    % insert the labels
    datac = [rowlabels datac];
end
formatter = formatter(2:end);

% and write it out
for row = 1:dsz(1)
    fprintf(fid,formatter,datac{row,:});
end

fclose(fid);
