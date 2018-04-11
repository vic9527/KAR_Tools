%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bin Liang (bin.liang.ty@gmail.com)
% Charles Sturt University
% Created:	Jan 2014
% Modified:	Jan 2014
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Step.1 -- Preparing for running
% clear variables
clear all; close all; clc;

% 1 -- display processing information, 0 -- just display final results
verbose = 1;  
% feature_dim = 3 * 2;   % feature dimensionality

% cross validate or not
is_cv = 0;  % 1 -- yes; 0 -- no
if is_cv == 0
    %     | T1 | T2 | T3
    % AS1 |  7 |  9 |  6
    % AS2 |  9 |  8 |  5
    % AS3 |  3 |  8 | 10
    best_Q = 9; % if no cross validataion, 5 states number is default
end

% add to path
this_dir = pwd;
addpath(genpath(this_dir));

% set dataset path
% data_path = 'E:\\T7\\AS\\';
% 
% % specify the paths to training and  test data
% test_subsets = {'test_one\\', 'test_two\\', 'cross_subject_test\\'};
% action_subsets = {'AS1\\', 'AS2\\', 'AS3\\'};
% 
% performed_dataset_path = [data_path test_subsets{3}, action_subsets{1}];
% training_data_dir = [performed_dataset_path, 'training\\skeleton\\'];
% test_data_dir = [performed_dataset_path, 'test\\skeleton\\'];
% 
% % % % % % % % % % training_data_dir = ['E:\T7\onearm\x\training\'];
% % % % % % % % % % test_data_dir = ['E:\T7\onearm\x\test\'];

% data_dir=training_data_dir;
% training_data_dir = ['E:\T7\onearm\training\'];
% test_data_dir = ['E:\T7\onearm\test\'];

All_data_dir = ['E:\T7\MSRAction3DSkeletonReal3D_112\'];
%% Draw skeleton on screen
%drawSkeleton(2, 2, 1, 1, 1, 1, training_data_dir);

%% Step.2 -- Load training data

fprintf('Loading all data:\n');
All_Actions = loadData1(All_data_dir, verbose);
fprintf('All data have been loaded.\n\n')

% % % % % % % % % % % % fprintf('Loading training data:\n');
% % % % % % % % % % % % TR_Actions = loadData1(training_data_dir, verbose);
% % % % % % % % % % % % 
% % % % % % % % % % % % % save('TR_Actions.mat', 'TR_Actions');
% % % % % % % % % % % % fprintf('Training data have been loaded.\n\n')

% % % % % % % % % % % % %% Step.3 -- Load test data
% % % % % % % % % % % % fprintf('Loading test data:\n');
% % % % % % % % % % % % TE_Actions = loadData1(test_data_dir, verbose);
% % % % % % % % % % % % 
% % % % % % % % % % % % %  save('TE_Actions.mat', 'TE_Actions')
% % % % % % % % % % % % fprintf('Test data have been loaded.\n\n');

% % % 
% ttTR=size(TR_Actions,2)
% for tt=1:ttTR
% ttTR_Actions(tt).Observations=TR_Actions(tt).Observations([37 38 39],:);
% ttTR_Actions(tt).name=TR_Actions(tt).name;
% ttTR_Actions(tt).label=TR_Actions(tt).label;
% end
% 
% ttTE=size(TE_Actions,2)
% for tt=1:ttTE
% ttTE_Actions(tt).Observations=TE_Actions(tt).Observations([37 38 39],:);
% ttTE_Actions(tt).name=TE_Actions(tt).name;
% ttTE_Actions(tt).label=TE_Actions(tt).label;
% end
% % % 

% ttTR_Actions=TR_Actions;
%  ttTR=size(ttTR_Actions,2)
% for tt=1:ttTR
% ttTR_Actions(tt).Observations=XLAng{tt}(1:9,:);
% end
% 
% ttTE_Actions=TE_Actions; 
% ttTE=size(ttTE_Actions,2)
% for tt=1:ttTE
% ttTE_Actions(tt).Observations=CSAng{tt}(1:9,:);
% end
% % 



clearvars Kaccuracy predictAA
kk=10;
 A=[1:size(All_Actions,2)]';
[M,N]=size(A);%%计算矩阵维度
% indices = crossvalind('LeaveMOut',A(1:M,N)); 
indices = crossvalind('Kfold',A(1:M,N),kk); 
for k=1:kk    %%//交叉验证k=10，10个包轮流作为测试集
  test = (indices == k); %%//获得test集元素在数据集中对应的单元编号
%   train = ~test;%%//train集元素的编号为非test元素的编号
  test_ID=find(test==1);
  train_ID=find(test==0);
 TE_Actions= All_Actions(test_ID);
 TR_Actions= All_Actions(train_ID);




%% Step.4 -- recognition using HMM
% parameters for HMM
% param.O = feature_dim;  % dimensionality of feature vector of each frame in an action sequence
param.O = 30;  % dimensionality of feature vector of each frame in an action sequence
param.Q = 6;   % number of states (default)
param.M = 6;    % number of mixtures
param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
param.max_iter = 5;    % number of iterations
param.verbose = verbose;

%% Step4.1 -- Cross Validation
if is_cv == 1
    candidates_Q = 3:10;
    num_folds = 5;  % number of folds
    best_Q = crossValidate(TR_Actions, candidates_Q, num_folds, param);%tt
end

%% Step4.2 -- Training
fprintf('HMM training.\n');
% best parameters for Q
param.Q = best_Q;   % number of states

% prescale training data
%[TR_Actions, scale_mu, scale_sigma] = prescale(TR_Actions);
% get hmm models
HMM_Models = hmmTrain(TR_Actions, param);%tt

%% Step4.3 -- Testing
fprintf('HMM testing.\n');
% prescale test data
%TE_Actions = prescale(TE_Actions, scale_mu, scale_sigma);
[accuracy, predict_label, true_label] = hmmTest(TE_Actions, HMM_Models);%tt
Kaccuracy(k)=accuracy;
% fprintf('accuracy: %.4f\n', accuracy);

 predictAA{k}=[predict_label, true_label];
% pause(0.5);beep; pause(0.5);beep; pause(0.5);beep;


end

MeanKaccuracy=mean(Kaccuracy)





