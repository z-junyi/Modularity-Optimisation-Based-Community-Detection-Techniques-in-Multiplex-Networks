function [V] = modularitymaximization(network, k)
% [V] = modularity(network, k)
% calculate the top eigenvectors of modularity matrix B
% network is assumed to be symmetric and sparse
% 
% INPUT:
%  - k: number of top eigenvectors to compute;
%  - network: a sparse matrix representing the network;
% OUTPUT:
%  - V: the top eigenvectors
%
% Updated by Lei Tang (L.Tang@asu.edu), 2011.

d = sum(network,2); % d is a col vector
twom = sum(d);      % the total number of degrees
opts.issym = 1;
opts.isreal = 1;

n = size(network, 1);
[V, D] = eigs(@(x)matrix_vector_multiplication(x), n, k, 'LA', opts);


function [res] = matrix_vector_multiplication(x)
% A innate function implementing the matrix / vector multiplication
  res = network*x - (d'*x)/twom * d;
end
end
