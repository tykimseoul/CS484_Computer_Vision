low_pass = [1 1 1; 1 1 1; 1 1 1]/9;
high_pass = [1 1 1; 1 1 1; 1 1 1]/-9;
high_pass(2,2)=8/9;

test_image = im2single(imread('../data/cat.bmp'));
low = imfilter(test_image, low_pass, 'conv');
high = imfilter(test_image, high_pass, 'conv');

imshow(low);
figure();
imshow(high+0.5);
