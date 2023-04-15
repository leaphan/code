function [new_data,new_label]=KN_datacreat(data,label,k)



[m,n]=size(data);
Di_index=find(label==0);%
Dni_index=find(label==1);
% D3_index=find(label==3);%
% D4_index=find(label==4);


Di=data(Di_index,:);%
Dni=data(Dni_index,:);%
% D3=data(D3_index,:);
% D4=data(D4_index,:);


new_data=[];
new_label=[];
for i=1:m
dest=data(i,:);%
if label(i,1)==0
    nr=pdist2(dest,Di);%
    [num,idx]=sort(nr);%
    a=(Di(idx(2:k),:))';
    bh=(a(:))';
    new_data=[new_data;bh];
    new_label=[new_label;zeros(2-1,1)];
end
    if label(i,1)==1
    nr=pdist2(dest,Dni);
    [num,idx]=sort(nr);%
    a1=(Dni(idx(2:k),:))';
    bh1=(a1(:))';
    new_data=[new_data;bh1];
    new_label=[new_label;ones(2-1,1)];
    end
%  if label(i,1)==3
%     nr=pdist2(dest,D3);
%     [num,idx]=sort(nr);%
%     new_data=[new_data;D3(idx(2:k),:)];
%     new_label=[new_label;zeros(k-1,1)];
%  end
%   if label(i,1)==4
%     nr=pdist2(dest,D4);
%     [num,idx]=sort(nr);%
%     new_data=[new_data;D4(idx(2:k),:)];
%     new_label=[new_label;zeros(k-1,1)];
%  end
end
end