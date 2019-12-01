% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of interest points for the input image

% 'image' can be grayscale or color, your choice.
% 'descriptor_window_image_width', in pixels.
%   This is the local feature descriptor width. It might be useful in this function to 
%   (a) suppress boundary interest points (where a feature wouldn't fit entirely in the image, anyway), or
%   (b) scale the image filters being used. 
% Or you can ignore it.

% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
% 'confidence' is an nx1 vector indicating the strength of the interest
%   point. You might use this later or not.
% 'scale' and 'orientation' are nx1 vectors indicating the scale and
%   orientation of each interest point. These are OPTIONAL. By default you
%   do not need to make scale and orientation invariant local features.
function [x, y, confidence, scale, orientation] = get_interest_points(image, descriptor_window_image_width)

% Implement the Harris corner detector (See Szeliski 4.1.1) to start with.
% You can create additional interest point detector functions (e.g. MSER)
% for extra credit.

% If you're finding spurious interest point detections near the boundaries,
% it is safe to simply suppress the gradients / corners near the edges of
% the image.

% The lecture slides and textbook are a bit vague on how to do the
% non-maximum suppression once you've thresholded the cornerness score.
% You are free to experiment. Here are some helpful functions:
%  BWLABEL and the newer BWCONNCOMP will find connected components in 
% thresholded binary image. You could, for instance, take the maximum value
% within each component.
%  COLFILT can be used to run a max() operator on each sliding window. You
% could use this to ensure that every interest point is at a local maximum
% of cornerness.

% close all
alpha = 0.05;
threshold = -0.01;

%apply double derivative to the filter first then apply to the image, to remove the effects of noise
gauss_filter = fspecial('Gaussian', 11, 0.5);

Dx = imderivative(gauss_filter, [1 0]);
Dy = imderivative(gauss_filter, [0 1]);
Dxy = imderivative(gauss_filter, [1 1]);

Dx2 = Dx.*Dx;
Dy2 = Dy.*Dy;

Ix2 = imfilter(image, Dx2, 'symmetric', 'same', 'conv');
Iy2 = imfilter(image, Dy2, 'symmetric', 'same', 'conv');
Ixy = imfilter(image, Dxy, 'symmetric', 'same', 'conv');

% Ix = imfilter(image, Dx, 'symmetric', 'same', 'conv');
% Iy = imfilter(image, Dy, 'symmetric', 'same', 'conv');
% Ixy = imfilter(image, Dxy, 'symmetric', 'same', 'conv');
% Ix2 = Ix.*Ix;
% Iy2 = Iy.*Iy;

Gx2 = imfilter(Ix2, gauss_filter, 'symmetric', 'same', 'conv');
Gy2 = imfilter(Iy2, gauss_filter, 'symmetric', 'same', 'conv');
Gxy = imfilter(Ixy, gauss_filter, 'symmetric', 'same', 'conv');

C = Gx2.*Gy2-(Gxy.*Gxy)-alpha*((Gx2+Gy2).*(Gx2+Gy2));

[y,x] = find(C<threshold);


% After computing interest points, here's roughly how many we return
% For each of the three image pairs
% - Notre Dame: ~1300 and ~1700
% - Mount Rushmore: ~3500 and ~4500
% - Episcopal Gaudi: ~1000 and ~9000

end

