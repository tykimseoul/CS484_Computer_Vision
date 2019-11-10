%% HW3-c
% Given two homography matrices for two images, generate the rectified
% image pair.
function [rectified1, rectified2] = rectify_stereo_images(img1, img2, h1, h2)
    % Hint: Note that you should care about alignment of two images.
    % In order to superpose two rectified images, you need to create
    % certain amount of margin.
        
    tform1 = projective2d(h1);
    tform2 = projective2d(h2);
    
    corners1 = [1 1; size(img1,2) 1; 1 size(img1,1); size(img1,2) size(img1,1)]
    corners2 = [1 1; size(img2,2) 1; 1 size(img2,1); size(img2,2) size(img2,1)]
    
    tcorners1 = transformPointsForward(tform1,corners1);
    tcorners2 = transformPointsForward(tform2,corners2);
    tcorners = [tcorners1; tcorners2]
    
    shift = [-min(tcorners(:,1))+1, -min(tcorners(:,2))+1]
    tcorners = tcorners+shift
    
    img1 = imwarp(img1, tform1);
    img2 = imwarp(img2, tform2);
    
    tcorners1 = tcorners1+shift;
    tcorners2 = tcorners2+shift;
    offset1 = [min(tcorners1(:,1))-1 min(tcorners1(:,2))-1]
    offset2 = [min(tcorners2(:,1))-1 min(tcorners2(:,2))-1]
    
    img1 = imtranslate(img1,offset1,'OutputView','full');
    img2 = imtranslate(img2,offset2,'OutputView','full');
    
    max_size = round([max(size(img1,1), size(img2,1)) max(size(img1,2), size(img2,2))])
    
    rectified1 = padarray(img1,[max_size(1)-size(img1,1) max_size(2)-size(img1,2)], 0,'post');
    rectified2 = padarray(img2,[max_size(1)-size(img2,1) max_size(2)-size(img2,2)], 0,'post');
end