function [subset_out,idx] = shuffle_data(subset_in)

% This function builds an ensemble of Exra-Trees and then ranks 
% the input variables according to their importance
%
% Input: 
% subset = observations
%
% Output: 
% subset_out = shuffled observations
% idx = indexes used in the permutation


% create a random permutation
[N,M] = size(subset_in);
idx   = randperm(N);
idx   = idx';

% initialize the output vector
subset_out = nan(size(subset_in));

% shuffle
for j = 1:N
    subset_out(j,:) = subset_in(idx(j),:);
end


% This code has been written by Stefano Galelli.


