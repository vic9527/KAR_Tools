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
All_data_dir = ['E:\HAR\StudyWork\SW1.0\T7\MSRAction3DSkeletonReal3D_fei\'];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.2 -- Load all data
fprintf('Loading all data:\n');
All_Actions = loadData3fei(All_data_dir, verbose);
% FV_Dim=All_Actions(1).dim;
fprintf('All data have been loaded.\n\n')
clearvars Kaccuracy predictAA verbose All_data_dir 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.3 --K-VC 
kk=5;
 A=[1:size(All_Actions,2)]';
[M,N]=size(A);%%计算矩阵维度size(A,2)
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
 FV_Dim=TR_Actions(1).dim;

   
%% Step.3.2.1-- recognition using HMM
param.O = FV_Dim;  % dimensionality of feature vector of each frame in an action sequence
param.Q = 6;   % number of states (default)
param.M = 6;    % number of mixtures
param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
param.max_iter = 10;    % number of iterations
param.verbose = 1;

%%Training
fprintf('HMM training.\n');
param.Q = 9;   % number of states
HMM_Models = hmmTrain1C(TR_Actions, param);%tt

%%Testing
fprintf('HMM testing.\n');
% prescale test data
[accuracy, predict_label1C, true_label] = hmmTest1C(TE_Actions, HMM_Models);%tt

predictAA1C=[true_label,predict_label1C];
% Kaccuracy(k)=accuracy;
 fprintf('accuracy: %.4f\n', accuracy);
%  CPRP((CPRP(:,4)==101),4)=predict_label1C;
%  predictAA{k}=[predict_label, true_label];

Caccuracy(k)=accuracy;




% [C,order] = confusionmat(predictAA1C);
% 
% Cbag{k}=C;
% CPRPbag{k}=CPRP;
% 
% Caccuracy(k)=trace(C)/sum(sum(C));


clearvars -except All_Actions indices kk Caccuracy Cbag CPRPbag
end

MeanCaccuracy=mean(Caccuracy);
Finaccuracy=sprintf('%2.8f%%', (MeanCaccuracy)*100)
StdFA=std(Caccuracy)*100



