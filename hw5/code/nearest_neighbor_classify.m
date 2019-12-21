%This function will predict the category for every test image by finding
%the training image with most similar features. Instead of 1 nearest
%neighbor, you can vote based on k nearest neighbors which will increase
%performance (although you need to pick a reasonable value for k).

function predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats, k)
% image_feats is an N x d matrix, where d is the dimensionality of the
%  feature representation.
% train_labels is an N x 1 cell array, where each entry is a string
%  indicating the ground truth category for each training image.
% test_image_feats is an M x d matrix, where d is the dimensionality of the
%  feature representation. You can assume M = N unless you've modified the
%  starter code.
% predicted_categories is an M x 1 cell array, where each entry is a string
%  indicating the predicted category for each test image.

% Useful functions:
%  matching_indices = strcmp(string, cell_array_of_strings)
%    This can tell you which indices in train_labels match a particular
%    category. Not necessary for simple one nearest neighbor classifier.
 
%   [Y,I] = MIN(X) if you're only doing 1 nearest neighbor, or
%   [Y,I] = SORT(X) if you're going to be reasoning about many nearest
%   neighbors 

% train_image_feats = [4 8 4; 5 2 4; 1 3 3; 2 5 1];
% test_image_feats = [3 5 3; 5 2 6; 3 1 6; 2 7 1];
% train_labels = {'Kitchen', 'Store', 'Bedroom', 'Store'}';
% train_image_feats'
% test_image_feats

N = size(test_image_feats,1);
pd = pdist2(train_image_feats, test_image_feats);
[~, sortindex] = sort(pd,1,'ascend');

labels = categorical(unique(train_labels));
predicted_categories = cell(N,1);

for i=1:N
    top_sort = sortindex(1:k,i);
    top_labels = categorical(train_labels(top_sort));
    [label_votes,elected] = histcounts(top_labels, labels);
    [~,mx_idx] = max(label_votes, [], 2);
    predicted_categories(i,:) = elected(mx_idx);
end

end