function [X_train, Y_train ,Xt_test_new]=My_MCTL(Xs_train,Xt_train,Xt_test,ker_type)
      
     if ker_type==0 
          Kernel='linear';
     X=[Xs_train Xt_train];
     Xs_train=[Xs_train Xt_train];
     Xt_train=[Xt_train Xt_test];
   else
       Kernel='gauss';
      X=[Xs_train];
     X=[Xs_train Xt_train];
     [le,lr]=size(X);
     X=X(:,randperm(lr));
%      wr=le-2;
%      X=X(:,1:wr);
     X=X(:,1:floor(le*(0.95)));
     Xs_train=[Xs_train];
     Xt_train=[Xt_train ];
     end 
   Graph_Xt_train_num=2;
      [Z,P,Ks, Kt,KY_test]=HSIC_MC(X,Xs_train,Xt_train,Xt_test,Graph_Xt_train_num,Kernel);    
%     %------------------------------------------------------   

     KX_train  = Ks;
     KY_train  = Kt;
%      KX_train  = Ks*Z;
     KY_test  = KY_test;
     
   X_train  = P'*KX_train;
   Y_train  = P'*KY_train;
   Xt_test_new  = P'*KY_test;
end
 
