function [X_train,Xt_test_new,source_label_train,target_label_test]=Samplerescontruction(data0_2,data1_2,test0_2,test1_2,K0_2,K1_2,K0t_2,K1t_2,n0,alpha,eps)



[responsivity0_2,para_miu0_2,Sydata0_2,t0_2]=My_FCM(data0_2,K0_2,alpha,eps);
[responsivity1_2,para_miu1_2,Sydata1_2,t1_2]=My_FCM(data1_2,K1_2,alpha,eps);

Xs_r=[Sydata0_2;Sydata1_2];             %源域 
Xt_r=[data0_2;data1_2];                    %目标域
Xtest_r=[Sydata0t_2;Sydata1t_2];     %测试集
Xs_train=Xs_r(:,1:n0-1);  source_label_train=Xs_r(:,end);
Xt_train=Xt_r(:,1:n0-1);  target_label_train=Xt_r(:,end);
Xt_test=Xtest_r(:,1:n0-1);target_label_test=Xtest_r(:,end);

Xs_train=Xs_train';
Xt_train=Xt_train';
Xt_test=Xt_test';
ker_type=1; % 0:linear 1:nonlinear
[X_train,Xt_test_new]= My_MCTL(Xs_train,Xt_train,Xt_test,ker_type);



end




