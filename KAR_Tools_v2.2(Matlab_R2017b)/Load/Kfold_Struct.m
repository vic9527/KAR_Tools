function [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=Kfold_Struct(DataSet, kk)

% kk=10;%���ü���

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