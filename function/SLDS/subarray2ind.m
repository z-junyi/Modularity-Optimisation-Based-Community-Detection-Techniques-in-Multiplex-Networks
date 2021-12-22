function ndx = subarray2ind(shape,suba)
%SUBARRAY2IND Linear index from multiple subscripts.
%   Same as SUB2IND but takes array as input rather than multiple arguments.
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
if size(suba,2)~=dims
   error('MultilayerBenchmark:subarray2ind:DimensionMismatch','The subscript dimension does not match the array size.');
end


if any(min(suba(:,1)) < 1) || any(max(suba(:,1)) > shape(1))
    %Verify subscripts are within range
    error('MultilayerBenchmark:subarray2ind:IndexOutOfRange','Subscript out of range.');
end

ndx = double(suba(:,1));
    %Compute linear indices
    k = cumprod(shape);
    for i = 2:dims
        %%Input checking
        if (any(min(suba(:,i)) < 1)) || (any(max(suba(:,i)) > shape(i)))
            %Verify subscripts are within range
            error('MultilayerBenchmark:subarray2ind:IndexOutOfRange','Subscript out of range.');
        end
        ndx = ndx + (double(suba(:,i))-1)*k(i-1);
    end
end
