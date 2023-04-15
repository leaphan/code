
clear ; close all; clc
ALLdata= importdata('datasets/maxlitter.mat');
[m,n]=size(ALLdata);
label=ALLdata(:,n);

data=ALLdata(:,1:n-1);
k=2;
[new_data,new_label]=KN_datacreat(data,label,k);

sample_pair=[data,new_data,new_label];