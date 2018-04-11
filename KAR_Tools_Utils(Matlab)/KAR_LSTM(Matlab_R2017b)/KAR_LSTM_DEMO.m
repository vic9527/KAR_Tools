clear;clc
load MSRAction3DSkeletonReal3D_547

kk=10;%设置几折
A=[1:size(DataSet,2)]';
[M,N]=size(A);%计算矩阵维度
indices = crossvalind('Kfold',A(1:M,N),kk); 
TE_DS={};
TR_DS={};
        for k=1:kk    %交叉验证k=10，10个包轮流作为测试集
            test = (indices == k); 
            test_ID=find(test==1);
            train_ID=find(test==0);
            TE_DS{k}= DataSet(test_ID);%分配测试集
            TR_DS{k}= DataSet(train_ID);%分配训练集
             for jj=1:size(TR_DS{k},2)
                 TR_Actions_label{k}(jj,1)=TR_DS{k}(jj).label; 
                 TR_Actions_data{k}{jj,1}=TR_DS{k}(jj).data;
             end  
             for jj=1:size(TE_DS{k},2)
                 TE_Actions_label{k}(jj,1)=TE_DS{k}(jj).label; 
                 TE_Actions_data{k}{jj,1}=TE_DS{k}(jj).data;
             end  
        end
clearvars A indices k M N test test_ID train_ID jj TE_DS TR_DS

%% All_Actions=struct;%mat()形式不需要初始化定义cell{}才需要“定义为空”操作。

%% 并行训练
tic
LSTM_predict={};
parfor k=1:kk
    
    %% [YPred, YAcc]=KAR_LSTM(X,Y,XTest,YTest,FVdim,Hunit,Nclass,drops,batchs,iters)
    [LSTM_predict{k},LSTM_acc(k)]=KAR_LSTM(TR_Actions_data{k},TR_Actions_label{k},TE_Actions_data{k},TE_Actions_label{k},60,300, 20, 30, 5, 1000);
 
end
toc
