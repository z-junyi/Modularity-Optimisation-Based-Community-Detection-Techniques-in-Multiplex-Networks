function distribution = DirichletNullDistribution(layers,varargin)
% Generate a random categorical null distribution sampled from a symmetric Dirichlet distribution
%
% The null distributions for different layers are independent samples from
% the same Dirichlet distribution.
%
% Note that the general format for a null distribution is
%
%   community_assignment=function(node)
%
% where node is a row vector specifying a state node with format
% '[node_id,aspect_1,...,aspect_d]'. Here we assume that the null
% distribution is the same for all state nodes in a layer and hence the
% first index is ignored.
%
% Input:
%
%   layers: Vector of the form [l_1,...,l_d] specifying the size of each
%       aspect of the mutlilayer network
%
% Options:
%
%   theta: [default: 1] Concentration parameter for the symmetric Dirichlet
%       distribution
%
%   communities: [default: 10] Number of community labels
%
%   q: [default: 1] Probability for a community to be active in a layer
%       (i.e. have a non-zero probability to be sampled)
%
% Output:
%
%   distribution: Function that takes a state node
%       (format: [node,aspect_1,...,aspect_d] ) and returns a random
%       community assignment from 1,...,'communities'
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

parseArgs=inputParser();
addParameter(parseArgs,'theta',1);
addParameter(parseArgs,'communities',10);
addParameter(parseArgs,'q',1);
parse(parseArgs,varargin{:});
options=parseArgs.Results;

% set up null distribution
weights=zeros([options.communities,layers]);
n_layers=prod(layers);
% store probabilities for each layer sampled from dirichlet distribution
% (flattened format)
for i=1:n_layers
    weights(:,i)=cumsum(DirichletSampler(options.theta,options.q,options.communities));
end
% return index of first cummulative weight for layer that is bigger than
% rand() (seems to be the fastest way to do this in Matlab)
distribution=@(node) find(weights(:,subarray2ind(layers,node(2:end)))>rand(),1);
