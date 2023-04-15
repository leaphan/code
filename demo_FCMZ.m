
function   [ACC,Pre_pos,Pre_neg,Spe, Sen,Rec_pos,Rec_neg,G_mean,F1_score_Final_pos,F1_score_Final_neg,AUC, MCC,Mod]=deme_FCMZ(trData,ttData)
ACC=[];
Pre_pos=[];
Pre_neg=[];
Spe=[];
Sen=[];
Rec_pos=[];
Rec_neg=[];
G_mean=[];
F1_score_Final_pos=[];
F1_score_Final_neg=[];
AUC=[];
MCC=[];
%Kappa=[];

for  s=1
     
tr = trData{s};
tt = ttData{s};
[tr, tt] = dataNorm(tr, tt); 

data0=tr(find((tr(:,end)==0)),:);                          
data1=tr(find((tr(:,end)==1)),:);                          

 [m0,n0]=size(data0);
 [m1,n1]=size(data1);
 f_s=sum(data0(:,1:n0-1),2);            
 [f_s_s,I]=sort(f_s,'ascend');
 IR=m0/m1;                                   
 we=1;
 if IR>=10
     Mod=floor(we*IR); 
%      Mod=9;
 else
     Mod=floor(we*IR);
 end
 
 data0_Q=division( Mod,m1,I,data0);
 


[predicted_label,mtest,target_label_test]=crea_class(data0_Q,data1,Mod,tt);
 label_final=[];
%classification

for index=1:mtest
if(sum(predicted_label(index,:))>floor(Mod/2))
label_final(index)=1;
 else
label_final(index)=0;    
end
end
label_final_T=label_final';
Y_unique = unique(target_label_test);
CM = zeros(size(Y_unique,1),size(Y_unique,1));
       for n = 1:2
           in = find(target_label_test == Y_unique(n,1)); 
           Y_pred =   label_final_T(in,1);
           CM(n,1) = size(find( Y_pred == Y_unique(1,1)),1);
           CM(n,2) = size(find( Y_pred == Y_unique(2,1)),1);
       end
       
       TP = CM(1,1);
       FN = CM(1,2);
       FP = CM(2,1);
       TN= CM(2,2);
       TNR = TN/(FP + TN);
       TN=max(1,TN);
       TP=max(1,TP);
 
     
    
       ACC_e = (TP + TN) / (TP + TN + FP + FN);
       Pre_pos_e= TP / (TP+ FP);      
       Pre_neg_e=TN / (TN+ FN);     
      
       Spe_e=TN / (FP+ TN);
       Sen_e=TP/(TP+FN);
       Rec_pos_e=Sen_e;     
       Rec_neg_e=Spe_e;   
       TN = max(1,TN); 
       G_mean_e = sqrt(Sen_e * Spe_e);
       F1_score_Final_pos_e = (2 * Pre_pos_e * Rec_pos_e) / (Pre_pos_e + Rec_pos_e);
       F1_score_Final_neg_e = (2 * Pre_neg_e * Rec_neg_e) / (Pre_neg_e + Rec_neg_e);
       AUC_e=(Spe_e+Sen_e)/2;
       MCC_e=(TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));
      
       ACC=[ACC;ACC_e];
       Pre_pos=[Pre_pos; Pre_pos_e];
       Pre_neg=[Pre_neg; Pre_neg_e];
       Spe=[Spe;Spe_e];
       Sen=[ Sen;Sen_e];
       Rec_pos=[Rec_pos;Rec_pos_e];
       Rec_neg=[Rec_neg;Rec_neg_e];
       G_mean=[G_mean;G_mean_e];
       F1_score_Final_pos=[F1_score_Final_pos;F1_score_Final_pos_e];
       F1_score_Final_neg=[F1_score_Final_neg;F1_score_Final_neg_e];
       AUC=[AUC;AUC_e];   
       MCC=[MCC; MCC_e];
       
end


end








