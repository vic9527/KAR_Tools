%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vic Woo (vic.woo@qq.com)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% 格式：Struct
%%
%% 第二层分类-开始   

function [Vaccuracy, S2ndC_Best, predict_Label, predict_accuracy]=C2nd(TrainData, TestData, Ckind)

% TrainData=TR_C2nd_C1{23};
% TestData=TE_C2nd_C1{20};
% Trainlabel=TR_label{1};
% Testlabel=TE_label{1};

%  TR_Struct=struct('Feature',TrainData,'label',0,'Label1st',0);
%  TE_Struct=struct('Feature',TestData,'label',0,'Label1st',0);
%  
%  for j=1:size(TR_Struct,1)
%  TR_Struct(j).label=Trainlabel(j,1);
%  end
% 
%  for j=1:size(TE_Struct,1)
%  TE_Struct(j).label=Testlabel(j,1);
%  end

switch Ckind
    
    case 101
        FVrange=[13:18];
    case 102
        FVrange=[7:18];   
    case 103
        FVrange=[25:30];       
    otherwise
        fprintf('Error!  =_=凸  \n' );
end 



if size(TestData,1)~=0


    
%% Step.1 动态数据分类器（2种）         
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A=[1:size(TrainData,1)]';
%[M,N]=size(A);%计算矩阵维度
%indices = crossvalind('Kfold',A(1:M,N),kk);     

% % % label_Min=0;
% % % label_Min_Num=1;
% % % while label_Min<3
% % %     
% % %     kk=10;%设置几折
% % %     indices_num=0;
% % %     %indices_num_k=0;
% % %     while indices_num~=kk %% 必须每折都有值
% % %         indices = crossvalind('Kfold',1:size(TrainData,1),kk); 
% % %         indices_num=numel(unique( indices));
% % %        % indices_num_k=indices_num_k+1;
% % %     end
% % % 
% % % 
% % %     TE_DS={};
% % %     TR_DS={};
% % %             for k=1:kk    %交叉验证k=10，10个包轮流作为测试集
% % %                 test = (indices == k); 
% % %                 test_ID=find(test==1);
% % %                 train_ID=find(test==0);
% % %                 TE_DS{k}= TrainData(test_ID);%分配测试集
% % %                 TR_DS{k}= TrainData(train_ID);%分配训练集
% % %             end
% % %     clearvars  indices k test test_ID train_ID jj
% % %     
% % %    for k=1:kk 
% % %     labelAA= cat(1,TR_DS{k}.label); %按列读取label值
% % %     labelAA_Count=hist(labelAA,unique(labelAA)) ;
% % %     labelAA_Count_Min(k)=min(labelAA_Count);
% % %    end
% % %    
% % %    label_Min=min(labelAA_Count_Min);
% % %    
% % %     label_Min_Num=label_Min_Num+1;
% % %    
% % % end
% % %    
% % %     if label_Min_Num>1
% % %          fprintf('label_Min_Num: %d\n label_Min:%d\n',  label_Min_Num,label_Min);
% % %     end
% % %     
% % %     clearvars labelAA  labelAA_Count labelAA_Count_Min




label_Min=0;
label_Min_Num=0;
while label_Min<36
    
    kk=10;%设置几折
    indices_num=0;
    %indices_num_k=0;
    while indices_num~=kk %% 必须每折都有值
        indices = crossvalind('Kfold',1:size(TrainData,1),kk); 
        indices_num=numel(unique( indices));
       % indices_num_k=indices_num_k+1;
    end


    TE_DS={};
    TR_DS={};
            for k=1:kk    %交叉验证k=10，10个包轮流作为测试集
                test = (indices == k); 
                test_ID=find(test==1);
                train_ID=find(test==0);
                TE_DS{k}= TrainData(test_ID);%分配测试集
                TR_DS{k}= TrainData(train_ID);%分配训练集
            end
    clearvars  indices k test test_ID train_ID jj
    
   for k=1:kk 
    labelAA= cat(1,TR_DS{k}.label); %按列读取label值
    labelAA_Count= tabulate(labelAA);
    T=labelAA_Count(:,3);
    T(~T)=inf;
    [Min_label, Pos_label]=min(T);
    TR_DS_Cell=struct2cell(TR_DS{k});
    TR_DS_Cell= TR_DS_Cell';
    TR_DS_Cell_Min= TR_DS_Cell(find(cell2mat(TR_DS_Cell(:,2))== Pos_label),:);
    mink_num=0;     
    for mink=1:size(TR_DS_Cell_Min,1)
     mink_num=mink_num+ size(TR_DS_Cell_Min{mink},2);
    end
   labelAA_Min(k)=mink_num;
   end
   
   label_Min=min(labelAA_Min);
   
    label_Min_Num=label_Min_Num+1;
   
end
   
    if label_Min_Num>1
         fprintf('label_Min_Num: %d\n label_Min:%d\n',  label_Min_Num,label_Min);
    end
    
    clearvars labelAA 



   
  %% 使用HMM进行分类
 HMM_predict={};
 predict_label={};
 accuracy={};
 true_label={};
 HMM_accuracy=[];
 HMM_Models={};
parfor k=1:kk
%     k=4
%   param.O = 6;  % dimensionality of feature vector of each frame in an action sequence
%   param.Q = 6;   % number of states (default)
%   param.M = 6;    % number of mixtures
%   param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
%   param.max_iter = 10;    % number of iterations
%   param.verbose = 1;
 % Training
%  fprintf('HMM training.\n');
%  param.Q = 9;   % number of states
 HMM_Models{k} = hmmTrain(TR_DS{k}, FVrange);%tt
 % Testing
%  fprintf('HMM testing.\n');
 % prescale test data
 [accuracy{k}, predict_label{k}, true_label{k}] = hmmTest(TE_DS{k}, HMM_Models{k},FVrange);%tt
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
    for jj=1:size(TR_DS{k},1)
     TR_label{k}(jj,1)=TR_DS{k}(jj).label; 
     TR_data{k}{jj,1}=TR_DS{k}(jj).Feature(FVrange,:);
    end  
    for jj=1:size(TE_DS{k},1)
     TE_label{k}(jj,1)=TE_DS{k}(jj).label; 
     TE_data{k}{jj,1}=TE_DS{k}(jj).Feature(FVrange,:);
    end  
 end
 
%  FVdim=size(TR_data{1}{1},1);
%  Nclass=size(unique(TR_label{1}),1);

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
              
   clearvars C Cnum Cindex Cindexii Cvote CvoteMax_ID I MaxCvote S2ndC kk vv TE_DS TR_DS Ckind
   
   
              
 %% Step.3 测试最优分类器 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 switch S2ndC_Best
    
    case 1
         %% 使用HMM进行分类
         HMM_Models = hmmTrain(TrainData, FVrange);%tt
         [accuracy, predict_label, true_label] = hmmTest(TestData, HMM_Models,FVrange);%tt
         HMM_predict=predict_label;
         HMM_accuracy=length(find(HMM_predict==true_label))/length(true_label);
         fprintf('HMM_accuracy: %.4f\n',  HMM_accuracy);
         clearvars accuracy predict_label true_label HMM_Models
         
         predict_Label=HMM_predict;
         predict_accuracy=HMM_accuracy;
		 
    case 2
        %% 使用LSTM进行分类
 
         TR_data={};
         TE_data={};
            for jj=1:size(TrainData,1)
             TR_label(jj,1)=TrainData(jj).label; 
             TR_data{jj,1}=TrainData(jj).Feature(FVrange,:);
            end  
            for jj=1:size(TestData,1)
             TE_label(jj,1)=TestData(jj).label; 
             TE_data{jj,1}=TestData(jj).Feature(FVrange,:);
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
 
 
 clearvars FVrange HMM_accuracy HMM_predict LSTM_accuracy LSTM_predict TrainData TestData
 

else
    
 fprintf('Error!\n');
 
end




















 %% 第二层分类-结束     

end