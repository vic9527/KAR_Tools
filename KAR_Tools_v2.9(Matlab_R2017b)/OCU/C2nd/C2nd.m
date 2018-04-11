%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vic Woo (vic.woo@qq.com)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% 格式：Struct
%%
%% 第二层分类-开始   

function [Vaccuracy, S2ndC_Best, predict_Label, predict_accuracy]=C2nd(TrainData, TestData, C1st_predict_Label, Ckind)

% TrainData=TR_DS(1);
% TestData=TE_DS(1);

if size(TestData,1)~=0

[TrainT, TrainV]=UIVboost(TrainData{1},5,2);
[TrainT_label, TrainT_data,  TrainT_Label1st]=DS_Extraction(TrainT);
[TrainV_label, TrainV_data, TrainV_Label1st]=DS_Extraction(TrainV);   
TrainT_FV2nd=RPRO_Cell(TrainT_data);
TrainV_FV2nd=RPRO_Cell(TrainV_data);
%% 转化成Struct格式
TrainT_FV2nd_Struct=FV_Cell2Struct(TrainT_FV2nd,TrainT_label,TrainT_Label1st);
TrainV_FV2nd_Struct=FV_Cell2Struct(TrainV_FV2nd,TrainV_label,TrainV_Label1st);

LLL=size(TrainT_Label1st,2);
for ll=1:LLL
    TrainT_C2nd_C{ll}=TrainT_FV2nd_Struct{ll}(TrainT_Label1st{ll}==Ckind);
    TrainV_C2nd_C{ll}=TrainV_FV2nd_Struct{ll}(TrainV_Label1st{ll}==Ckind);
end 


%% Step.1 动态数据分类器（2种）    


AFlen=TrainT_FV2nd_Struct{1,1}(1).Feature;
Flen=size(AFlen,1)/5;
switch Ckind
    
    case 101
        %FVrange=[13:18];
		FVrange=[Flen*(3-1)+1:Flen*3];
    case 102
        %FVrange=[7:18];   
        FVrange=[Flen*(2-1)+1:Flen*3];
    case 103
        %FVrange=[25:30];
        FVrange=[Flen*(5-1)+1:Flen*5];
    otherwise
        fprintf('Error!  =_=凸  \n' );
end 


  %% 使用HMM进行分类
 HMM_predict={};
 predict_label={};
 accuracy={};
 true_label={};
 HMM_accuracy=[];
 HMM_Models={};
 kk=LLL;
parfor k=1:kk
 HMM_Models{k} = hmmTrain(TrainT_C2nd_C{k}, FVrange);%tt
 [accuracy{k}, predict_label{k}, true_label{k}] = hmmTest(TrainV_C2nd_C{k}, HMM_Models{k},FVrange);%tt
 HMM_predict{k}=predict_label{k};
 HMM_accuracy(k)=length(find(HMM_predict{k}==true_label{k}))/length(true_label{k});
end
 fprintf('HMM_accuracy: %.4f\n',  HMM_accuracy);
 clearvars accuracy HMM_Models HMM_predict predict_label true_label
 
 %% 使用LSTM进行分类
 TR_label={};
 TR_data={};
 TE_label={};
 TE_data={};
 for k=1:kk 
    for jj=1:size(TrainT_C2nd_C{k},1)
     TR_label{k}(jj,1)=TrainT_C2nd_C{k}(jj).label; 
     TR_data{k}{jj,1}=TrainT_C2nd_C{k}(jj).Feature(FVrange,:);
    end  
    for jj=1:size(TrainV_C2nd_C{k},1)
     TE_label{k}(jj,1)=TrainV_C2nd_C{k}(jj).label; 
     TE_data{k}{jj,1}=TrainV_C2nd_C{k}(jj).Feature(FVrange,:);
    end  
 end
LSTM_predict={};
parfor k=1:kk  
    %% [YPred, YAcc]=KAR_LSTM(X,Y,XTest,YTest,FVdim,Hunit,Nclass,drops,batchs,iters)
    [LSTM_predict{k},LSTM_acc(k)]=KAR_LSTM(TR_data{k},TR_label{k},TE_data{k},TE_label{k},size(TR_data{k}{1},1),50, size(unique(TR_label{k}),1), 3, 1, 100);
    LSTM_accuracy(k)=length(find(LSTM_predict{k}==TE_label{k}))/length(TE_label{k});
end
 fprintf('LSTM_accuracy: %.4f\n',  LSTM_accuracy); 
 clearvars TR_label TR_data TE_label TE_data jj k LSTM_acc LSTM_predict
 
 
Vaccuracy=[HMM_accuracy;LSTM_accuracy];
 clearvars HMM_accuracy LSTM_accuracy
 %% Step.2 选择最优动态数据分类器    
 %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

          Cnum=2;%分类器数量
          Vaccuracy(:,kk+2)=mean(Vaccuracy(1:Cnum,1:kk),2);         
          [C,I]=max(Vaccuracy);
          Vaccuracy(Cnum+2,:)=C;
          Cindex=[];
          for vv=1:kk
              Cindexii=find(Vaccuracy(1:Cnum,vv)==C(vv));
              Cindex=[Cindex; Cindexii];
          end          
          Cvote=tabulate(Cindex);
          [MaxCvote,S2ndC]= max(Cvote(:,3));           
          CvoteMax_ID=find(Cvote(:,3)==MaxCvote);         
          if length(CvoteMax_ID)~=1
              CvoteMeanMax=[CvoteMax_ID,Vaccuracy(CvoteMax_ID,kk+2)];
              [MaxCvote_value,S2ndC_index]=max(CvoteMeanMax(:,2));
              S2ndC=CvoteMeanMax(S2ndC_index,1);
          end
              S2ndC_Best=S2ndC;
              
   clearvars C Cnum Cindex Cindexii Cvote CvoteMax_ID I MaxCvote S2ndC kk vv TE_DS TR_DS 
   
   
              
 %% Step.3 测试最优分类器 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[TR_label, TR_data,  TR_Label1st]=DS_Extraction(TrainData);
[TE_label, TE_data, TE_Label1st]=DS_Extraction(TestData);   
TR_FV2nd=RPRO_Cell(TR_data);
TE_FV2nd=RPRO_Cell(TE_data);
TR_FV2nd_Struct=FV_Cell2Struct(TR_FV2nd,TR_label,TR_Label1st);
TE_FV2nd_Struct=FV_Cell2Struct(TE_FV2nd,TE_label,TE_Label1st);

TestData_C1st_predict_Label=C1st_predict_Label{1};
TR_C2nd_C=TR_FV2nd_Struct{1}(TR_Label1st{1}==Ckind);
TE_C2nd_C=TE_FV2nd_Struct{1}(TestData_C1st_predict_Label==Ckind);

 switch S2ndC_Best
    
    case 1
         %% 使用HMM进行分类
         HMM_Models = hmmTrain(TR_C2nd_C, FVrange);%tt
         [accuracy, predict_label, true_label] = hmmTest(TE_C2nd_C, HMM_Models,FVrange);%tt
         HMM_predict=predict_label;
         HMM_accuracy=length(find(HMM_predict==true_label))/length(true_label);
         fprintf('HMM_accuracy: %.4f\n',  HMM_accuracy);
         clearvars accuracy predict_label true_label HMM_Models
         
         predict_Label=HMM_predict;
         predict_accuracy=HMM_accuracy;
		 
    case 2
        %% 使用LSTM进行分类
        
        TR_label=[];
        TE_label=[];
         TR_data={};
         TE_data={};
            for jj=1:size(TR_C2nd_C,1)
             TR_label(jj,1)=TR_C2nd_C(jj).label; 
             TR_data{jj,1}=TR_C2nd_C(jj).Feature(FVrange,:);
            end  
            for jj=1:size(TE_C2nd_C,1)
             TE_label(jj,1)=TE_C2nd_C(jj).label; 
             TE_data{jj,1}=TE_C2nd_C(jj).Feature(FVrange,:);
            end  

         %% [YPred, YAcc]=KAR_LSTM(X,Y,XTest,YTest,FVdim,Hunit,Nclass,drops,batchs,iters)
         [LSTM_predict,LSTM_acc]=KAR_LSTM(TR_data,TR_label,TE_data,TE_label,size(TR_data{1},1),50, size(unique(TR_label),1), 3, 1, 100); 
         LSTM_accuracy=length(find(LSTM_predict==TE_label))/length(TE_label);
         fprintf('LSTM_accuracy: %.4f\n',  LSTM_accuracy);    
         clearvars LSTM_acc jj  TR_label  TR_data TE_label  TE_data
         
         predict_Label=LSTM_predict;
         predict_accuracy=LSTM_accuracy;
         
     otherwise
        
        fprintf('Error!  =_=凸  \n' );
        
end 
 

 

else
    
 fprintf('Error!\n');
 
end



 %% 第二层分类-结束     

end