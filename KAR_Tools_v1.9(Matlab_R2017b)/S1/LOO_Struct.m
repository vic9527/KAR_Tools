function [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=LOO_Struct(DataSet)

% kk=10;%设置几折

A=[1:size(DataSet,2)]';
[M,N]=size(A);%计算矩阵维度
% indices = crossvalind('LeaveMOut',M,10); 
% [train,test]=crossvalind('LeaveMOut',M,10) ;
TE_DS={};
TR_DS={};
        for k=1:M    
            test = (A == k); 
            test_ID=find(test==1);
            train_ID=find(test==0);
            TE_DS{k}= DataSet(test_ID);%分配测试集
            TR_DS{k}= DataSet(train_ID);%分配训练集
             for jj=1:size(TR_DS{k},2)
                % jj
                 TR_label{k}(jj,1)=TR_DS{k}(jj).label; 
                 TR_data{k}{jj,1}=TR_DS{k}(jj).data;
                 TR_Label1st{k}(jj,1)=TR_DS{k}(jj).Label1st; 
             end  
             for jj=1:size(TE_DS{k},2)
                 TE_label{k}(jj,1)=TE_DS{k}(jj).label; 
                 TE_data{k}{jj,1}=TE_DS{k}(jj).data;
                 TE_Label1st{k}(jj,1)=TE_DS{k}(jj).Label1st; 
             end  
        end
clearvars A indices k M N test test_ID train_ID jj TE_DS TR_DS

end