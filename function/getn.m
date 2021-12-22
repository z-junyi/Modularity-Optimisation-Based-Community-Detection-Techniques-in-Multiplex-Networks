function[n] = getn(directory,file1)
    fp = fopen(strcat(directory,file1),'r');
    % fileID=fopen('Data.txt');
    A=textscan(fp,'%d %*[^\n]','HeaderLines',1);
    a1=cell2mat(A);
    [n,m] = size(a1);
    % [c,d] = size(a1);
    % line=floor(c/14);
    fclose(fp);
end