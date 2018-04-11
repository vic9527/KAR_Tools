%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vic Woo (vic.woo@qq.com)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



 %% �������м���
 c=parcluster('local');
 c.NumWorkers=10;
 parpool(c,c.NumWorkers);
 clearvars c

%  parpool 
 
%% Step.0 -- ��������
clear all; close all; clc;
warning off 

t1=clock;



this_dir = pwd;
FunDir=genpath(this_dir);
addpath(FunDir);


MSRAction3D=['..\\..\\KAR_DataSets\\MSRAction3DSkeletonReal3D\\MSRAction3D_All\\'];
All_Actions=LoadData(MSRAction3D);

clearvars this_dir MSRAction3D



%% Step.1 -- ���õ�һ���ǩ

All_Actions=SetLabel(All_Actions);



%% Step.2 -- ����ѵ��������Լ�

  [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=Kfold_Struct(All_Actions, 10); %10�۽�����֤���ݼ�

%  [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=User_Independent_Verification(All_Actions, 10, 1); 


clearvars All_Actions



%% Step.3 -- ��ȡ��һ����������ֵ����

% TR_FV1st=MeanVar_Cell(TR_data);
% TE_FV1st=MeanVar_Cell(TE_data);
TR_FV1st=P5C_MeanVar_Cell(TR_data);
TE_FV1st=P5C_MeanVar_Cell(TE_data);

%% ת�ɾ�̬�������ݸ�ʽMat(M,1+N):M������������1��Ϊ��ǩ������N����������
for i=1:size(TR_FV1st,2)
TR_FV1st_Mat{i}=[TR_Label1st{i},TR_FV1st{i}];
TE_FV1st_Mat{i}=[TE_Label1st{i},TE_FV1st{i}];
end



%% Step.4 -- �����һ�������

C1st_Vaccuracy={};
C1st_Best={};
C1st_predict_Label={};
C1st_predict_accuracy={};
parfor k=1:size(TR_FV1st,2)
[C1st_Vaccuracy{k}, C1st_Best{k}, C1st_predict_Label{k}, C1st_predict_accuracy{k}]=C1st(TR_FV1st_Mat{k}, TE_FV1st_Mat{k});
end

CPRP={};
parfor k=1:size(TR_FV1st,2)
CPRP{k}=[TE_label{k},TE_Label1st{k},C1st_predict_Label{k},C1st_predict_Label{k}];%���˵���CPRP����˼��������ô�á�
CPRP1st_accuracy(k)=length(find(CPRP{k}(:,3)==CPRP{k}(:,2)))/length(CPRP{k}(:,2))*100;
end

 fprintf('��һ��ʶ����Ϊ��%5.2f\n', CPRP1st_accuracy);
 fprintf('��һ���ƽ��ʶ����Ϊ��%5.2f\n', mean(CPRP1st_accuracy));

% C1st_predict_Label=predict_Label;

 clearvars TR_FV1st_Mat TE_FV1st_Mat TR_FV1st TE_FV1st  i 
%% Step.5 -- ��ȡ�ڶ������������λ�������ƫ����

TR_FV2nd=RPRO_Cell(TR_data);
TE_FV2nd=RPRO_Cell(TE_data);

%% ת����Struct��ʽ
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

clearvars i j TE_data TR_data TE_FV2nd TR_FV2nd TE_label TR_label TE_Label1st 

%% Step.6 -- ����ڶ��������

%% ��һ������µ�һ����
Ckind=101; %% ��һ������µĵڼ������š�
TR_C2nd_C1={};
TE_C2nd_C1={};
C1_C2nd_Vaccuracy={};
C1_S2ndC_Best={};
C1_C2nd_predict_Label={};
C1_C2nd_predict_accuracy={};
parfor k=1:size(TR_Label1st,2)
    TR_C2nd_C1{k}=TR_FV2nd_Struct{k}(TR_Label1st{k}==Ckind);
    TE_C2nd_C1{k}=TE_FV2nd_Struct{k}(C1st_predict_Label{k}==Ckind);
 
    [C1_C2nd_Vaccuracy{k}, C1_S2ndC_Best{k}, C1_C2nd_predict_Label{k}, C1_C2nd_predict_accuracy{k}]=C2nd(TR_C2nd_C1{k}, TE_C2nd_C1{k}, Ckind); 
 
end

 %% ��һ������µڶ�����
Ckind=102; %% ��һ������µĵڼ������š�
TR_C2nd_C2={};
TE_C2nd_C2={};
C2_C2nd_Vaccuracy={};
C2_S2ndC_Best={};
C2_C2nd_predict_Label={};
C2_C2nd_predict_accuracy={};
parfor k=1:size(TR_Label1st,2)
    TR_C2nd_C2{k}=TR_FV2nd_Struct{k}(TR_Label1st{k}==Ckind);
    TE_C2nd_C2{k}=TE_FV2nd_Struct{k}(C1st_predict_Label{k}==Ckind);

    [C2_C2nd_Vaccuracy{k}, C2_S2ndC_Best{k}, C2_C2nd_predict_Label{k}, C2_C2nd_predict_accuracy{k}]=C2nd(TR_C2nd_C2{k}, TE_C2nd_C2{k}, Ckind);

end

%% ��һ������µ�������
Ckind=103; %% ��һ������µĵڼ������š�
TR_C2nd_C3={};
TE_C2nd_C3={};
C3_C2nd_Vaccuracy={};
C3_S2ndC_Best={};
C3_C2nd_predict_Label={};
C3_C2nd_predict_accuracy={};
parfor k=1:size(TR_Label1st,2)
    TR_C2nd_C3{k}=TR_FV2nd_Struct{k}(TR_Label1st{k}==Ckind);
    TE_C2nd_C3{k}=TE_FV2nd_Struct{k}(C1st_predict_Label{k}==Ckind);

    [C3_C2nd_Vaccuracy{k}, C3_S2ndC_Best{k}, C3_C2nd_predict_Label{k}, C3_C2nd_predict_accuracy{k}]=C2nd(TR_C2nd_C3{k}, TE_C2nd_C3{k}, Ckind);

end
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars Ckind k kk TR_C2nd_C1 TR_C2nd_C2 TR_C2nd_C3 TE_C2nd_C1 TE_C2nd_C2 TE_C2nd_C3 TR_FV2nd_Struct TE_FV2nd_Struct

% rmpath(FunDir); 
% clearvars FunDir
%% Step.7 -- ���ܽ��

parfor k=1:size(TR_Label1st,2)
    
CPRP{k}((CPRP{k}(:,4)==101),4)=C1_C2nd_predict_Label{k};
CPRP{k}((CPRP{k}(:,4)==102),4)=C2_C2nd_predict_Label{k};
CPRP{k}((CPRP{k}(:,4)==103),4)=C3_C2nd_predict_Label{k};

CPRP2nd_accuracy(k)=length(find(CPRP{k}(:,4)==CPRP{k}(:,1)))/length(CPRP{k}(:,1))*100;
end

 fprintf('�ڶ�������ʶ����Ϊ��%5.2f\n', CPRP2nd_accuracy);
 fprintf('�ڶ�������ƽ��ʶ����Ϊ��%5.2f\n', mean(CPRP2nd_accuracy));


 
t2=clock;
RunTime=etime(t2,t1)/3600%����������������ʱ��

% dnb = datevec('2014-08-12 03:25:24');
% dna = datevec('2014-08-13 04:23:28');
% fix(etime(dna,dnb)/3600)


%% Step.8 -- ������ӻ�

%�Ѹ߶ȼ���
CPRP_Vis(CPRP);


rmpath(FunDir); 
clearvars FunDir TR_Label1st this_dir
% save CPRP1 CPRP CPRP1st_accuracy CPRP2nd_accuracy



%% �رղ��м���
 delete(gcp('nocreate'))
 
 
 