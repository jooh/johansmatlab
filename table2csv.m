% write out data in tabular CSV format, potentially with row and/or column
% labels. Support for up to 3D data (third dimension is concatenated along
% rows or columns).
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
% zstackdim         'row'           options: 'row' or 'col'. dimension
%                                       along which to stack the third data
%                                       dim.
% zlabels           {}              [n,size(data,3)] cell array. If
%                                       present, use to label rows/columns
%                                       appropriately while stacking.
%
%
% table2csv(data,filename,varargin)
function table2csv(data,filename,varargin)

getArgs(varargin,{'precision',[],'precfun',@round,'collabels',{},...
    'rowlabels',{},'zlabels',{},'zstackdim','row'});

dsz = size(data);

% input check
hascol = ~isempty(collabels);
hasrow = ~isempty(rowlabels);
hasz = ~isempty(zlabels);
szcollab = size(collabels);
szrowlab = size(rowlabels);
szzlab = size(zlabels);
% NB we assume that if you have rowlabels, you will specify the label for
% the rowlabels as the first entry in collabels
assert(~hascol || szcollab(2)==(dsz(2)+hasrow*szrowlab(2)),...
    'collabels do not match size of input data')
assert(~hasrow || szrowlab(1)==dsz(1),...
    'rowlabels do not match size of input data')
assert(~hasz || szzlab(2)==dsz(3),...
    'zlabels do not match size of input data')

nd = ndims(data);
switch nd
    case 2
        % no problem, just need to check that you're being sensible
        % (NB we will have problems with automatic squeezing of the
        % singleton dims here, but in general I can't imagine a case where
        % you'd want a single entry zlabel to be used)
        assert(isempty(zlabels),'specified zlabels, but data is not 3D')
    case 3
        % need to stack and handle labels
        % TODO: need to support multi-row row/collabels AND z labels
        switch lower(zstackdim)
            case 'row'
                data = permute(reshape(permute(data,[2 1 3]),...
                    [dsz(2),dsz(1)*dsz(3)]),[2 1 3]);
                % so we want to repmat up the existing rowlabels (nb if
                % they're empty this does nothing)
                rowlabels = repmat(rowlabels,[dsz(3),1]);
                % we need to insert rowlabels maybe
                if hasz
                    % now we need szzlab(1) new columns 
                    rowlabels = [repmat({''},...
                        [size(rowlabels,1),szzlab(1)]) rowlabels];
                    % and in every n row, insert the zlabel. 
                    for z = 1:szzlab(1)
                        [rowlabels{1:szrowlab(1):size(rowlabels,1),...
                            z}] = deal(zlabels{z,:});
                    end
                    % and probably need to pad the collabels as well
                    if hascol
                        collabels = [repmat({''},[1 szzlab(1)]),collabels];
                    end
                end
            case 'col'
                data = reshape(data,[dsz(1),dsz(2)*dsz(3)]);
                if hasrow
                    % need to make sure we don't replicate the rowlabels
                    collabels = [collabels(:,1:szrowlab(2)) ...
                        repmat(collabels(:,szrowlab(2)+1:end),[1,dsz(3)])];
                else
                    % easy
                    collabels = repmat(collabels,[1,dsz(3)]);
                end
                if hasz
                    collabels = [repmat({''},...
                        [szzlab(1),size(collabels,2)]); collabels];
                    % too much logic here but hey ho
                    if hasrow
                        colind = szrowlab(2)+1:szcollab(2)-szrowlab(2):size(collabels,2);
                    else
                        % easy
                        colind = 1:szcollab(2):size(collabels,2);
                    end
                    for z = 1:szzlab(1)
                        % here we need to offset by number of row labels
                        [collabels{z,colind}] = deal(zlabels{z,:});
                    end
                end
            otherwise
                error('unknown zstackdim: %s',zstackdim)
        end
        % update
        szrowlab = size(rowlabels);
        szcollab = size(collabels);
        dsz = size(data);
    otherwise
        error('max 3d data supported, got %dd',nd)
end

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

% maybe header rows?
if hascol
    formatter = [repmat(',%s',[1 szcollab(2)]) '\n'];
    for r = 1:szcollab(1)
        fprintf(fid,formatter(2:end),collabels{r,:});
    end
end

% now data rows with labels
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
