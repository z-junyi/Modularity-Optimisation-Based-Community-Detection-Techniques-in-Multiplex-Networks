% EXAMPLE 1: Multiplex
% Multiplex example with uniform interlayer dependencies between all pairs
% of layers (interlayer depencency tensor as in FIG 3b of [1] and model parameter
% choices as in FIG 5 and FIG 8 of [1] for specific values of p and mu)
directory = 'C:\Users\Lenovo\Documents\code_mmm\data\SLDS';
% directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\SLDS';

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

% 
pmmout = PMM(A,10,10);
name = '\pmmout.txt';
% save('pmm_output.mat','pmmout')
csvwrite(strcat(directory,name),pmmout);

nmi_pmm = nmi(pmmout,S(:,1));
ari_pmm = rand_index(pmmout,S(:,1),'adjusted');

directory = 'C:\Users\Lenovo\Documents\code_mmm\data\SLDS';
file1 = '/l_coms_res.txt';
fp = fopen(strcat(directory,file1),'r');
C=textscan(fp,'%d %*[^\n]');
fclose(fp);
[t = size(C)
s1 = C{1};
s2 = int32(S(:,1));
s_col = [s1,s2];

% sparse不支持单精度
s_col = double(s_col);
for i in 
nmi_genlouvain = nmi(s_col(:,1),s_col(:,2));
ari_genlouvain = rand_index(s_col(:,1),s_col(:,2),'adjusted');
nmi_pmm
nmi_genlouvain
% nmi(pmmout,s)
%S中的值为点所属社区的实际结果，每一层为一列



% % for i=1:size(A,1)
% %     a = A(i);
% %     a = cell2mat(a);
% %     fprintf(fid,'%s\n',a);
% % end
% % fp=fopen('A.txt','a');%'A.txt'为文件名；'a'为打开方式：在打开的文件末端添加数据，若文件不存在则创建。
% % fprintf(fp,'%d ',A);%fp为文件句柄，指定要写入数据的文件。注意：%d后有空格。
% % fclose(fp);%关闭文件。
% fp=fopen('S.txt','a');%'A.txt'为文件名；'a'为打开方式：在打开的文件末端添加数据，若文件不存在则创建。
% fprintf(fp,'%d ',S);%fp为文件句柄，指定要写入数据的文件。注意：%d后有空格。
% fclose(fp);%关闭文件。
% 
% % EXAMPLE 2: TEMPORAL
% % Temporal example with uniform interlayer dependencies between successive
% % layers (interlayer depencency tensor as in FIG 3a of [1] and model parameter
% % choices as in FIG 4 and FIG 9 of [1] for specific values of p and mu)
% 
% n_layers = 100;
% n_nodes = 150;
% p = 0.95; mu = 0.1;
% 
% L = TemporalDependencyMatrix(n_layers,p);
% [A,S]=DirichletDCSBMBenchmark(n_nodes,n_layers,'o',L,...
% 'UpdateSteps',1,'theta',1,'communities',5,'q',1,...
% 'exponent',-2,'kmin',3,'kmax',30,'mu',mu,'maxreject',100);
% 
% 
% % EXAMPLE 3: TEMPORAL WITH CHANGE POINTS
% % Temporal example with nonuniform interlayer dependencies between successive
% % layers (interlayer depencency tensor as in FIG 3a of [1] and model parameter
% % choices as in FIG 10 of [1] for specific values of p and mu)
% 
% n_layers = 100;
% n_nodes = 150;
% 
% p = 0.95; p_change = 0;
% p_CP = p*ones(n_layers-1,1);
% p_CP(25) = p_change; p_CP(50) = p_change; p_CP(75) = p_change;
% 
% L = diag(p_CP,1);
% 
% [A,S]=DirichletDCSBMBenchmark(n_nodes,n_layers,'o',L,...
% 'UpdateSteps',1,'theta',1,'communities',5,'q',1,...
% 'exponent',-2,'kmin',3,'kmax',30,'mu',mu,'maxreject',100);
