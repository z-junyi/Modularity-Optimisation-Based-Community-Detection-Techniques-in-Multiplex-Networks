function [idx] = PMM(network,  k, ell, maxKmeans)
% [idx] = PMM(network, k, ell, maxKmeans)
% A function to implement principal modularity maximization
% 
% INPUT: 
%  - network: a cell array to represent multi-dimensional networks;
%             each cell is a sparse network of one dimension;
%  - k: number of communities;
%  - ell: number of structural features to extract from each dimension
%  - maxKmeans (optional): the  of kmeans algorithms to repeat;
%                          default value is 1;
%
% OUTPUT:
%  - idx: the community assignent of each node
% 
% Updated by Lei Tang (L.Tang@asu.edu) in March 2011.

if nargin < 4
    maxKmeans = 1;
end

nview = length(network);
F = [];
    
for vIndex = 1:nview
    % use spectral clustering or modularity maximization to compute the top 
    % eigenvectors
    %disp(sprintf('compute eigenvectors for the %d-th dimension', vIndex));

    features = modularitymaximization(network{vIndex}, ell);
    % features = spectralclustering(network{vIndex}, ell);
   
    
    % concatenae all the latent features
    F = [F features];
    
end
    
%disp('perform svd')
[U, D, V]  = svd(F, 0);
    
%disp('perform k-means')
idx = kmeans(U(:, 1:k-1), k, 'EmptyAction', 'singleton', 'Replicates', maxKmeans);


