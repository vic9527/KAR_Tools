clear;clc
load MSRAction3DSkeletonReal3D_547

kk=10;%���ü���
A=[1:size(DataSet,2)]';
[M,N]=size(A);%�������ά��
indices = crossvalind('Kfold',A(1:M,N),kk); 
TE_DS={};
TR_DS={};
        for k=1:kk    %������֤k=10��10����������Ϊ���Լ�
            test = (indices == k); 
            test_ID=find(test==1);
            train_ID=find(test==0);
            TE_DS{k}= DataSet(test_ID);%������Լ�
            TR_DS{k}= DataSet(train_ID);%����ѵ����
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

%% All_Actions=struct;%mat()��ʽ����Ҫ��ʼ������cell{}����Ҫ������Ϊ�ա�������

%% ����ѵ��
tic
LSTM_predict={};
parfor k=1:kk
    
    %% [YPred, YAcc]=KAR_LSTM(X,Y,XTest,YTest,FVdim,Hunit,Nclass,drops,batchs,iters)
    [LSTM_predict{k},LSTM_acc(k)]=KAR_LSTM(TR_Actions_data{k},TR_Actions_label{k},TE_Actions_data{k},TE_Actions_label{k},60,300, 20, 30, 5, 1000);
 
end
toc
