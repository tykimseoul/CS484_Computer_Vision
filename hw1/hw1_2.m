close all;
clc;
imshow(imread('gigi.jpg'));
I = imread('gigi.jpg')
I = I - 20;
figure;
imshow(I)