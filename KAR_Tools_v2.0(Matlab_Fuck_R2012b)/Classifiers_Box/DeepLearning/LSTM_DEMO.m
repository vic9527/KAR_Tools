clear;clc
load ALLACTIONS

 for jj=1:size(All_Actions,2)
            All_Actions_label(jj,1)=All_Actions(jj).label; 
            All_Actions_Feature2nd{jj,1}=All_Actions(jj).Feature2nd;
 end  
 
X=All_Actions_Feature2nd;
Y=All_Actions_label;
XTest=X(1:200);
YTest=Y(1:200);

LSTM_Y=LSTM(X,Y,XTest,YTest);
sum(LSTM_Y == YTest)/200
