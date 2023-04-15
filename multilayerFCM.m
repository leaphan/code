function  [X_train,Xt_test_new,source_label_train,target_label_test]=multilayerFCM (sample_pair,sample_pair_t);


 data0=sample_pair(find((sample_pair(:,end)==0)),:);
 data1=sample_pair(find((sample_pair(:,end)==1)),:);
[m0,n0]=size(data0);
[m1,n1]=size(data1);

data0_t=sample_pair_t(find((sample_pair_t(:,end)==0)),:);                       
data1_t=sample_pair_t(find((sample_pair_t(:,end)==1)),:);                       
[m0t,n0t]=size(data0_t);
[m1t,n1t]=size(data1_t);



 
re=1;
K0=m0-re;
K1=m1-re;
 optionsFCM = [2, 50, 1e-5, 0];
% [X_train,Xt_test_new,source_label_train,target_label_test]=Samplerescontruction(data0,data1,data0_t,data1_t,K0,K1,K0t,K1t,n0,alpha,eps);

[Sydata0]=fcm(data0,K0, optionsFCM );
[Sydata1]=fcm(data1,K1,optionsFCM);
% [responsivity0,para_miu0,Sydata0,t0]=My_FCM(data0,K0,alpha,eps);
% [responsivity1,para_miu1,Sydata1,t1]=My_FCM(data1,K1,alpha,eps);
Xs_r=[Sydata0;Sydata1];             % 
Xt_r=[data0;data1];                    %
Xtest_r=[data0_t;data1_t];

Xs_train=Xs_r(:,1:n0-1);  source_label_train=Xs_r(:,end);
Xt_train=Xt_r(:,1:n0-1);  target_label_train=Xt_r(:,end);
Xt_test=Xtest_r(:,1:n0-1);target_label_test=Xtest_r(:,end);

Xs_train=Xs_train';
Xt_train=Xt_train';
Xt_test=Xt_test';



Xs_train = Xs_train./repmat(sqrt(sum(Xs_train.^2)),[size(Xs_train,1) 1]);  %//
Xt_train = Xt_train./repmat(sqrt(sum(Xt_train.^2)),[size(Xt_train,1) 1]);  %//  
Xt_test=Xt_test./repmat(sqrt(sum(Xt_test.^2)),[size(Xt_test,1) 1]);
   
ker_type=1; % 0:linear 1:nonlinear
[X_train, Y_train ,Xt_test_new]= My_MCTL(Xs_train,Xt_train,Xt_test,ker_type);

% % % % 3
Xs_r2=[X_train',source_label_train];
data0_2=Xs_r2(find((Xs_r2(:,end)==0)),:);                          %
data1_2=Xs_r2(find((Xs_r2(:,end)==1)),:);                          %
[m0_2,n0_2]=size(data0_2);
[m1_2,n1_2]=size(data1_2);



Xt_test_new_r2=[Xt_test_new',target_label_test];

test0_2=Xt_test_new_r2(find((Xt_test_new_r2(:,end)==0)),:);                          %
test1_2=Xt_test_new_r2(find((Xt_test_new_r2(:,end)==1)),:);                          %
[m0t_2,n0t_2]=size(test0_2);
[m1t_2,n1t_2]=size(test1_2);

K0_2=m0_2-re;
K1_2=m1_2-re;
% K0t_2=m0t_2-re;
% K1t_2=m1t_2-re;
%
[Sydata0_2]=fcm(data0_2,K0_2, optionsFCM );
[Sydata1_2]=fcm(data1_2,K1_2,optionsFCM);
% [responsivity0_2,para_miu0_2,Sydata0_2,t0_2]=My_FCM(data0_2,K0_2,alpha,eps);
% [responsivity1_2,para_miu1_2,Sydata1_2,t1_2]=My_FCM(data1_2,K1_2,alpha,eps);
Xs_r=[Sydata0_2;Sydata1_2];             %
Xt_r=[data0_2;data1_2];                    %
Xs_train=Xs_r(:,1:n0_2-1);  source_label_train=Xs_r(:,end);
Xt_train=Xt_r(:,1:n0_2-1);  target_label_train=Xt_r(:,end);
% Xt_test=Xtest_r(:,1:n0t_2-1);target_label_test=Xtest_r(:,end);
Xt_test=Xt_test_new_r2(:,1:n0t_2-1);target_label_test=Xt_test_new_r2(:,end);

Xs_train=Xs_train';
Xt_train=Xt_train';
Xt_test=Xt_test';
ker_type=1; % 0:linear 1:nonlinear
[X_train, Y_train ,Xt_test_new]= My_MCTL(Xs_train,Xt_train,Xt_test,ker_type);








end

