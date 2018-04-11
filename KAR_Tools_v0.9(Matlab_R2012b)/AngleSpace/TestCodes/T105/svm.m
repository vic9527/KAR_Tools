
% clear;clc;

A=[Part_V;Part_V_Test];
% [AA,ps] = mapminmax(A',0,1); %%��׼��
% A = AA';
% % % labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(18,1);11*ones(30,1)]; %%��������������ǩ

% labels= [1*ones(27,1);1*ones(27,1);1*ones(27,1);1*ones(26,1);1*ones(26,1);1*ones(26,1);1*ones(27,1);1*ones(30,1);1*ones(30,1);2*ones(30,1);2*ones(30,1);[1*ones(6,1);2*ones(3,1);1*ones(6,1);2*ones(3,1);1*ones(3,1);2*ones(3,1);1*ones(3,1);2*ones(3,1)];3*ones(20,1);4*ones(29,1);4*ones(20,1);5*ones(30,1);1*ones(30,1);2*ones(30,1);6*ones(30,1);7*ones(22,1)]; %%��������������ǩ
labels= [labels;testlabels];

[M,N]=size(A);%%�������ά��
% indices = crossvalind('LeaveMOut',A(1:M,N)); 
indices = crossvalind('Kfold',A(1:M,N),10); 
for k=1:10    %%//������֤k=20��20����������Ϊ���Լ�
        test = (indices == k); %%//���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
        train = ~test;%%//train��Ԫ�صı��Ϊ��testԪ�صı��
        train_A=A(train,:);%%//�����ݼ��л��ֳ�train����������
        train_A_labels=labels(train,:);%%//����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
        test_A=A(test,:);%%//test������
        test_A_labels=labels(test,:);
        [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_A_labels,train_A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);
        K_accuracy(k)=accuracy(1);
end
% ��ʾ��������
[C,order] = confusionmat(test_A_labels,predict_label);
PredictAA=[test_A_labels,predict_label];









[AA,ps] = mapminmax(Lkp_XL',0,1); %%��׼��
Lkp_XL = AA';
XLlabels1= [1*ones(24,1);2*ones(24,1);3*ones(24,1);4*ones(23,1);5*ones(23,1);6*ones(23,1);7*ones(25,1);8*ones(27,1);9*ones(27,1);10*ones(27,1);11*ones(27,1);12*ones(27,1);13*ones(26,1);14*ones(27,1);15*ones(17,1);16*ones(27,1);17*ones(27,1);18*ones(27,1);19*ones(27,1);20*ones(27,1)]; %%��������������ǩ

A=Lkp_XL(:,19:42);
labels=XLlabels1;
[M,N]=size(A);%%�������ά��
indices = crossvalind('LeaveMOut',A(1:M,N)); 
indices = crossvalind('Kfold',A(1:M,N),10); 
for k=1:10    %%//������֤k=20��20����������Ϊ���Լ�
        test = (indices == k); %%//���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
        train = ~test;%%//train��Ԫ�صı��Ϊ��testԪ�صı��
        train_A=A(train,:);%%//�����ݼ��л��ֳ�train����������
        train_A_labels=labels(train,:);%%//����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
        test_A=A(test,:);%%//test������
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
 
% ��ʾ��������
[C,order] = confusionmat(test_A_labels,predict_label);



[AA,ps] = mapminmax(Lkp_XL',0,1); %%��׼��
Lkp_XL = AA';
[AA,ps] = mapminmax(Lkp_CS',0,1); %%��׼��
Lkp_CS = AA';
XLlabels1= [1*ones(24,1);2*ones(24,1);3*ones(24,1);4*ones(23,1);5*ones(23,1);6*ones(23,1);7*ones(25,1);8*ones(27,1);9*ones(27,1);10*ones(27,1);11*ones(27,1);12*ones(27,1);13*ones(26,1);14*ones(27,1);15*ones(17,1);16*ones(27,1);17*ones(27,1);18*ones(27,1);19*ones(27,1);20*ones(27,1)]; %%��������������ǩ
CSlabels1= [1*ones(3,1);2*ones(3,1);3*ones(3,1);4*ones(3,1);5*ones(3,1);6*ones(3,1);7*ones(3,1);8*ones(3,1);9*ones(3,1);10*ones(3,1);11*ones(3,1);12*ones(3,1);13*ones(3,1);14*ones(3,1);15*ones(3,1);16*ones(3,1);17*ones(3,1);18*ones(3,1);19*ones(3,1);20*ones(3,1)]; %%��������������ǩ

        [bestacc,bestc,bestg] = SVMcgForClass(XLlabels1,Lkp_XL(:,19:42));
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(XLlabels1,Lkp_XL(:,19:42),cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(CSlabels1, Lkp_CS(:,19:42), model);

[C,order] = confusionmat(CSlabels1,predict_label);




























