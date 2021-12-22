n_layers=15;
n_nodes=100;
p = 0.95; mu = 0.1;

L = MultiplexDependencyMatrix(n_layers,p);
[A,S]=DirichletDCSBMBenchmark(n_nodes,n_layers,'r',L,...
'UpdateSteps',200,'theta',1,'communities',10,'q',1,...
'exponent',-2,'kmin',3,'kmax',150,'mu',mu,'maxreject',100);
[tx,ty] = size(A);
