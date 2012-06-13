% Input the path to an image or an image variable, and optionally a path where
% you want the scrambled image. If no out is supplied, the return is 
%the image, rather than its path.
% Use: ImageorPath = im_scramble(imgin, [imgout])
% 11/5/2009 J Carlin, after Nicolaas Prins:
% http://visionscience.com/pipermail/visionlist/2007/002181.html

function ImScrambled = im_scramble(imgin, imgout)

if ischar(imgin)
	imgin = imread(imgin);
end

if isa(imgin,'uint8')
    wasuint=1;
    inmax = max(imgin(:));
    inmin = min(imgin(:));
    imgin = double(imgin);
else
    wasuint=0;
end

imgin = mat2gray(imgin);

imsize = size(imgin);
RandomPhase = angle(fft2(rand(imsize(1), imsize(2))));

% Detect colour
if ndims(imgin)<3
    dims = 1;
else
    dims = imsize(3);
end

ImFourier = NaN(imsize);
Amp = NaN(imsize);
Phase = NaN(imsize);
ImScrambled = NaN(imsize);

for layer = 1:dims
    %Fast-Fourier transform
	ImFourier(:,:,layer) = fft2(imgin(:,:,layer));       
    %amplitude spectrum
	Amp(:,:,layer) = abs(ImFourier(:,:,layer));       
    %phase spectrum
	Phase(:,:,layer) = angle(ImFourier(:,:,layer));   
    %add random phase to original phase
	Phase(:,:,layer) = Phase(:,:,layer)+ RandomPhase;
    %combine Amp and Phase then perform inverse Fourier
	ImScrambled(:,:,layer) = ifft2(Amp(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   
end

ImScrambled = real(ImScrambled); %get rid of imaginary part in image (due to rounding error)

if nargin > 1
	imwrite(ImScrambled,imgout,'PNG');
	ImScrambled = imgout;
elseif wasuint
    % Return to uint8, preserving intensity of input
    ImScrambled = inmin + gray2ind(ImScrambled,double(inmax-inmin));
end
