function [a1] = transform_datanet(directory,file)
    % directory = 'C:\Users\Lenovo\Documents\uuinfolab-20csur-a48c69dc0930\algorithms\GenLouvain\data\aucs';
    % file = '\Dataset\CS-Aarhus_multiplex.edges';
    fp = fopen(strcat(directory,file),'r');
    % fileID=fopen('Data.txt');
    A=textscan(fp,'%f');
    fclose(fp);
    a1=cell2mat(A);

    %a1 = a1';
end
