%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vic Woo (vic.woo@qq.com)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
warning off 
%% Step.1 -- ��������
addpath(genpath(pwd));
MSRAction3D=['..\\..\\KAR_DataSets\\MSRAction3DSkeletonReal3D\\MSRAction3D_557\\'];
All_Actions=LoadData(MSRAction3D);
clearvars this_dir MSRAction3D
All_Actions=SetLabel(All_Actions);
% 252 cross validation                     
       [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=User_Independent_Verification(All_Actions, 10, 5); 
%       [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=Kfold_Struct(All_Actions, 10); %10�۽�����֤���ݼ�
%    [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=HoldOut_Struct(All_Actions, 1/3); %ѡ��1/3Ϊ���Լ�
 
%    [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=LOO_Struct(All_Actions); %��һ��

%% Step.2 -- ��ȡ����
%��һ�㣺
TR_FV1st=P5C_Cell(TR_data);
TE_FV1st=P5C_Cell(TE_data);
% ת�ɾ�̬�������ݸ�ʽMat(M,1+N):M������������1��Ϊ��ǩ������N����������
for i=1:size(TR_FV1st,2)
TR_FV1st_Mat{i}=[TR_Label1st{i},TR_FV1st{i}];
TE_FV1st_Mat{i}=[TE_Label1st{i},TE_FV1st{i}];
end
%�ڶ���������
TR_FV2nd=RPRO_Cell(TR_data);
TE_FV2nd=RPRO_Cell(TE_data);
% ת����Struct��ʽ
TR_FV2nd_Struct={};
for i=1:size(TR_FV2nd,2)
 TR_FV2nd_Struct{i}=struct('Feature',TR_FV2nd{i},'label',0,'Label1st',0);
 for j=1:size(TR_FV2nd_Struct{i},1)
 TR_FV2nd_Struct{i}(j).label=TR_label{i}(j,1);
 TR_FV2nd_Struct{i}(j).Label1st=TR_Label1st{i}(j,1);
 end
end
TE_FV2nd_Struct={};
for i=1:size(TE_FV2nd,2)
 TE_FV2nd_Struct{i}=struct('Feature',TE_FV2nd{i},'label',0,'Label1st',0);
 for j=1:size(TE_FV2nd_Struct{i},1)
 TE_FV2nd_Struct{i}(j).label=TE_label{i}(j,1);
 TE_FV2nd_Struct{i}(j).Label1st=TE_Label1st{i}(j,1);
 end
end
% % % clearvars -except TR_FV1st_Mat TR_Label1st TE_FV1st_Mat TE_Label1st   TR_FV2nd_Struct TE_FV2nd_Struct TE_label TR_label All_Actions TR_data TE_data
%% Step.3 -- ���������
TT=size(TR_FV1st_Mat,2);
% ��һ�㣺ʹ��SVM������
for T=1:TT  
     fprintf('�����һ����������ʣ��%5.2f%%\n', (1-T/TT)*100);
            TrA=TR_FV1st_Mat{1,T};
            TeA=TE_FV1st_Mat{1,T};
            [AA,ps] = mapminmax([TrA(:,2:end)]',0,1); %%ѵ������׼��
            train_AA = AA';
            train_AA_labels=[TrA(:,1)];
            test_AA = [mapminmax('apply', [TeA(:,2:end)]', ps)]'; %%���Լ���׼��
            test_AA_labels=[TeA(:,1)]; 
            [bestacc,bestc,bestg] = SVMcgForClass(train_AA_labels,train_AA);
            cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
            model = svmtrain(train_AA_labels,train_AA,cmdo);
            [predict, accuracy, decision_values] = svmpredict(test_AA_labels, test_AA, model);

% % % % % %                    %���ɭ�ַ�������Random Forest��
% % % % % %                    TrD = TrA(:,2:end);
% % % % % %                    TrL = TrA(:,1);
% % % % % %                    TeD = TeA(:,2:end);
% % % % % %                    TeL = TeA(:,1);
% % % % % %                    RF_nTree=1000;
% % % % % %                    RF_Model = TreeBagger(RF_nTree,TrD, TrL);
% % % % % %                    RF_predict= str2num(char(predict(RF_Model,TeD)));
% % % % % %                    RF_accuracy=length(find(RF_predict==TeL))/length(TeL)
% % % % % %                    accuracy=RF_accuracy;
% % % % % %                    predict=RF_predict;
% % % % % %                    test_AA_labels=TeL;

            predict1st{T}=[test_AA_labels,predict];
            accuracy1st(T)=length(find(test_AA_labels==predict))/length(test_AA_labels);
            clearvars -except TR_FV1st_Mat TR_Label1st TE_FV1st_Mat TE_Label1st   TR_FV2nd_Struct TE_FV2nd_Struct T TT predict1st accuracy1st TE_label TR_label ...
                All_Actions TR_data TE_data

end
 fprintf('��һ��ʶ����Ϊ��%5.2f\n', accuracy1st);
 fprintf('��һ��ƽ��ʶ����Ϊ��%5.2f\n', mean(accuracy1st)); 
  fprintf('��һ�����ʶ����Ϊ��%5.2f\n', max(accuracy1st)); 
   fprintf('��һ����Сʶ����Ϊ��%5.2f\n', min(accuracy1st)); 
% �ڶ��㣺ʹ��SVM��HMM������
for T=1:TT
    T
    fprintf('����ڶ�����������ʣ��%5.2f%%\n', (1-T/TT)*100);
    if size(TE_FV2nd_Struct{1,T},1)~=0    
    Kind=101; %�ڶ����һ����
    Flen=size(TR_FV2nd_Struct{1, 1}(1).Feature,1)/5;
    FVrange=[Flen*(3-1)+1:Flen*3];
    TR_C2nd_C=TR_FV2nd_Struct{1,T}(TR_Label1st{1,T}==Kind);
    TE_C2nd_C=TE_FV2nd_Struct{1,T}(predict1st{1,T}(:,2)==Kind);
    HMM_Models = hmmTrain(TR_C2nd_C, FVrange);
    [accuracy, predict_label, true_label] = hmmTest(TE_C2nd_C, HMM_Models,FVrange);
    predict2nd_C1{T}=[true_label,predict_label];
    accuracy2nd_C1(T)=length(find(true_label == predict_label))/length(true_label);
    clearvars -except TR_FV1st_Mat TR_Label1st TE_FV1st_Mat TE_Label1st   TR_FV2nd_Struct TE_FV2nd_Struct T TT ... 
        predict1st accuracy1st ...
        predict2nd_C1 accuracy2nd_C1 predict2nd_C2 accuracy2nd_C2 predict2nd_C3 accuracy2nd_C3 TE_label TR_label ...
        All_Actions TR_data TE_data
%     Kind=102; %�ڶ���ڶ�����
%     Flen=size(TR_FV2nd_Struct{1, 1}(1).Feature,1)/5;
%     FVrange=[Flen*(2-1)+1:Flen*3];
%     TR_C2nd_C=TR_FV2nd_Struct{1,T}(TR_Label1st{1,T}==Kind);
%     TE_C2nd_C=TE_FV2nd_Struct{1,T}(predict1st{1,T}(:,2)==Kind);
%     HMM_Models = hmmTrain(TR_C2nd_C, FVrange);
%     [accuracy, predict_label, true_label] = hmmTest(TE_C2nd_C, HMM_Models,FVrange);
%     predict2nd_C2{T}=[true_label,predict_label];
%     accuracy2nd_C2(T)=length(find(true_label == predict_label))/length(true_label);
%     clearvars -except TR_FV1st_Mat TR_Label1st TE_FV1st_Mat TE_Label1st   TR_FV2nd_Struct TE_FV2nd_Struct T TT ... 
%         predict1st accuracy1st ...
%         predict2nd_C1 accuracy2nd_C1 predict2nd_C2 accuracy2nd_C2 predict2nd_C3 accuracy2nd_C3 TE_label TR_label ...
%         All_Actions TR_data TE_data
            Kind=102; %�ڶ���ڶ�����
%             FVrange=[5:10,20:25]; 
            Flen=(size(TR_FV1st_Mat{1},2)-1)/5;
            FVrange=[Flen*(2-1)+2:Flen*3+1]; %������+1
            TrA=TR_FV1st_Mat{1,T}(find(TR_Label1st{1,T}==Kind),:);
            TeA=TE_FV1st_Mat{1,T}(find(predict1st{1,T}(:,2)==Kind),:);
            [AA,ps] = mapminmax([TrA(:,FVrange)]',0,1); %%ѵ������׼��
            train_AA = AA';
            train_AA_labels=TR_label{1,T}(find(TR_Label1st{1,T}==Kind),:);
            test_AA = [mapminmax('apply', [TeA(:,FVrange)]', ps)]'; %%���Լ���׼��
            test_AA_labels=TE_label{1,T}(find(predict1st{1,T}(:,2)==Kind),:);
            [bestacc,bestc,bestg] = SVMcgForClass(train_AA_labels,train_AA);
            cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
            model = svmtrain(train_AA_labels,train_AA,cmdo);
            [predict, accuracy, decision_values] = svmpredict(test_AA_labels, test_AA, model);
            predict2nd_C2{T}=[test_AA_labels,predict];
            accuracy2nd_C2(T)=length(find(test_AA_labels==predict))/length(test_AA_labels);
        clearvars -except TR_FV1st_Mat TR_Label1st TE_FV1st_Mat TE_Label1st   TR_FV2nd_Struct TE_FV2nd_Struct T TT ... 
        predict1st accuracy1st ...
        predict2nd_C1 accuracy2nd_C1 predict2nd_C2 accuracy2nd_C2 predict2nd_C3 accuracy2nd_C3 TE_label TR_label ...
        All_Actions TR_data TE_data
    Kind=103; %�ڶ����������
    Flen=size(TR_FV2nd_Struct{1, 1}(1).Feature,1)/5;
    FVrange=[Flen*(5-1)+1:Flen*5];
    TR_C2nd_C=TR_FV2nd_Struct{1,T}(TR_Label1st{1,T}==Kind);
    TE_C2nd_C=TE_FV2nd_Struct{1,T}(predict1st{1,T}(:,2)==Kind);
    HMM_Models = hmmTrain(TR_C2nd_C, FVrange);
    [accuracy, predict_label, true_label] = hmmTest(TE_C2nd_C, HMM_Models,FVrange);
    predict2nd_C3{T}=[true_label,predict_label];
    accuracy2nd_C3(T)=length(find(true_label == predict_label))/length(true_label);
    clearvars -except TR_FV1st_Mat TR_Label1st TE_FV1st_Mat TE_Label1st   TR_FV2nd_Struct TE_FV2nd_Struct T TT ... 
        predict1st accuracy1st ...
        predict2nd_C1 accuracy2nd_C1 predict2nd_C2 accuracy2nd_C2 predict2nd_C3 accuracy2nd_C3 TE_label TR_label ...
        All_Actions TR_data TE_data
    end
end
%% Step.4 -- ���ս��
predict_label = {};
for k=1:size(TR_Label1st,2)
    predict_label{1,k}=[TE_label{1,k},predict1st{1,k},predict1st{1,k}(:,2)]; 
predict_label{1,k}((predict_label{1,k}(:,4)==101),4)=predict2nd_C1{1,k}(:,2);
predict_label{1,k}((predict_label{1,k}(:,4)==102),4)=predict2nd_C2{1,k}(:,2);
predict_label{1,k}((predict_label{1,k}(:,4)==103),4)=predict2nd_C3{1,k}(:,2);
Final_accuracy(k)=length(find(predict_label{1,k}(:,1)==predict_label{1,k}(:,4)))/length(predict_label{k}(:,1))*100;
end
 fprintf('��һ��ʶ����Ϊ��%5.2f\n', accuracy1st);
 fprintf('��һ��ƽ��ʶ����Ϊ��%5.2f\n', mean(accuracy1st)); 
  fprintf('��һ�����ʶ����Ϊ��%5.2f\n', max(accuracy1st)); 
   fprintf('��һ����Сʶ����Ϊ��%5.2f\n', min(accuracy1st)); 
   fprintf('##################################\n'); 
 fprintf('����ʶ����Ϊ��%5.2f\n', Final_accuracy);
 fprintf('����ƽ��ʶ����Ϊ��%5.2f\n', mean(Final_accuracy)); 
  fprintf('�������ʶ����Ϊ��%5.2f\n', max(Final_accuracy)); 
   fprintf('������Сʶ����Ϊ��%5.2f\n', min(Final_accuracy)); 
 fprintf('accuracy2nd_C1����ƽ��ʶ����Ϊ��%5.2f\n', mean(accuracy2nd_C1)); 
  fprintf('accuracy2nd_C1�������ʶ����Ϊ��%5.2f\n', max(accuracy2nd_C1)); 
   fprintf('accuracy2nd_C1������Сʶ����Ϊ��%5.2f\n', min(accuracy2nd_C1)); 
  fprintf('accuracy2nd_C2����ƽ��ʶ����Ϊ��%5.2f\n', mean(accuracy2nd_C2)); 
  fprintf('accuracy2nd_C2�������ʶ����Ϊ��%5.2f\n', max(accuracy2nd_C2)); 
   fprintf('accuracy2nd_C2������Сʶ����Ϊ��%5.2f\n', min(accuracy2nd_C2)); 
 fprintf('accuracy2nd_C3����ƽ��ʶ����Ϊ��%5.2f\n', mean(accuracy2nd_C3)); 
  fprintf('accuracy2nd_C3�������ʶ����Ϊ��%5.2f\n', max(accuracy2nd_C3)); 
   fprintf('accuracy2nd_C3������Сʶ����Ϊ��%5.2f\n', min(accuracy2nd_C3)); 
 rmpath(genpath(pwd));  