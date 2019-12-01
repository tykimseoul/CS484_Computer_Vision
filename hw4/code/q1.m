close all;
clc
fname = "Chase";

I1 = imread(sprintf('../questions/%s1.jpg',fname));
I2 = imread(sprintf('../questions/%s2.jpg',fname));

fig = figure;

C1 = corner(rgb2gray(I1));
subplot(1,2,1);
imshow(I1)
hold on
plot(C1(:,1),C1(:,2),'gx');

C2 = corner(rgb2gray(I2));
subplot(1,2,2);
imshow(I2)
hold on
plot(C2(:,1),C2(:,2),'gx');