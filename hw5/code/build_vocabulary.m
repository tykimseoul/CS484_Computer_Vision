% This function will extract a set of feature descriptors from the training images,
% cluster them into a visual vocabulary with k-means,
% and then return the cluster centers.

% Notes:
% - To save computation time, we might consider sampling from the set of training images.
% - Per image, we could randomly sample descriptors, or densely sample descriptors,
% or even try extracting descriptors at interest points.
% - For dense sampling, we can set a stride or step side, e.g., extract a feature every 20 pixels.
% - Recommended first feature descriptor to try: HOG.

% Function inputs: 
% - 'image_paths': a N x 1 cell array of image paths.
% - 'vocab_size' the size of the vocabulary.

% Function outputs:
% - 'vocab' should be vocab_size x descriptor length. Each row is a cluster centroid / visual word.

function vocab = build_vocabulary(image_paths, vocab_size, cs, itv)

N = size(image_paths, 1);

cell_size = [cs cs];
[pv,ph] = meshgrid(cell_size(1)+1:itv:256, cell_size(2)+1:itv:256);
points = reshape(cat(3, pv,ph),size(pv,1)*size(pv,2),2);

feats = [];

for i = 1:N
    if (mod(i,100)==0)
        disp(i);
    end
    img = im2single(imread(image_paths{i}));
    img = imresize(img, [256 256]);
    
    [feature_vector,~] = extractHOGFeatures(img,points, 'CellSize',cell_size);
    feats = cat(1,feats,feature_vector);
end
size(feats)
[~,vocab] = kmeans(feats,vocab_size,'MaxIter',20000);
size(vocab)
end