close all;
clc;
colorImage = imread('grizzlypeak.jpg');
tic;
for x=1:1000
    image=rgb2gray(colorImage);
    noise_index=image<=10;
    image(noise_index)=0;
end
t1 = toc;
tic;
for x=1:1000
    image=rgb2gray(colorImage);
    [m1,n1] = size(image);
    for i=1:m1
        for j=1:n1
            if image(i,j) <= 10
                image(i,j) = 0;
            end
        end
    end
end
t2 = toc;
fprintf('Speedup method: %g s\n', t1)
fprintf('Original method: %g s\n', t2)
fprintf('Improvement: %g times\n', t2/t1)