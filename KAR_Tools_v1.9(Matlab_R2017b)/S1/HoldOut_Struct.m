function [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=HoldOut_Struct(DataSet, pp)

%pp=1/3;%设置多少为测试样本

A=[1:size(DataSet,2)]';
[M,N]=size(A);%计算矩阵维度
% indices = crossvalind('HoldOut',M,1/3); 
% groups=ismenber(label,1); %label为样本类别标签，生成一个逻辑矩阵groups,1用来逻辑判断筛选 
% [train, test] = crossvalind('holdOut',groups); %将groups分类，默认比例1:1，即P=0.5 
 [train, test]=crossvalind('HoldOut',M, pp) ;

            test_ID=find(test==1);
           % train_ID=find(test==0);
            train_ID=find(train==1);
            TE_DS{1}= DataSet(test_ID);%分配测试集
            TR_DS{1}= DataSet(train_ID);%分配训练集
             for jj=1:size(TR_DS{1},2)
                 TR_label{1}(jj,1)=TR_DS{1}(jj).label; 
                 TR_data{1}{jj,1}=TR_DS{1}(jj).data;
                 TR_Label1st{1}(jj,1)=TR_DS{1}(jj).Label1st; 
             end  
             for jj=1:size(TE_DS{1},2)
                 TE_label{1}(jj,1)=TE_DS{1}(jj).label; 
                 TE_data{1}{jj,1}=TE_DS{1}(jj).data;
                 TE_Label1st{1}(jj,1)=TE_DS{1}(jj).Label1st; 
             end  

clearvars A indices k M N test test_ID train_ID jj TE_DS TR_DS

end