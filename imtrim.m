% Trim an image matrix by an rgb value.
% rgb defaults to the corner pixel im(1,1,[1]). Also returns the [rowmin
% rowmax colmin colmax] that would produce similar cropping of another
% image (e.g. alpha layer)
% [im axlims] = imtrim(im,[rgb])
function [im axlims] = imtrim(im,rgb)

sz = size(im);
ndim = length(sz);
if ndim==2
    % Detect black/white intensity images
    im = repmat(im,[1 1 3]);
    sz = size(im);
end

if ieNotDefined('rgb')
    rgb = squeeze(im(1,1,1:sz(3)));
elseif length(rgb)==1
    rgb = repmat(rgb,[1 1 3]);
end

% Make a background colour matrix
bgmat = repmat(reshape(rgb,[1 1 sz(3)]),[sz(1) sz(2) 1]);

notbg = all(im ~= bgmat,3);

rows = find(sum(notbg,2) > 1);
columns = find(sum(notbg,1) > 1);
axlims = [rows(1) rows(end) columns(1) columns(end)];
im = im(axlims(1):axlims(2),axlims(3):axlims(4),:);

if ndim==2
    % Back to intensity
    im = im(:,:,1);
end
