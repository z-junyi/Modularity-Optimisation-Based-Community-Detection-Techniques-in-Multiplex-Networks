function [V,D] = eigs_max(B)
[V_all,D_all] = eigs(B);
eigenvalue=diag(D_all); % 求对角线向量
D = max(eigenvalue); % 求最大特征值
for i=1:length(D_all) % 求最大特征值对应的序数
    if D==eigenvalue(i)
        break;
    end
end
V = V_all(:,i); %求矩阵最大特征值对应的特征向量

