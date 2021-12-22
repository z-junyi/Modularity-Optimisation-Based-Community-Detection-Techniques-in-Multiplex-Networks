% A =[0,1,0,1;
%     1,0,1,1;
%     0,1,0,0;
%     1,1,0,0];
% gamma = 1;
% k = full(sum(A));
% twom = sum(k);
% B = full(A - gamma*k'*k/twom);
% [S,Q] = genlouvain(B);
% Q = Q/twom
% A = cell(1,3);
% gamma = 1;
% omega =1;
% A{1} =[0,1,0,1;
%     1,0,1,1;
%     0,1,0,0;
%     1,1,0,0];
% A{2} = [0,1,0,1;1,0,1,1;0,1,0,0;1,1,0,0];
% A{3} = [0,1,0,1;1,0,0,1;0,1,0,0;1,0,0,0];
% N=length(A{1});
% T=length(A);
% B=spalloc(N*T,N*T,N*N*T+2*N*T);
% twomu=0;
% for s=1:T
%     k=sum(A{s});
%     twom=sum(k);
%     twomu=twomu+twom;
%     indx=[1:N]+(s-1)*N;
%     B(indx,indx)=A{s}-gamma*k'*k/twom;
% end
% twomu=twomu+2*omega*N*(T-1);
% B = B + omega*spdiags(ones(N*T,2),[-N,N],N*T,N*T);
% [S,Q] = genlouvain(B);
% Q = Q/twomu
% S = reshape(S,N,T);
%ind = [1 1 4 2 4 3]';
%B = accumarray(ind,3)

