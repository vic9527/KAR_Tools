% % A=TZ_acp_R;
% % for kk=1:1
% %     KK_number(kk)=kk
% %     clearvars -except KK_number kk K_accuracy A TZ_acp_R;
% clc;clear;
% load('TZ_acp.mat');
% A=TZ_acp;
% % TZ_12act=[TZ_12act(:,1:15),TZ_12act(:,30:43),TZ_12act(:,44:57),TZ_12act(:,58:71)];
% % % % load A1;
% % % % A=[A4;A5;A6;A7;A8;A9;A10;A11;A12;A13];%%输出排列完成的1000*150的矩阵A与分割好的A4~A13
% %A=TZ_12act(:,2:end);
% [AA,ps] = mapminmax(A',0,1); %%标准化
% A = AA';
% 
%  labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(30,1);11*ones(30,1);12*ones(30,1);13*ones(29,1);14*ones(30,1);15*ones(20,1);16*ones(30,1);17*ones(30,1);18*ones(30,1);19*ones(30,1);20*ones(30,1)]; %%给样本贴上类别标签
% 
% %  labels0= [1*ones(50,1);2*ones(50,1);3*ones(50,1);4*ones(50,1);5*ones(48,1);6*ones(49,1);7*ones(50,1);8*ones(50,1);9*ones(50,1);10*ones(48,1);11*ones(49,1);12*ones(49,1)]; 
% 
% % labels1= [1*ones(27,1);2*ones(27,1);3*ones(26,1);4*ones(26,1);5*ones(30,1);6*ones(29,1);7*ones(30,1);8*ones(30,1)]; 
% %     labels2= [1*ones(27,1);2*ones(26,1);3*ones(28,1);4*ones(30,1);5*ones(30,1);6*ones(30,1);7*ones(30,1);8*ones(30,1)]; 
% %  labels3= [1*ones(26,1);2*ones(30,1);3*ones(20,1);4*ones(30,1);5*ones(30,1);6*ones(30,1);7*ones(30,1);8*ones(30,1)]; 
% 
% % labels=labels0;
% 
% 


[AA,ps] = mapminmax(Lkp_XL',0,1); %%标准化
Lkp_XL = AA';
XLlabels1= [1*ones(24,1);2*ones(24,1);3*ones(24,1);4*ones(23,1);5*ones(23,1);6*ones(23,1);7*ones(25,1);8*ones(27,1);9*ones(27,1);10*ones(27,1);11*ones(27,1);12*ones(27,1);13*ones(26,1);14*ones(27,1);15*ones(17,1);16*ones(27,1);17*ones(27,1);18*ones(27,1);19*ones(27,1);20*ones(27,1)]; %%给样本贴上类别标签

A=Lkp_XL(:,19:42);
labels=XLlabels1;
[M,N]=size(A);%%计算矩阵维度
indices = crossvalind('LeaveMOut',A(1:M,N)); 
indices = crossvalind('Kfold',A(1:M,N),10); 
for k=1:10    %%//交叉验证k=20，20个包轮流作为测试集
        test = (indices == k); %%//获得test集元素在数据集中对应的单元编号
        train = ~test;%%//train集元素的编号为非test元素的编号
        train_A=A(train,:);%%//从数据集中划分出train样本的数据
        train_A_labels=labels(train,:);%%//获得样本集的测试目标，在本例中是实际分类情况
        test_A=A(test,:);%%//test样本集
        test_A_labels=labels(test,:);
        [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_A_labels,train_A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);
        K_accuracy(k)=accuracy(1);
%         figure
%         plot(test_A_labels,'o');hold on;
%         plot(predict_label,'r*');hold on;
%         xlabel('Test sample','FontSize',12);
%         ylabel('Label of category','FontSize',12);
%         %legend('Actual classfication ','Prediction classfication');
%         title('Actual classfication and Prediction classfication of test sample ','FontSize',12);
end
 
% 显示混淆矩阵
[C,order] = confusionmat(test_A_labels,predict_label);

% % % C = cfmatrix(test_A_labels,predict_label);
% % %  K_accuracy(kk)=accuracy(1);

% end
% % 
% % MeanK_accuracy=mean(K_accuracy)


[AA,ps] = mapminmax(Lkp_XL',0,1); %%标准化
Lkp_XL = AA';
[AA,ps] = mapminmax(Lkp_CS',0,1); %%标准化
Lkp_CS = AA';
XLlabels1= [1*ones(24,1);2*ones(24,1);3*ones(24,1);4*ones(23,1);5*ones(23,1);6*ones(23,1);7*ones(25,1);8*ones(27,1);9*ones(27,1);10*ones(27,1);11*ones(27,1);12*ones(27,1);13*ones(26,1);14*ones(27,1);15*ones(17,1);16*ones(27,1);17*ones(27,1);18*ones(27,1);19*ones(27,1);20*ones(27,1)]; %%给样本贴上类别标签
CSlabels1= [1*ones(3,1);2*ones(3,1);3*ones(3,1);4*ones(3,1);5*ones(3,1);6*ones(3,1);7*ones(3,1);8*ones(3,1);9*ones(3,1);10*ones(3,1);11*ones(3,1);12*ones(3,1);13*ones(3,1);14*ones(3,1);15*ones(3,1);16*ones(3,1);17*ones(3,1);18*ones(3,1);19*ones(3,1);20*ones(3,1)]; %%给样本贴上类别标签

        [bestacc,bestc,bestg] = SVMcgForClass(XLlabels1,Lkp_XL(:,19:42));
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(XLlabels1,Lkp_XL(:,19:42),cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(CSlabels1, Lkp_CS(:,19:42), model);

[C,order] = confusionmat(CSlabels1,predict_label);




























