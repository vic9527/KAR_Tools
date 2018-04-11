%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vic Woo (vic.woo@qq.com)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



 %% 开启并行计算
 c=parcluster('local');
 c.NumWorkers=10;
 parpool(c,c.NumWorkers);
 clearvars c

%  parpool 
 
%% Step.0 -- 导入数据
clear all; close all; clc;
warning off 

t1=clock;



this_dir = pwd;
FunDir=genpath(this_dir);
addpath(FunDir);


MSRAction3D=['..\\..\\KAR_DataSets\\MSRAction3DSkeletonReal3D\\MSRAction3D_All\\'];
All_Actions=LoadData(MSRAction3D);

clearvars this_dir MSRAction3D



%% Step.1 -- 设置第一层标签

All_Actions=SetLabel(All_Actions);



%% Step.2 -- 分配训练集与测试集

  [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=Kfold_Struct(All_Actions, 10); %10折交叉验证数据集

%  [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=User_Independent_Verification(All_Actions, 10, 1); 


clearvars All_Actions



%% Step.3 -- 提取第一层特征：均值方差

% TR_FV1st=MeanVar_Cell(TR_data);
% TE_FV1st=MeanVar_Cell(TE_data);
TR_FV1st=P5C_MeanVar_Cell(TR_data);
TE_FV1st=P5C_MeanVar_Cell(TE_data);

%% 转成静态数据数据格式Mat(M,1+N):M行样本数，第1列为标签，其余N列特征数。
for i=1:size(TR_FV1st,2)
TR_FV1st_Mat{i}=[TR_Label1st{i},TR_FV1st{i}];
TE_FV1st_Mat{i}=[TE_Label1st{i},TE_FV1st{i}];
end



%% Step.4 -- 构造第一层分类器

C1st_Vaccuracy={};
C1st_Best={};
C1st_predict_Label={};
C1st_predict_accuracy={};
parfor k=1:size(TR_FV1st,2)
[C1st_Vaccuracy{k}, C1st_Best{k}, C1st_predict_Label{k}, C1st_predict_accuracy{k}]=C1st(TR_FV1st_Mat{k}, TE_FV1st_Mat{k});
end

CPRP={};
parfor k=1:size(TR_FV1st,2)
CPRP{k}=[TE_label{k},TE_Label1st{k},C1st_predict_Label{k},C1st_predict_Label{k}];%忘了当初CPRP的意思，姑且这么用。
CPRP1st_accuracy(k)=length(find(CPRP{k}(:,3)==CPRP{k}(:,2)))/length(CPRP{k}(:,2))*100;
end

 fprintf('第一层识别率为：%5.2f\n', CPRP1st_accuracy);
 fprintf('第一层的平均识别率为：%5.2f\n', mean(CPRP1st_accuracy));

% C1st_predict_Label=predict_Label;

 clearvars TR_FV1st_Mat TE_FV1st_Mat TR_FV1st TE_FV1st  i 
%% Step.5 -- 提取第二层特征：相对位置与相对偏移量

TR_FV2nd=RPRO_Cell(TR_data);
TE_FV2nd=RPRO_Cell(TE_data);

%% 转化成Struct格式
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

%% Step.6 -- 构造第二层分类器

%% 第一层分类下第一大类
Ckind=101; %% 第一层分类下的第几大类编号。
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

 %% 第一层分类下第二大类
Ckind=102; %% 第一层分类下的第几大类编号。
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

%% 第一层分类下第三大类
Ckind=103; %% 第一层分类下的第几大类编号。
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
%% Step.7 -- 汇总结果

parfor k=1:size(TR_Label1st,2)
    
CPRP{k}((CPRP{k}(:,4)==101),4)=C1_C2nd_predict_Label{k};
CPRP{k}((CPRP{k}(:,4)==102),4)=C2_C2nd_predict_Label{k};
CPRP{k}((CPRP{k}(:,4)==103),4)=C3_C2nd_predict_Label{k};

CPRP2nd_accuracy(k)=length(find(CPRP{k}(:,4)==CPRP{k}(:,1)))/length(CPRP{k}(:,1))*100;
end

 fprintf('第二层最终识别率为：%5.2f\n', CPRP2nd_accuracy);
 fprintf('第二层最终平均识别率为：%5.2f\n', mean(CPRP2nd_accuracy));


 
t2=clock;
RunTime=etime(t2,t1)/3600%计算整个程序运行时间

% dnb = datevec('2014-08-12 03:25:24');
% dna = datevec('2014-08-13 04:23:28');
% fix(etime(dna,dnb)/3600)


%% Step.8 -- 结果可视化

%已高度集成
CPRP_Vis(CPRP);


rmpath(FunDir); 
clearvars FunDir TR_Label1st this_dir
% save CPRP1 CPRP CPRP1st_accuracy CPRP2nd_accuracy



%% 关闭并行计算
 delete(gcp('nocreate'))
 
 
 