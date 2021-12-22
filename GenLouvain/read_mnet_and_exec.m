
function [idx] = read_mnet_and_exec(directory,l,n,pfx)
C = cell([1 l]);
i = 1;
%改成相应的文件名
%files = dir(strcat(directory,'/florentine_layer*.ncol'));
files = dir(strcat(directory,'/trans*.txt'));

for file = files'
  x = dlmread(strcat(directory,'/',file.name));
  A=accumarray(x,1,[n,n],[],0,true);
  C{1,i}=A;
  i=i+1;
end
idx = call_glouvain(C);
name = strcat(pfx,'_res.txt');
csvwrite(strcat(directory,name),idx)
end



