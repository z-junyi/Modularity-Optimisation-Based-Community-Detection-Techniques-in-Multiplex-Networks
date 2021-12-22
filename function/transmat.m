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