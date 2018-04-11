%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bin Liang (bin.liang.ty@gmail.com)
% Charles Sturt University
% Created:	Jan 2014
% Modified:	Jan 2014
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Step.1 -- Preparing for running
% clear variables
clear all; close all; clc;
% add to path
this_dir = pwd;
addpath(genpath(this_dir));
verbose = 1;  
All_data_dir = ['E:\T7\MSRAction3DSkeletonReal3D_112\'];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.2 -- Load all data
fprintf('Loading all data:\n');
All_Actions = loadData2(All_data_dir, verbose);
fprintf('All data have been loaded.\n\n')
clearvars Kaccuracy predictAA verbose All_data_dir

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.3 --K-VC 
kk=10;
 A=[1:size(All_Actions,2)]';
[M,N]=size(A);%%计算矩阵维度
indices = crossvalind('Kfold',A(1:M,N),kk); 
clearvars -except All_Actions indices kk
for k=1:kk    %%//交叉验证k=10，10个包轮流作为测试集
    k
  test = (indices == k); %%//获得test集元素在数据集中对应的单元编号
%   train = ~test;%%//train集元素的编号为非test元素的编号
  test_ID=find(test==1);
  train_ID=find(test==0);
 TE_Actions= All_Actions(test_ID);
 TR_Actions= All_Actions(train_ID);


   %% Step.3.1 --1st Level
  for jj=1:size(TR_Actions,2)
     TP_Mean(jj,:)=  mean([TR_Actions(jj).ObservationsA(:,2:end)]');
     TP_Var(jj,:)=  var([TR_Actions(jj).ObservationsA(:,2:end)]'); 
     end
     TR_TP=[TP_Mean,TP_Var];     
     clearvars TP_Mean TP_Var
    
     for jj=1:size(TE_Actions,2)
     TP_Mean(jj,:)=  mean([TE_Actions(jj).ObservationsA(:,2:end)]');
     TP_Var(jj,:)=  var([TE_Actions(jj).ObservationsA(:,2:end)]'); 
     end   
     TE_TP=[TP_Mean,TP_Var];     
 clearvars TP_Mean TP_Var
 
 [AA,ps] = mapminmax(TR_TP',0,1); %%标准化
train_AA = AA';
train_AA_labels=[TR_Actions.labelA]';
test_AA = (mapminmax('apply', TE_TP', ps))'; %%标准化
test_AA_labels=[TE_Actions.labelA]';  

test_Real_labels=[TE_Actions.label]';  

        [bestacc,bestc,bestg] = SVMcgForClass(train_AA_labels,train_AA);
        cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_AA_labels,train_AA,cmdo);
        [predict_labelA, accuracy, decision_values] = svmpredict(test_AA_labels, test_AA, model);
        PredictAA=[test_AA_labels,predict_labelA];
%  Kaccuracy(k)=accuracy(1);
  clearvars TR_TP TE_TP
 
  CPRP=[test_Real_labels,PredictAA,predict_labelA];
 
 
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Step.3.2 --2nd Level
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% Step.3.2.1
 
TR_Actions1C=TR_Actions([TR_Actions.labelA]'==101);
TE_Actions1C=TE_Actions(predict_labelA==101);
if size(TE_Actions1C,2)~=0
    
%% Step.3.2.1-- recognition using HMM
param.O = 6;  % dimensionality of feature vector of each frame in an action sequence
param.Q = 6;   % number of states (default)
param.M = 6;    % number of mixtures
param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
param.max_iter = 10;    % number of iterations
param.verbose = 1;

%%Training
fprintf('HMM training.\n');
param.Q = 9;   % number of states
HMM_Models = hmmTrain1C(TR_Actions1C, param);%tt

%%Testing
fprintf('HMM testing.\n');
% prescale test data
[accuracy, predict_label1C, true_label] = hmmTest1C(TE_Actions1C, HMM_Models);%tt

predictAA1C=[true_label,predict_label1C];
% Kaccuracy(k)=accuracy;
 fprintf('accuracy: %.4f\n', accuracy);
 CPRP((CPRP(:,4)==101),4)=predict_label1C;
%  predictAA{k}=[predict_label, true_label];

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.3.2.2

TR_Actions2C=TR_Actions([TR_Actions.labelA]'==102);
TE_Actions2C=TE_Actions(predict_labelA==102);

if size(TE_Actions2C,2)~=0
 %%%%%% 
 %%%%%% 
 %%%%%% 
    %% Step.3.2.2(1)-- recognition using SVM

   for jj=1:size(TR_Actions2C,2)
     TP_Mean(jj,:)=  mean([TR_Actions2C(jj).ObservationsA(4:9,2:end)]');
     TP_Var(jj,:)=  var([TR_Actions2C(jj).ObservationsA(4:9,2:end)]'); 
     end
     TR_TP=[TP_Mean,TP_Var];     
     clearvars TP_Mean TP_Var
    
     for jj=1:size(TE_Actions2C,2)
     TP_Mean(jj,:)=  mean([TE_Actions2C(jj).ObservationsA(4:9,2:end)]');
     TP_Var(jj,:)=  var([TE_Actions2C(jj).ObservationsA(4:9,2:end)]'); 
     end   
     TE_TP=[TP_Mean,TP_Var];     
 clearvars TP_Mean TP_Var
 
 [AA,ps] = mapminmax(TR_TP',0,1); %%标准化
train_AA = AA';
train_AA_labels=[TR_Actions2C.label]';
test_AA = (mapminmax('apply', TE_TP', ps))'; %%标准化
test_AA_labels=[TE_Actions2C.label]';  

        [bestacc,bestc,bestg] = SVMcgForClass(train_AA_labels,train_AA);
        cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_AA_labels,train_AA,cmdo);
        [predict_label2C, accuracy, decision_values] = svmpredict(test_AA_labels, test_AA, model);
        PredictAA2C=[test_AA_labels,predict_label2C];
%  Kaccuracy(k)=accuracy(1);
  clearvars TR_TP TE_TP
 CPRP((CPRP(:,4)==102),4)=predict_label2C;
 %%%%%% 
 %%%%%% 
 %%%%%% 
 
 
 
%%%%%% 
%%%%%% 
%%%%%% 
% % %    %% Step.3.2.2(2)-- recognition using HMM
% % % param.O = 12;  % dimensionality of feature vector of each frame in an action sequence
% % % param.Q = 6;   % number of states (default)
% % % param.M = 6;    % number of mixtures
% % % param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
% % % param.max_iter = 10;    % number of iterations
% % % param.verbose = 1;
% % % 
% % % %%Training
% % % fprintf('HMM training.\n');
% % % param.Q = 9;   % number of states
% % % HMM_Models = hmmTrain2C(TR_Actions2C, param);%tt
% % % 
% % % %%Testing
% % % fprintf('HMM testing.\n');
% % % % prescale test data
% % % [accuracy, predict_label2C, true_label] = hmmTest2C(TE_Actions2C, HMM_Models);%tt
% % % 
% % % predictAA2C=[true_label,predict_label2C];
% % % % Kaccuracy(k)=accuracy;
% % %  fprintf('accuracy: %.4f\n', accuracy);
% % %  CPRP((CPRP(:,4)==102),4)=predict_label2C;
% % % %  predictAA{k}=[predict_label, true_label];
 %%%%%% 
 %%%%%% 
 %%%%%% 
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.3.2.3

TR_Actions3C=TR_Actions([TR_Actions.labelA]'==103);
TE_Actions3C=TE_Actions(predict_labelA==103);

if size(TE_Actions3C,2)~=0
    
   %% Step.3.2.3-- recognition using HMM
param.O = 6;  % dimensionality of feature vector of each frame in an action sequence
param.Q = 6;   % number of states (default)
param.M = 6;    % number of mixtures
param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
param.max_iter = 10;    % number of iterations
param.verbose = 1;

%%Training
fprintf('HMM training.\n');
param.Q = 9;   % number of states
HMM_Models = hmmTrain3C(TR_Actions3C, param);%tt

%%Testing
fprintf('HMM testing.\n');
% prescale test data
[accuracy, predict_label3C, true_label] = hmmTest3C(TE_Actions3C, HMM_Models);%tt

predictAA3C=[true_label,predict_label3C];
% Kaccuracy(k)=accuracy;
 fprintf('accuracy: %.4f\n', accuracy);
 CPRP((CPRP(:,4)==103),4)=predict_label3C;
%  predictAA{k}=[predict_label, true_label];


% % % % % % %    for jj=1:size(TR_Actions3L,2)
% % % % % % %      TP_Mean(jj,:)=  mean([TR_Actions3L(jj).ObservationsA(13:15,2:end)]');
% % % % % % %      TP_Var(jj,:)=  var([TR_Actions3L(jj).ObservationsA(13:15,2:end)]'); 
% % % % % % %      end
% % % % % % %      TR_TP=[TP_Mean,TP_Var];     
% % % % % % %      clearvars TP_Mean TP_Var
% % % % % % %     
% % % % % % %      for jj=1:size(TE_Actions3L,2)
% % % % % % %      TP_Mean(jj,:)=  mean([TE_Actions3L(jj).ObservationsA(13:15,2:end)]');
% % % % % % %      TP_Var(jj,:)=  var([TE_Actions3L(jj).ObservationsA(13:15,2:end)]'); 
% % % % % % %      end   
% % % % % % %      TE_TP=[TP_Mean,TP_Var];     
% % % % % % %  clearvars TP_Mean TP_Var
% % % % % % %  
% % % % % % %  [AA,ps] = mapminmax(TR_TP',0,1); %%标准化
% % % % % % % train_AA = AA';
% % % % % % % train_AA_labels=[TR_Actions3L.label]';
% % % % % % % test_AA = (mapminmax('apply', TE_TP', ps))'; %%标准化
% % % % % % % test_AA_labels=[TE_Actions3L.label]';  
% % % % % % % 
% % % % % % %         [bestacc,bestc,bestg] = SVMcgForClass(train_AA_labels,train_AA);
% % % % % % %         cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
% % % % % % %         model = svmtrain(train_AA_labels,train_AA,cmdo);
% % % % % % %         [predict_label3L, accuracy, decision_values] = svmpredict(test_AA_labels, test_AA, model);
% % % % % % %         PredictAA3L=[test_AA_labels,predict_label3L];
% % % % % % % %  Kaccuracy(k)=accuracy(1);
% % % % % % %   clearvars TR_TP TE_TP
% % % % % % %    CPRP((CPRP(:,4)==103),4)=predict_label3L;
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
   %% Step.4--Final Result
   
%  CPRP((CPRP(:,4)==101),4)=predict_label1L;
%  CPRP((CPRP(:,4)==102),4)=predict_label2L;
%  CPRP((CPRP(:,4)==103),4)=predict_label3L;
%   CPRP=[test_Real_labels,PredictAA,predict_labelA];

[C,order] = confusionmat(CPRP(:,1),CPRP(:,4));

Cbag{k}=C;
CPRPbag{k}=CPRP;

Caccuracy(k)=trace(C)/sum(sum(C));


clearvars -except All_Actions indices kk Caccuracy Cbag CPRPbag
end

MeanCaccuracy=mean(Caccuracy);
Finaccuracy=sprintf('%2.8f%%', (MeanCaccuracy)*100)
StdFA=std(Caccuracy)*100



