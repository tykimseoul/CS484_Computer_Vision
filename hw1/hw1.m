close all;
clc;
image = imread('grizzlypeakg.png');
tic;
for x=1:1000
    noise_index=image<=10;
    image(noise_index)=0;
end
t1 = toc;
image = imread('grizzlypeakg.png');
tic;
for x=1:1000
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
