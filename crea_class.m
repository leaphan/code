function [predicted_label,mtest,target_label_test]=crea_class(data0_Q,data1,Mod,tt)
predicted_label=[];
   
for j=1:Mod
       
        

        data0=data0_Q{j};
        data_balance_s=[data0;data1];
        [m,n]=size(data_balance_s);
        label=data_balance_s(:,n);
        data=data_balance_s(:,1:n-1);
        k=1;
       [new_data,new_label]=KN_datacreat(data,label,k);
       sample_pair=[data,new_data,new_label];
    
       [mt,nt]=size(tt);
       label_t=tt(:,nt);
       data_t=tt(:,1:nt-1);
       [new_data_t,new_label_t]=KN_datacreat(data_t,label_t,k);
       sample_pair_t=[data_t,new_data_t,new_label_t];
       
       [X_train,Xt_test_new,source_label_train,target_label_test]=multilayerFCM (sample_pair,sample_pair_t);
      Xt_test_new_rand=[Xt_test_new',target_label_test];
      [mtest,ntest]=size(Xt_test_new_rand);
       test_targets = Use_C4_5(X_train, source_label_train, Xt_test_new, 2,5);
       pry_test_1= test_targets';
      predicted_label=[predicted_label,pry_test_1];        
end
  
%    for j=1:Mod
%           data_balance_s=data_balance{j};
%           [m,n]=size(data_balance_s);
%           label=data_balance_s(:,n);
%          data=data_balance_s(:,1:n-1);
%          k=3;
%        [new_data,new_label]=KN_datacreat(data,label,k);
%        sample_pair=[data,new_data,new_label];
%     
%        [mt,nt]=size(tt);
%        label_t=tt(:,nt);
%        data_t=tt(:,1:nt-1);
%        [new_data_t,new_label_t]=KN_datacreat(data_t,label_t,k);
%         sample_pair_t=[data_t,new_data_t,new_label_t];
%     
%    
%     
%       [X_train,Xt_test_new,source_label_train,target_label_test]=multilayerFCM (sample_pair,sample_pair_t);
%    
%       Xt_test_new_rand=[Xt_test_new',target_label_test];
%       [mtest,ntest]=size(Xt_test_new_rand);
% %    Xt_test_new_rand_rand=Xt_test_new_rand(randperm(mtest),:);
% %    label_test=Xt_test_new_rand_rand(:,end);
% %    test_data=Xt_test_new_rand_rand(:,1:ntest-1);
% %    model =  svmtrain(source_label_train,X_train','-s 0 -t 0 ');
% %       model =  svmtrain(source_label_train,X_train','-s 0 -c 10^5 -t 0 -q');
%        model =  svmtrain(source_label_train,X_train','-s 0 -c 10^5 -t 0 -q');
%       [pry_test_1] = svmpredict(target_label_test,Xt_test_new', model);
%       predicted_label=[predicted_label,pry_test_1];     
% end

end



