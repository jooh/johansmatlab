% Compute euclidean distance from origin for entries in rows (dimensions in
% columns). Trivial, but I keep mucking up the formula...
% d = distorigin(data)
function d = distorigin(data)

d = sqrt(sum(data.^2,2));
