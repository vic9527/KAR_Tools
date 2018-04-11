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
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% 自行设计分类器
          %% 自行设计分类器
          %% 自行设计分类器
          %% 自行设计分类器
          %% 自行设计分类器
          %% 自行设计分类器
          %% 自行设计分类器
          %% 自行设计分类器
          %% 自行设计分类器
          %% 自行设计分类器
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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










