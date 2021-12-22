function [idx] = call_glouvain_low_omega(A)
omega =0.1;
gamma = 1;
N=length(A{1});
T=length(A);
B=spalloc(N*T,N*T,(N+T)*N*T);
twomu=0;
for s=1:T
    k=sum(A{s});
    twom=sum(k);
    twomu=twomu+twom;
    indx=[1:N]+(s-1)*N;
    B(indx,indx)=A{s}-gamma*k'*k/twom;
end
twomu=twomu+T*omega*N*(T-1);
all2all = N*[(-T+1):-1,1:(T-1)];
B = B + omega*spdiags(ones(N*T,2*T-2),all2all,N*T,N*T);
[S,Q] = iterated_genlouvain(B,10000,0);
Q = Q/twomu
idx = reshape(S,N,T);

