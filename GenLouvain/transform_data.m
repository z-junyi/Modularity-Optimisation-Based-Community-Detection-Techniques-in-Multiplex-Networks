%directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\Ckmpims';
%directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\Fao';
%directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\Florentine';
% directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\London_Transport';
%directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\Pierreauger';
directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\TailorShop';

fp = fopen(strcat(directory,'\Dataset\Kapferer-Tailor-Shop_multiplex.edges'),'r');
% fileID=fopen('Data.txt');
A=textscan(fp,'%f');
fclose(fp);
a1=cell2mat(A);
[c,d] = size(a1);
line=floor(c/4);
%a1 = a1';
a2 = reshape(a1,[4,line]);
M = a2';
t = arrayfun(@(x) M(M(:,1) == x, :), unique(M(:,1)), 'uniformoutput', false);
[tx,ty] = size(t);
for j = 1:tx
  files = strcat(directory,'\trans',num2str(j),'.txt');  
  tj = t{j}(:,2:3);
  [x,y] = size(tj);
  fp2 = fopen(files,'w');
  %fp2 = fopen('C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\input_data\arxiv\arxiv_layer1.txt','w');
for i = 1:x        % 建立for循环嵌套
    fprintf(fp2,'%d ',tj(i,:));
    fprintf(fp2,'\n');
end
fclose(fp2);
end    
% t1 = t{1};
% t1 = t1(:,2:3);
% [x,y]=size(t1);
% 
% fp2 = fopen('C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\input_data\arxiv\arxiv_layer1.txt','w');
% for i = 1:x        % 建立for循环嵌套
%     fprintf(fp2,'%d ',t1(i,:));
%     fprintf(fp2,'\n');
% end
% 
% % fp2 = fopen('C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\input_data\arxiv\arxiv_layer1.txt','a');
% % fprintf(fp2,'%f',t1);
% fclose(fp2);
% 
% 
