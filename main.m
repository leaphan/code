clc;clear;
clear
close all
tic;
data=xlsread('filepath\Iris0.xlsx','Sheet1','B2:F151');

 
ACCT=[];
Pre_posT=[];
Pre_negT=[];
SpeT=[];
SenT=[];
Rec_posT=[];
Rec_negT=[];
G_meanT=[];
F1_score_Final_posT=[];
F1_score_Final_negT=[];
AUCT=[];
MCCT=[];
%KappaT=[];

for gu=1:10
    
    [trData,ttData]=CV_method(data);

    [ACC,Pre_pos,Pre_neg,Spe, Sen,Rec_pos,Rec_neg,G_mean,F1_score_Final_pos,F1_score_Final_neg,AUC, MCC,Mod]=demo_FCMZ(trData,ttData);

    
       ACCT=[ACCT;ACC];
       Pre_posT=[Pre_posT; Pre_pos];
       Pre_negT=[Pre_negT; Pre_neg];
       SpeT=[SpeT;Spe];
       SenT=[ SenT;Sen];
       Rec_posT=[Rec_posT;Rec_pos];
       Rec_negT=[Rec_negT;Rec_neg];
       G_meanT=[G_meanT;G_mean];
       F1_score_Final_posT=[F1_score_Final_posT;F1_score_Final_pos];
       F1_score_Final_negT=[F1_score_Final_negT;F1_score_Final_neg];
       AUCT=[AUCT;AUC];   
       MCCT=[MCCT; MCC];
      % KappaT=[KappaT;Kappa];
end 
%mean
Re_ACC=mean(ACCT);
Re_Pre_pos=mean(Pre_posT); 
Re_Pre_neg=mean(Pre_negT);
Re_Spe=mean(SpeT);
Re_Sen=mean(SenT);
Re_Rec_pos=mean(Rec_posT);
Re_Rec_neg=mean(Rec_negT);
Re_G_mean=mean(G_meanT);
Re_F1_score_Final_pos=mean(F1_score_Final_posT);
Re_F1_score_Final_neg=mean(F1_score_Final_negT);
Re_AUC=mean(AUCT);
Re_MCC=mean(MCCT);

%std
Re_ACC_std=std(ACCT);
Re_Pre_pos_std=std(Pre_posT);
Re_Pre_neg_std=std(Pre_negT);
Re_Spe_std=std(SpeT);
Re_Sen_std=std(SenT);
Re_Rec_pos_std=std(Rec_posT);
Re_Rec_neg_std=std(Rec_negT);
Re_G_mean_std=std(G_meanT);
Re_F1_score_Final_pos_std=std(F1_score_Final_posT);
Re_F1_score_Final_neg_std=std(F1_score_Final_negT);
Re_AUC_std=std(AUCT);
Re_MCC_std=std(MCCT);

toc;
time=toc;