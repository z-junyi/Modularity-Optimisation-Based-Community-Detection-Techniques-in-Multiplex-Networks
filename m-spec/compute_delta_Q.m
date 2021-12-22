function [delta_Q,F_new] = compute_delta_Q(V,B,mm)
F_new(find(V<0))=-1;
F_new(find(V==0))=1;
F_new(find(V>0))=1;


Q_new = F_new * B * F_new.'/(mm * length(V));
Q_old = ones(1,length(V)) * B * ones(1,length(V)).'/(mm * length(V));
delta_Q = Q_new - Q_old;