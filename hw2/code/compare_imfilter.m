close all;
clc;
test_image = im2single(imread('../data/cat.bmp'));
filter = [-1 0 1; -2 0 2; -1 0 1];

convolution = imfilter(test_image, filter, 'conv');
correlation = imfilter(test_image, filter, 'corr');

imshow(convolution);
figure();
imshow(correlation);
