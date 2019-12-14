%This feature representation is described in the handout, lecture
%materials, and Szeliski chapter 14.

function image_feats = get_bags_of_words(image_paths, cs, itv)
% image_paths is an N x 1 cell array of strings where each string is an
% image path on the file system.

% This function assumes that 'vocab.mat' exists and contains an N x feature vector length
% matrix 'vocab' where each row is a kmeans centroid or visual word. This
% matrix is saved to disk rather than passed in a parameter to avoid
% recomputing the vocabulary every run.

% image_feats is an N x d matrix, where d is the dimensionality of the
% feature representation. In this case, d will equal the number of clusters
% or equivalently the number of entries in each image's histogram
% ('vocab_size') below.

% You will want to construct feature descriptors here in the same way you
% did in build_vocabulary.m (except for possibly changing the sampling
% rate) and then assign each local feature to its nearest cluster center
% and build a histogram indicating how many times each cluster was used.
% Don't forget to normalize the histogram, or else a larger image with more
% feature descriptors will look very different from a smaller version of the same
% image.

load('vocab.mat')
vocab_size = size(vocab, 1);
image_count = size(image_paths, 1);
image_feats = zeros(image_count, vocab_size);

forest = KDTreeSearcher(vocab);
cell_size = [cs cs];
[pv,ph] = meshgrid(cell_size(1)+1:itv:256, cell_size(2)+1:itv:256);
points = reshape(cat(3, pv,ph),size(pv,1)*size(pv,2),2);

for i=1:image_count
    if (mod(i,500)==0)
        disp(i);
    end
    img = im2single(imread(image_paths{i}));
    img = imresize(img, [256 256]);

    [features, ~] = extractHOGFeatures(img,points, 'CellSize', cell_size);

    [idx , ~] = knnsearch(forest , double(features), 'K', 1);
    image_feats(i,:) = histc(idx, 1:1:vocab_size)';
end

end




