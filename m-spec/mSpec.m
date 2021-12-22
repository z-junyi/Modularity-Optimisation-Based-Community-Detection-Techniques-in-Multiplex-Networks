function [Q,X] = mSpec(A)
% setting parameters
N = size(A,1); % number of vertices
T = size(A,3); % number of layers

[B,mm] = multiord(A); % init modularity matrix
[V,D] = eigs_max(B); % max eigenvalue & eigenvector
Q = ones(1,length(V)) * B * (ones(1,length(V)).') / (mm * length(V)); % initialize Q
community_num = 1; % initialize community num
X = ones(1,N); % initialize community classification

i = 1;

while (i <= community_num)
    % compute the Modularity matrices and eigenvalues & eigenvectors
    [delta_Q,F] = compute_delta_Q(V,B,mm);
    if delta_Q > 0  
        community_num = community_num + 1;
        Q = Q + delta_Q;
        
        % refresh community
        E = sum(reshape(F,length(F)/T,T),2).';
        G(E<0)=community_num;
        G(E>0)=i;
        X(find(X==i))=G;
        clear F;clear E;clear G;
        A_new = A(find(X==i),find(X==i),:);
        while any(any(A_new,[1,2])==0)
            i=i+1;
            A_new = A(find(X==i),find(X==i),:);
        end
        [B,mm] = multiord(A_new); % Newman-Girvan modularity matrix
        [V,D] = eigs_max(B); % max eigenvalue & eigenvector
    else
        i=i+1;
    end
end