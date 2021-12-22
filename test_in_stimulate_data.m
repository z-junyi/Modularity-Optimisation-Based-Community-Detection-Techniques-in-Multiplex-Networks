clear;close all;clc;
addpath('data');
addpath('eval');
addpath('function');
addpath('function/SLDS');

addpath('PMM');
addpath('m-Spec');
addpath('GenLouvain');

% 数据路径
directory = './data/SLDS';
file1 = '/l_coms_res.txt';

n_layers=15;
n_nodes=100;
p = 0.95; mu = 0.1;

L = MultiplexDependencyMatrix(n_layers,p);
[A,S]=DirichletDCSBMBenchmark(n_nodes,n_layers,'r',L,...
'UpdateSteps',200,'theta',1,'communities',10,'q',1,...
'exponent',-2,'kmin',3,'kmax',150,'mu',mu,'maxreject',100);
[tx,ty] = size(A);
for k = 1:tx
    Ak = A{k};
    [i,j,v] = find(Ak);
    %x=[1 2 3 4];%要存入的数据矩阵。
    edge = [i,j];
    name = strcat(directory,'\trans',num2str(k),'.txt');  
    csvwrite(name,edge);
end
read_mnet_and_exec('C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\SLDS',1,100,'/l_coms');

% PMM方法
pmmout = PMM(A,10,10);
name = '/pmmout.txt';
% save('pmm_output.mat','pmmout')
csvwrite(strcat(directory,name),pmmout);

nmi_pmm = nmi(pmmout,S(:,1));
ari_pmm = rand_index(pmmout,S(:,1),'adjusted');
