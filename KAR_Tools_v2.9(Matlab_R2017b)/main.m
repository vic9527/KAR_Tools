%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vic Woo (vic.woo@qq.com)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %% 开启并行计算
 c=parcluster('local');
 c.NumWorkers=10;
 parpool(c,c.NumWorkers);
 clearvars c
 
 
 
clear all; close all; clc;
warning off 
t1=clock;
addpath(genpath(pwd));
 %% Step.1 -- 导入数据并设置第一层标签以及分配训练集与测试集
MSRAction3D=['..\\..\\KAR_DataSets\\MSRAction3DSkeletonReal3D\\MSRAction3D_557\\'];
All_Actions=LoadData(MSRAction3D);
clearvars this_dir MSRAction3D
All_Actions=SetLabel(All_Actions);
%  [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=Kfold_Struct(All_Actions, 10); %10折交叉验证数据集
%  [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=User_Independent_Verification(All_Actions, 10, 5); 
[TR_DS, TE_DS]=UIVboost(All_Actions,10,5); %252tests
clearvars All_Actions



%% Step.2 -- 第一层OCU
TE_label={};
TE_Label1st={};
C1st_Vaccuracy={};
C1st_Best={};
C1st_predict_Label={};
C1st_predict_accuracy={};
CPRP={};
parfor k=1: size(TR_DS,2)     
  fprintf('正在进行第%d组的“第1层分类”，请稍等......\n', k);
  [ TE_label{k},TE_Label1st{k},C1st_Vaccuracy{k}, C1st_Best{k}, C1st_predict_Label{k}, C1st_predict_accuracy{k}]=C1st(TR_DS(k), TE_DS(k));
  CPRP{k}=[TE_label{k},TE_Label1st{k},C1st_predict_Label{k},C1st_predict_Label{k}];%忘了当初CPRP的意思，姑且这么用。
  CPRP1st_accuracy(k)=length(find(CPRP{k}(:,3)==CPRP{k}(:,2)))/length(CPRP{k}(:,2))*100;
 end   
 fprintf('第一层识别率为：%5.2f\n', CPRP1st_accuracy);
  fprintf('第一层的最大识别率为：%5.2f\n', max(CPRP1st_accuracy));
 fprintf('第一层的平均识别率为：%5.2f\n', mean(CPRP1st_accuracy));
  fprintf('第一层的最小识别率为：%5.2f\n', min(CPRP1st_accuracy));
 fprintf('第1层分类运行完毕，总共进行了%d组！\n', size(TR_DS,2) );




%% Step.3 -- 第二层OCU
C1_C2nd_Vaccuracy={};
C1_S2ndC_Best={};
C1_C2nd_predict_Label={};
C1_C2nd_predict_accuracy={};
C2_C2nd_Vaccuracy={};
C2_S2ndC_Best={};
C2_C2nd_predict_Label={};
C2_C2nd_predict_accuracy={};
C3_C2nd_Vaccuracy={};
C3_S2ndC_Best={};
C3_C2nd_predict_Label={};
C3_C2nd_predict_accuracy={};
parfor k=1:size(TR_DS,2)
     fprintf('正在进行第%d组的“第二层分类”，请稍等......\n', k);
%     第一层分类下第一大类
    [C1_C2nd_Vaccuracy{k}, C1_S2ndC_Best{k}, C1_C2nd_predict_Label{k}, C1_C2nd_predict_accuracy{k}]=...
        C2nd(TR_DS(k), TE_DS(k), C1st_predict_Label(k), 101); 
%     第一层分类下第二大类
    [C2_C2nd_Vaccuracy{k}, C2_S2ndC_Best{k}, C2_C2nd_predict_Label{k}, C2_C2nd_predict_accuracy{k}]=...
        C2nd(TR_DS(k), TE_DS(k), C1st_predict_Label(k), 102);
%     第一层分类下第三大类
    [C3_C2nd_Vaccuracy{k}, C3_S2ndC_Best{k}, C3_C2nd_predict_Label{k}, C3_C2nd_predict_accuracy{k}]=...
        C2nd(TR_DS(k), TE_DS(k), C1st_predict_Label(k), 103);
end
 
CPRP_Origin=CPRP;
for k=1:size(TR_DS,2)
 
CPRP{k}((CPRP{k}(:,4)==101),4)=C1_C2nd_predict_Label{k};
CPRP{k}((CPRP{k}(:,4)==102),4)=C2_C2nd_predict_Label{k};
CPRP{k}((CPRP{k}(:,4)==103),4)=C3_C2nd_predict_Label{k};

CPRP2nd_accuracy(k)=length(find(CPRP{k}(:,4)==CPRP{k}(:,1)))/length(CPRP{k}(:,1))*100;
end

 fprintf('第一层识别率为：%5.2f\n', CPRP1st_accuracy);
  fprintf('第一层的最大识别率为：%5.2f\n', max(CPRP1st_accuracy));
 fprintf('第一层的平均识别率为：%5.2f\n', mean(CPRP1st_accuracy));
  fprintf('第一层的最小识别率为：%5.2f\n', min(CPRP1st_accuracy));
 fprintf('第1层分类运行完毕，总共进行了%d组！\n', size(TR_DS,2) );
 fprintf('第二层最终识别率为：%5.2f\n', CPRP2nd_accuracy);
  fprintf('第二层最终最大识别率为：%5.2f\n', max(CPRP2nd_accuracy));
 fprintf('第二层最终平均识别率为：%5.2f\n', mean(CPRP2nd_accuracy));
 fprintf('第二层最终最小识别率为：%5.2f\n', min(CPRP2nd_accuracy));
 fprintf('第2层分类运行完毕，总共进行了%d组！\n', size(TR_DS,2) );

t2=clock;
RunTime=etime(t2,t1)/3600%计算整个程序运行时间




% Step.4 -- 结果可视化
%已高度集成
CPRP_Vis(CPRP);


rmpath(genpath(pwd)); 
clearvars FunDir TR_Label1st this_dir
% 关闭并行计算
 delete(gcp('nocreate'))
 
 
 