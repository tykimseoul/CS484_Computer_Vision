function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% when operating in convolution mode. See 'help imfilter'. 
% While "correlation" and "convolution" are both called filtering, 
% there is a difference. From 'help filter2':
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should meet the requirements laid out on the project webpage.

% Boundary handling can be tricky as the filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% we look at 'help imfilter', we see that there are several options to deal 
% with boundaries. 
% Please recreate the default behavior of imfilter:
% to pad the input image with zeros, and return a filtered image which matches 
% the input image resolution. 
% A better approach is to mirror or reflect the image content in the padding.

% Uncomment to call imfilter to see the desired behavior.
% default = imfilter(image, filter, 'conv');
% imwrite(default, 'default.png')

%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%
flipped_kernel = flip(flip(filter, 1), 2);
% image_size=size(image)
pad_size = floor(size(filter)/2);
padded_image = padarray(image, [pad_size, 0]);
% padded_size=size(padded_image)
filtered_image = zeros(size(padded_image));
for d=1:size(padded_image, 3)
    for i=pad_size(1)+1:size(image, 1)+pad_size(1)
        for j=pad_size(2)+1:size(image, 2)+pad_size(2)
            target = padded_image(i-pad_size(1):i+pad_size(1), j-pad_size(2):j+pad_size(2), d);
            filtered_image(i, j, d) = sum(sum(target.*flipped_kernel));
        end
    end
end
output=filtered_image(pad_size(1)+1:size(image,1)+pad_size(1), pad_size(2)+1:size(image,2)+pad_size(2), :);
% output_size=size(output)
imwrite(output, 'output.png')
% diff=default-output;
% diff(diff~=0)=1;
% imwrite(diff, 'diff.png')
