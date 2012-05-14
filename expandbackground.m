% Expand the background of a matrix, e.g. an image. Takes the
% value in the top left corner as the basis for expansion by default
% use: outimage = expandbackground(inimage, [desiredheight desiredwidth], bgcolour)
% WARNING: Not terribly robust when using smaller matrices (size <5).
function outimage = expandbackground(inimage, heightandwidth, bgcolour)

convertback = 0;
% This function contains operations that are incompatible
% with uint8
if strcmp(class(inimage),'uint8')
    inimage = mat2gray(inimage);
    convertback = 1;
end

dh = heightandwidth(1);
dw = heightandwidth(2);

if nargin < 3
	bgcolour = inimage(1,1);
end

[h w d] = size(inimage);

org_haw = size(inimage);

% Background
outimage = ones(dh,dw,d) * bgcolour;
iseven = @ (x) logical(~mod(x,2));

% Right, let's operate by dimension
for d = 1:length(heightandwidth)
	in_d = org_haw(d);
	out_d = heightandwidth(d);

	% No need to try any fancy stuff here
	if in_d >= out_d
		d_s(d) = 1;
		d_e(d) = in_d;
		continue
	end
	ineven = iseven(in_d);
	inmid = in_d / 2;
	outeven = iseven(heightandwidth(d));
	outmid = out_d / 2;
	% There is some cleverness involved here to account for cases where
	% both in and out are even
	% both in and out are odd
	% either combination
	d_s(d) = (~ineven && ~outeven) + floor(outmid) - floor(inmid)+ineven;
	d_e(d) = (~ineven && ~outeven) + floor(outmid) + floor(inmid);
end

if length(heightandwidth) == 2
	outimage(d_s(1):d_e(1),d_s(2):d_e(2)) = inimage;
elseif length(heightandwidth) == 3
	outimage(d_s(1):d_e(1),d_s(2):d_e(2),d_s(3):d_e(3)) = inimage;
else
	error('Currently only support for up to 3 dimensions')
end

if convertback
    % Back to uint8
    outimage = im2uint8(oi);
end
