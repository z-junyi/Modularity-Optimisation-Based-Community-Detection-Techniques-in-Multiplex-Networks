function [B,twom] = multiord(A,gamma,omega)

if nargin<2
gamma=1;
end

if nargin<3
omega=1;
end

N = size(A,1);
T = size(A,3);

if length(gamma)==1
gamma=repmat(gamma,T,1);
end

B=spalloc(N*T,N*T,N*N*T+2*N*T);
twom=0;
for s=1:T
    kout=sum(A(:,:,s),1);
    kin=sum(A(:,:,s),2);
    mm=sum(kout);
	twom=twom+mm;
    indx=[1:N]+(s-1)*N;
    B(indx,indx)=(A(:,:,s)+A(:,:,s).')/2-gamma(s)/2.*((kin*kout+kout'*kin')/mm);
end
B = B + omega*spdiags(ones(N*T,2),[-N,N],N*T,N*T);
twom=twom+2*N*(T-1)*omega;

