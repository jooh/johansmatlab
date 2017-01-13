% two-class area under curve for the vectors labels (containing two unique
% elements corresponding to classes) and scores (classifier output scores or
% logistic regression prediction).
%
% auc = areaundercurve(labels,scores)
function auc = areaundercurve(labels,scores)

% input check
ulab = unique(labels);
assert(numel(ulab)==2,'only supports 2 label case at present');
assert(isvector(labels),'labels must be vector');
assert(isvector(scores),'scores must be vector');
assert(numel(labels)==numel(scores),'labels and scores must be the same length');
% ensure column vectors
labels = labels(:);
scores = scores(:);

ranks = tiedrank(scores);
lab2 = labels == ulab(2);
sumlab = sum(lab2);

auc = (sum(ranks(lab2)) - sumlab * (sumlab+1) / 2) / ...
    (sum(labels == ulab(1)) * sumlab);
