% 结果存在input_data文件夹下的各数据文件夹下的l_coms.txt中，另外参数手动调了一下，原输出结果是gl_coms.txt，可以对比参考，下面是运行代码
clear;close all;clc;
addpath('data');
addpath('eval');
addpath('function');

addpath('PMM');
addpath('m-Spec');
addpath('GenLouvain');

% 数据路径
directory = './data/TailorShop';
file_edges = '/Dataset/Kapferer-Tailor-Shop_multiplex.edges';
file_nodes = '/Dataset/Kapferer-Tailor-Shop_nodes.txt';
name = '/pmm_out.txt'; % 输出划分结果文件名
% 获取数据。以及nodes数
a1 = transform_datanet(directory,file_edges);
n = getn(directory,file_nodes);
% 1 arxiv genlouvain未完成,pmm太大了运行不来;
% 2 london_transport未完成（对矩阵的索引必须为正数）

% true data example
% cell格式的邻接矩阵以及层数
A = transmat(a1,n);
tx = size(A,2);

% 矩阵格式的邻接矩阵
network = [];
for k = 1:tx
    network(:,:,k) = full(A{k});
end

% 获得社区划分
pmmout = PMM(A,3,3);
%[Q1,X1] = mSpec(network);

% 求模块度
tx = size(A,2);
for k = 1:tx
    % 每层求模块度
    Q(:,k) = QFModul(pmmout,A{k});
end
% 求模块度均值
Q_multi = [];
Q_multi = [Q_multi,mean(Q)];

% 输出out.txt结果
csvwrite(strcat(directory,name),X1);

