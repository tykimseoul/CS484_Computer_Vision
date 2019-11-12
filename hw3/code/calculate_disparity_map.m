%% HW3-d
% Generate the disparity map from two rectified images. Use NCC for the
% mathing cost function.
function d = calculate_disparity_map(img_left, img_right, window_size, max_disparity)
        
    cost_vol = zeros(size(img_left,1), size(img_left,2), max_disparity);
    size(cost_vol)
    
    for i = ceil(window_size/2):size(img_left,1)-floor(window_size/2)
        for j = ceil(window_size/2):size(img_left,2)-floor(window_size/2)
            l = img_left(i-floor(window_size/2):i+floor(window_size/2),j-floor(window_size/2):j+floor(window_size/2));
            for k = 1:max_disparity
                if (j-k)-floor(window_size/2)>0
                    r = img_right(i-floor(window_size/2):i+floor(window_size/2),(j-k)-floor(window_size/2):(j-k)+floor(window_size/2));
                    cost_vol(i,j,k) = ncc(l,r);
                end
            end
        end
    end
    
    cost_vol = smooth_planes(cost_vol);


    % winner takes all
    [min_val, d] = max(cost_vol,[],3);

end

function c = ncc(A, B)
    A = A-mean(A(:));
    B = B-mean(B(:));
    if nnz(A) == 0 || nnz(B) == 0
        c = 0;
    else
        rA = sqrt(sum(sum(A.^2,1)));
        rB = sqrt(sum(sum(B.^2,1)));
        ab = sum(sum(A.*B,1));
        c = ab/(rA*rB);
    end
end

function vol = smooth_planes(vol)
    for d = 1:size(vol,3)
        vol(:,:,d) = imgaussfilt(vol(:,:,d),1);
    end
end
