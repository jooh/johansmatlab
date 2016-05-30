% convenience function for exporting the relevant fields from an ANOVAN
% cell array output (second return) to CSV.
%
% anovan_exportcsv(filename,anovatable)
function anovan_exportcsv(filename,data)

if isempty(data)
    return;
end

datamat = data(2:end,2:7);
datamat(cellfun(@isempty,datamat)) = {NaN};
datamat = cell2mat(datamat);
table2csv(datamat,filename,'collabels',data(1,1:7),'rowlabels',data(2:end,1));
