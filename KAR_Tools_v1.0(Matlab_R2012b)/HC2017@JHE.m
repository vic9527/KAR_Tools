%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vic Woo (vic.woo@qq.com)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Step.0 -- Preparing for running
%% clear variables
clear all; close all; clc;
            
%% add to path
this_dir = pwd;
addpath(genpath(this_dir));
verbose = 1;  
All_data_dir = ['..\..\..\VD\MSRAction3D\MSRAction3DSkeletonReal3D(547)\MSRAction3DSkeletonReal3D_547\'];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.1.0 -- Load all data
fprintf('Loading all data:\n');
All_Actions = loadData(All_data_dir,verbose);
fprintf('All data have been loaded.\n\n')
clearvars Kaccuracy predictAA verbose All_data_dir

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.2.0 -- Set the first level label
 for jj=1:size(All_Actions,2)
            All_Actions(jj).Label1st=All_Actions(jj).label;
            All_Actions(jj).Label1st(All_Actions(jj).Label1st==1|All_Actions(jj).Label1st==2|All_Actions(jj).Label1st==3|All_Actions(jj).Label1st==4|All_Actions(jj).Label1st==5|All_Actions(jj).Label1st==6|All_Actions(jj).Label1st==7|All_Actions(jj).Label1st==8|All_Actions(jj).Label1st==9|All_Actions(jj).Label1st==17|All_Actions(jj).Label1st==12)=101;
            All_Actions(jj).Label1st(All_Actions(jj).Label1st==10|All_Actions(jj).Label1st==11|All_Actions(jj).Label1st==18)=102;
            All_Actions(jj).Label1st(All_Actions(jj).Label1st==14|All_Actions(jj).Label1st==15)=103;      
 end  
       %%  special case:
            All_Actions(313).Label1st=102;  
             All_Actions(314).Label1st=102;  
              All_Actions(315).Label1st=102;  
               All_Actions(322).Label1st=102;  
                All_Actions(323).Label1st=102;  
                 All_Actions(324).Label1st=102;  
                  All_Actions(328).Label1st=102;  
                   All_Actions(329).Label1st=102;  
                    All_Actions(330).Label1st=102;  
                     All_Actions(334).Label1st=102;  
                      All_Actions(335).Label1st=102;  
                       All_Actions(336).Label1st=102;  
                       
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.3.0 -- Ten times ten fold cross validation                     
TT=10;%设置几次
for T=1:TT
T

kk=10;%设置几折
A=[1:size(All_Actions,2)]';
[M,N]=size(A);%计算矩阵维度
indices = crossvalind('Kfold',A(1:M,N),kk); 
clearvars -except All_Actions indices kk T TT  MeanCaccuracy Finaccuracy StdFA CaccuracyBag TTCaccuracy TTCbag TTCPRPbag
        for k=1:kk    %交叉验证k=10，10个包轮流作为测试集
            test = (indices == k); %获得test集元素在数据集中对应的单元编号
            test_ID=find(test==1);
            train_ID=find(test==0);
            TE_Actions= All_Actions(test_ID);%分配测试集
            TR_Actions= All_Actions(train_ID);%分配训练集
            
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% Step.3.1 --1st Level
            for jj=1:size(TR_Actions,2)
               %% 提取均值和方差-开始
                 TP_Mean(jj,:)=mean([TR_Actions(jj).Feature1st(:,2:end)]');
                 TP_Var(jj,:)=var([TR_Actions(jj).Feature1st(:,2:end)]'); 
            end
                 TR_TP=[TP_Mean,TP_Var];     
                 clearvars TP_Mean TP_Var

            for jj=1:size(TE_Actions,2)
                 TP_Mean(jj,:)=  mean([TE_Actions(jj).Feature1st(:,2:end)]');
                 TP_Var(jj,:)=  var([TE_Actions(jj).Feature1st(:,2:end)]'); 
            end   
                 TE_TP=[TP_Mean,TP_Var];     
                 clearvars TP_Mean TP_Var
             %% 提取均值和方差-结束
             
          %% 使用SVM分类器
            [AA,ps] = mapminmax(TR_TP',0,1); %%训练集标准化
            train_AA = AA';
            train_AA_labels=[TR_Actions.Label1st]';
            test_AA = (mapminmax('apply', TE_TP', ps))'; %%测试集标准化
            test_AA_labels=[TE_Actions.Label1st]';  

            test_Real_labels=[TE_Actions.label]';  

            [bestacc,bestc,bestg] = SVMcgForClass(train_AA_labels,train_AA);
            cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
            model = svmtrain(train_AA_labels,train_AA,cmdo);
            [predict_Label1st, accuracy, decision_values] = svmpredict(test_AA_labels, test_AA, model);
            PredictAA=[test_AA_labels,predict_Label1st];
            clearvars TR_TP TE_TP

            CPRP=[test_Real_labels,PredictAA,predict_Label1st];%忘了当初CPRP的意思，姑且这么用。




          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% Step.3.2 --2nd Level
            T
            k
             %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             %% Step.3.2.1 第一个大类使用HMM
               TR_Actions1C=TR_Actions([TR_Actions.Label1st]'==101);
               TE_Actions1C=TE_Actions(predict_Label1st==101);
               if size(TE_Actions1C,2)~=0
                  param.O = 6;  % dimensionality of feature vector of each frame in an action sequence
                  param.Q = 6;   % number of states (default)
                  param.M = 6;    % number of mixtures
                  param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
                  param.max_iter = 10;    % number of iterations
                  param.verbose = 1;

                 % Training
                 fprintf('HMM training.\n');
                 param.Q = 9;   % number of states
                 HMM_Models = hmmTrain1C(TR_Actions1C, param);%tt

                 % Testing
                 fprintf('HMM testing.\n');
                 % prescale test data
                 [accuracy, predict_label1C, true_label] = hmmTest1C(TE_Actions1C, HMM_Models);%tt

                 predictAA1C=[true_label,predict_label1C];
                 fprintf('accuracy: %.4f\n', accuracy);
                 CPRP((CPRP(:,4)==101),4)=predict_label1C;
              end

            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Step.3.2.2 第二个大类使用SVM
              TR_Actions2C=TR_Actions([TR_Actions.Label1st]'==102);
              TE_Actions2C=TE_Actions(predict_Label1st==102);

              if size(TE_Actions2C,2)~=0
                 for jj=1:size(TR_Actions2C,2)
                     TP_Mean(jj,:)=  mean([TR_Actions2C(jj).Feature1st(4:9,2:end)]');
                     TP_Var(jj,:)=  var([TR_Actions2C(jj).Feature1st(4:9,2:end)]'); 
                 end
                 TR_TP=[TP_Mean,TP_Var];     
                 clearvars TP_Mean TP_Var
    
                 for jj=1:size(TE_Actions2C,2)
                     TP_Mean(jj,:)=  mean([TE_Actions2C(jj).Feature1st(4:9,2:end)]');
                     TP_Var(jj,:)=  var([TE_Actions2C(jj).Feature1st(4:9,2:end)]'); 
                 end   
                 TE_TP=[TP_Mean,TP_Var];     
                 clearvars TP_Mean TP_Var

                 [AA,ps] = mapminmax(TR_TP',0,1); 
                 train_AA = AA';
                 train_AA_labels=[TR_Actions2C.label]';
                 test_AA = (mapminmax('apply', TE_TP', ps))'; 
                 test_AA_labels=[TE_Actions2C.label]';  

                 [bestacc,bestc,bestg] = SVMcgForClass(train_AA_labels,train_AA);
                 cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
                 model = svmtrain(train_AA_labels,train_AA,cmdo);
                 [predict_label2C, accuracy, decision_values] = svmpredict(test_AA_labels, test_AA, model);
                 PredictAA2C=[test_AA_labels,predict_label2C];
                 clearvars TR_TP TE_TP
				 
                 CPRP((CPRP(:,4)==102),4)=predict_label2C;
              end

            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Step.3.2.3 第三个大类使用HMM
              TR_Actions3C=TR_Actions([TR_Actions.Label1st]'==103);
              TE_Actions3C=TE_Actions(predict_Label1st==103);

              if size(TE_Actions3C,2)~=0
                 param.O = 6;  % dimensionality of feature vector of each frame in an action sequence
                 param.Q = 6;   % number of states (default)
                 param.M = 6;    % number of mixtures
                 param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
                 param.max_iter = 10;    % number of iterations
                 param.verbose = 1;

                 % Training
                 fprintf('HMM training.\n');
                 param.Q = 9;   % number of states
                 HMM_Models = hmmTrain3C(TR_Actions3C, param);%tt

                 % Testing
                 fprintf('HMM testing.\n');
                 % prescale test data
                 [accuracy, predict_label3C, true_label] = hmmTest3C(TE_Actions3C, HMM_Models);%tt
  
                 predictAA3C=[true_label,predict_label3C];
                 fprintf('accuracy: %.4f\n', accuracy);
                 CPRP((CPRP(:,4)==103),4)=predict_label3C;
              end

          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% Step.3.X Final Result of ten fold cross validation
           [C,order] = confusionmat(CPRP(:,1),CPRP(:,4));
           Cbag{k}=C;
           CPRPbag{k}=CPRP;
           Caccuracy(k)=trace(C)/sum(sum(C));
           clearvars -except All_Actions indices kk Caccuracy Cbag CaccuracyBag CPRPbag T TT MeanCaccuracy Finaccuracy StdFA TTCaccuracy TTCbag TTCPRPbag CCCCC
        end
  
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.3.Z -- Final Result of ten times cross validation   
TTCaccuracy(:,T)=Caccuracy';%每列为一次十折交叉验证结果
TTCbag(:,T)=Cbag';
TTCPRPbag(:,T)=CPRPbag';

end
             
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.4.0 -- Final Result
MeanCaccuracy=mean(TTCaccuracy);
StdFA=std(TTCaccuracy);
Finaccuracy=sprintf('%2.8f%%\n', (MeanCaccuracy).*100)
FinStdFA=sprintf('%2.8f%%\n', (StdFA).*100)
TtimesMeanCaccuracy=mean(MeanCaccuracy)
TtimesStdFAsmean=mean(StdFA)










