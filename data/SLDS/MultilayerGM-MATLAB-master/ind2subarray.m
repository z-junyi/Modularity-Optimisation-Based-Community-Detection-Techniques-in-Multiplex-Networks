function [sub] = ind2subarray(shape,ind)
%IND2SUBARRAY Subscripts from linear index. Same as IND2SUB but
%   returns results as an array instead of separate output arguments.
%
% Version: 2.0.0
% Date: Thu 11 Jul 2019 15:24:15 CEST
% Author: Lucas Jeub
% Email: lucasjeub@gmail.com
%
%
% References:
%
%       [1] Generative benchmark models for mesoscale structure in multilayer
%       networks, M. Bazzi, L. G. S. Jeub, A. Arenas, S. D. Howison, M. A.
%       Porter. arXiv1:608.06196.
%
% Citation:
%
%       If you use this code, please cite as
%       Lucas G. S. Jeub and Marya Bazzi
%       "A generative model for mesoscale structure in multilayer networks
%       implemented in MATLAB," https://github.com/MultilayerGM/MultilayerGM-MATLAB (2016-2019).

shape = double(shape);
dims = length(shape);
sub=zeros(length(ind),length(shape));

k = cumprod(shape);
if ind>k(end)
    error('MultilayerBenchmark:ind2subarray:IndexOutOfRange','Index out of range.');
end
for i = dims:-1:2,
    subi = rem(ind-1, k(i-1)) + 1;
    subj = (ind - subi)/k(i-1) + 1;
    sub(:,i) = double(subj);
    ind = subi;
end
sub(:,1)=ind;

end
