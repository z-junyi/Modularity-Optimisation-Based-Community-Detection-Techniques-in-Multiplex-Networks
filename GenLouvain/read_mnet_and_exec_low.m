function [idx] = read_mnet_and_exec_low(directory,l,n,pfx)
C = cell([1 l]);
i = 1;
files = dir(strcat(directory,'*.ncol'));
for file = files'
  x = dlmread(strcat(directory,file.name));
  A=accumarray(x,1,[n,n],[],0,true);
  C{1,i}=A;
  i=i+1;
end
idx = call_glouvain_low_omega(C);
name = strcat(pfx,'_res.txt')
csvwrite(strcat(directory,name),idx)


