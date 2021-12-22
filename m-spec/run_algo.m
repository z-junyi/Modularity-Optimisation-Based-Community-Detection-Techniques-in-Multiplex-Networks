clear;close all;clc;
% % reading network
% load synthetic.mat
% 
% addpath(genpath('C:\Users\Lenovo\Documents\code_mmm\data\SLDS')); % data root
addpath('C:\Users\Lenovo\Documents\code_mmm\data\SLDS\MultilayerGM-MATLAB-master')
addpath('C:\Users\Lenovo\Documents\code_mmm\data\SLDS');
% directory = 'C:\Users\Lenovo\Documents\code_mmm\data\SLDS';
% directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\SLDS';

n_layers=15;
n_nodes=100;
p = 0.95; mu = 0.1;

L = MultiplexDependencyMatrix(n_layers,p);
[A,S]=DirichletDCSBMBenchmark(n_nodes,n_layers,'r',L,...
'UpdateSteps',200,'theta',1,'communities',10,'q',1,...
'exponent',-2,'kmin',3,'kmax',150,'mu',mu,'maxreject',100);
tx = size(A,1);
for k = 1:tx
Ak(:,:,k) = full(A{k});
end

% % read number of communities
[Q,X] = mSpec(Ak);
% 
% outputs
outfile = fopen("synthetic.txt", "w");
for i=1:length(X)
    fprintf(outfile, "%d\n", X(i));
end
fclose(outfile);
nmi_spec = nmi(X,S(:,1));
ari_spec = rand_index(X,S(:,1),'adjusted');
nmi_spec;
ari_spec;

%true data example
directory = 'C:\Users\Lenovo\Documents\code_mmm\data\TailorShop';
file = '\Dataset\Kapferer-Tailor-Shop_multiplex.edges';
file1 = '\Dataset\Kapferer-Tailor-Shop_nodes.txt';
a1 = transform_datanet(directory,file);
n = getn(directory,file1);
% n = 520;
a1 = transmat(a1,n);
tx = size(A,1);
for k = 1:tx
network(:,:,k) = full(A{k});
end
% pmmout = PMM(network,10,10);
[Q1,X1] = mSpec(network);
name = '\spec_out.txt';
% save('pmm_output.mat','pmmout')
csvwrite(strcat(directory,name),X1);

function[n] = getn(directory,file1)
fp = fopen(strcat(directory,file1),'r');
% fileID=fopen('Data.txt');
A=textscan(fp,'%d %*[^\n]','HeaderLines',1);
a1=cell2mat(A);
[n,m] = size(a1);
% [c,d] = size(a1);
% line=floor(c/14);
fclose(fp);
end

function[matrix] = transmat(a1,n)
[c,d] = size(a1);
line=floor(c/4);
a2 = reshape(a1,[4,line]);
M = a2';
t = arrayfun(@(x) M(M(:,1) == x, :), unique(M(:,1)), 'uniformoutput', false);
[tx,ty] = size(t);
for j = 1:tx
%   files = strcat(directory,'\trans',num2str(j),'.txt');  
  tj = t{j}(:,2:3);
  weight = t{j}(:,4);
%   [x,y] = size(tj);
% [tj,weight] = transform_datanet();
% [x,y] = size(tj);
  adjMatrix = full(sparse(tj(:,1),tj(:,2),weight,n,n)); %此时得到的邻接矩阵为上三角矩阵
  adjMatrix = adjMatrix + adjMatrix';
%   mat(:,:,j) = adjMatrix;
%   matrix = cell(tx,1);
%   matrix{j} = mat(:,:,j);
%   fp2 = fopen(files,'w');
  %fp2 = fopen('C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\input_data\arxiv\arxiv_layer1.txt','w');
% for i ans= 1:x        % 建立for循环嵌套
%     fprintf(fp2,'%d ',tj(i,:));
%     fprintf(fp2,'\n');
% end
% fclose(fp2);
end
matrix = cell(1,tx);
for i = 1:tx
   matrix{i} = adjMatrix;
end
% v = [1 1 1 1 1];
%matrix = mat2cell(mat,:,:,ones(1,tx))
% [tj,weight] = transform_datanet();
% [x,y] = size(tj);
% adjMatrix = full(sparse(tj(:,1),tj(:,2),weight,x,x)); %此时得到的邻接矩阵为上三角矩阵
% adjMatrix = adjMatrix + adjMatrix'
end

function [a1] = transform_datanet(directory,file)
% directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\aucs';
% file = '\Dataset\CS-Aarhus_multiplex.edges';
fp = fopen(strcat(directory,file),'r');
% fileID=fopen('Data.txt');
A=textscan(fp,'%f');
fclose(fp);
a1=cell2mat(A);

%a1 = a1';
end



