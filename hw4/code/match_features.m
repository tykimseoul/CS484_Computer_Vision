% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Please implement the "nearest neighbor distance ratio test", 
% Equation 4.18 in Section 4.1.3 of Szeliski. 
% For extra credit you can implement spatial verification of matches.

%
% Please assign a confidence, else the evaluation function will not work.
%

% This function does not need to be symmetric (e.g., it can produce
% different numbers of matches depending on the order of the arguments).

% Input:
% 'features1' and 'features2' are the n x feature dimensionality matrices.
%
% Output:
% 'matches' is a k x 2 matrix, where k is the number of matches. The first
%   column is an index in features1, the second column is an index in features2. 
%
% 'confidences' is a k x 1 matrix with a real valued confidence for every match.

function [matches, confidences] = match_features(features1, features2)

num_features = min(size(features1, 1), size(features2,1));
pd = pairwise_distance(features1, features2);
[sortdist, sortindex] = sort(pd,2,'ascend');
nndr = sortdist(:,1)./sortdist(:,2);

matches = zeros(num_features, 2);
matches(:,1) = 1:size(features1);
matches(:,2) = sortindex(:,1);

good_indices = find(nndr<0.8);

matches = [matches(good_indices,1), matches(good_indices,2)]; 

confidences = 1./nndr(good_indices);

[confidences, ind] = sort(confidences, 'descend');
% get top 100 indices
ind = ind(1:min(100,size(ind)));
confidences = confidences(ind,:);
matches = matches(ind,:);

% Remember that the NNDR test will return a number close to 1 for 
% feature points with similar distances.
% Think about how confidence relates to NNDR.
% 1/NNDR
end

function pd = pairwise_distance(X,Y)
    pd = zeros(size(X,1),size(Y,1));
    for m=1:size(X,1)
        for n=1:size(Y,1)
            %sum of squares of elements
            pd(m,n) = norm(X(m,:)-Y(n,:));
        end
    end
end



