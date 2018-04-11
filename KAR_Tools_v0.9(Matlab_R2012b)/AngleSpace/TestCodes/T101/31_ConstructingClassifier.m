% clear;clc;
warning off
format long g %�����ÿ�ѧ������


%����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



A=Lkp_all;
[AA,ps] = mapminmax(A',0,1); %%��׼��
A = AA';
labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(30,1);11*ones(30,1);12*ones(30,1);13*ones(29,1);14*ones(30,1);15*ones(20,1);16*ones(30,1);17*ones(30,1);18*ones(30,1);19*ones(30,1);20*ones(30,1)]; %%��������������ǩ

B=VK_LR_all;

[M,N]=size(A);%%�������ά��
indices = crossvalind('Kfold',A(1:M,N),10); 

 clearvars -except VK_LR_all Lkp_all b A B labels indices

for k=1:10    %%//������֤k=10��10����������Ϊ���Լ�
        test = (indices == k); %%//���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
        train = ~test;%%//train��Ԫ�صı��Ϊ��testԪ�صı�� 
        train_A=A(train,:);%%//�����ݼ��л��ֳ�train����������
        train_A_labels=labels(train,:);%%//����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
        test_A=A(test,:);%%//test������
        test_A_labels=labels(test,:);
        
        
        train_B=B(train,:);
        VK_LR=train_B;        
%��������5���ֹؽڵ������Ϣ����
VK_LR1st=[VK_LR(:,1),VK_LR(:,2),VK_LR(:,3)];
VK_LR2nd=[VK_LR(:,4),VK_LR(:,5),VK_LR(:,6),VK_LR(:,7)];
VK_LR3rd=[VK_LR(:,8),VK_LR(:,9),VK_LR(:,10),VK_LR(:,11)];
VK_LR4th=[VK_LR(:,12),VK_LR(:,13),VK_LR(:,14),VK_LR(:,15)];
VK_LR5th=[VK_LR(:,16),VK_LR(:,17),VK_LR(:,18),VK_LR(:,19)];
%��ȡ����5���ֹؽڵ�������������ֵ��
Max1st=max(VK_LR1st')';
Max2nd=max(VK_LR2nd')';
Max3rd=max(VK_LR3rd')';
Max4th=max(VK_LR4th')';
Max5th=max(VK_LR5th')';
%��ȡ����5���ֹؽڵ����������Ϊ1�С�
MaxVK_LR=[Max1st;Max2nd;Max3rd;Max4th;Max5th];

clearvars VK_LR1st VK_LR2nd VK_LR3rd VK_LR4th VK_LR5th Max1st Max2nd Max3rd Max4th Max5th

p = glmval(b,MaxVK_LR, 'logit');
clearvars P
P(p>=0.5)=1;
P(p<0.5)=0;
P=P';
mm=size(train_B,1);
Plabels = [P(1:mm),P(mm+1:mm*2),P(mm*2+1:mm*3),P(mm*3+1:mm*4),P(mm*4+1:mm*5)];

%תΪ2����
V_CT_temp=num2str(Plabels);  
V_CT_temp=char(strrep(cellstr(V_CT_temp),' ',''));
train_V_CT_bin = bin2dec(V_CT_temp);

clearvars p P mm Plabels V_CT_temp MaxVK_LR



       
        test_B=B(test,:);
        VK_LR=test_B;        
%��������5���ֹؽڵ������Ϣ����
VK_LR1st=[VK_LR(:,1),VK_LR(:,2),VK_LR(:,3)];
VK_LR2nd=[VK_LR(:,4),VK_LR(:,5),VK_LR(:,6),VK_LR(:,7)];
VK_LR3rd=[VK_LR(:,8),VK_LR(:,9),VK_LR(:,10),VK_LR(:,11)];
VK_LR4th=[VK_LR(:,12),VK_LR(:,13),VK_LR(:,14),VK_LR(:,15)];
VK_LR5th=[VK_LR(:,16),VK_LR(:,17),VK_LR(:,18),VK_LR(:,19)];
%��ȡ����5���ֹؽڵ�������������ֵ��
Max1st=max(VK_LR1st')';
Max2nd=max(VK_LR2nd')';
Max3rd=max(VK_LR3rd')';
Max4th=max(VK_LR4th')';
Max5th=max(VK_LR5th')';
%��ȡ����5���ֹؽڵ����������Ϊ1�С�
MaxVK_LR=[Max1st;Max2nd;Max3rd;Max4th;Max5th];

clearvars VK_LR1st VK_LR2nd VK_LR3rd VK_LR4th VK_LR5th Max1st Max2nd Max3rd Max4th Max5th

p = glmval(b,MaxVK_LR, 'logit');
clearvars P
P(p>=0.5)=1;
P(p<0.5)=0;
P=P';
mm=size(test_B,1);
Plabels = [P(1:mm),P(mm+1:mm*2),P(mm*2+1:mm*3),P(mm*3+1:mm*4),P(mm*4+1:mm*5)];

%תΪ2����
V_CT_temp=num2str(Plabels);  
V_CT_temp=char(strrep(cellstr(V_CT_temp),' ',''));
test_V_CT_bin = bin2dec(V_CT_temp);

clearvars p P mm Plabels V_CT_temp MaxVK_LR
 



%�Զ�����

%��һ��
CT_ID_Temp = find(train_V_CT_bin(:,1)==8); 
    train_TZJ=train_A(CT_ID_Temp,19:42);
    train_TZJ_labels=train_A_labels(CT_ID_Temp,:);
    train_TZJ=[train_TZJ;test_TZJ];
    train_TZJ_labels=[train_TZJ_labels;test_TZJ_labels];
    [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model1 = svmtrain(train_TZJ_labels,train_TZJ,cmdo);
        
  clearvars CT_ID_Temp train_TZJ train_TZJ_labels bestacc bestc bestg cmdo
  
CT_ID_Temp = find(test_V_CT_bin(:,1)==8); 
    test_TZJ=test_A(CT_ID_Temp,19:42);
    test_TZJ_labels=test_A_labels(CT_ID_Temp,:);          
        [predict_label, accuracy, decision_values] = svmpredict(test_TZJ_labels, test_TZJ, model1);

clearvars CT_ID_Temp test_TZJ test_TZJ_labels








%��һ��
CT_ID_Temp = find(train_V_CT_bin(:,1)~=24 & train_V_CT_bin(:,1)~=16 & train_V_CT_bin(:,1)~=15 & train_V_CT_bin(:,1)~=12 & train_V_CT_bin(:,1)~=2 & train_V_CT_bin(:,1)~=8);
    train_TZJ1=train_A(CT_ID_Temp,:);
    train_TZJ1_labels=train_A_labels(CT_ID_Temp,:);
    [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model1 = svmtrain(train_A_labels,train_A,cmdo);
        
  clearvars CT_ID_Temp  
  
CT_ID_Temp = find(test_V_CT_bin(:,1)~=24 & test_V_CT_bin(:,1)~=16 & test_V_CT_bin(:,1)~=15 & test_V_CT_bin(:,1)~=12 & test_V_CT_bin(:,1)~=2 & test_V_CT_bin(:,1)~=8);
    test_TZJ1=test_A(CT_ID_Temp,:);
    test_TZJ1_labels=test_A_labels(CT_ID_Temp,:);          
        [predict_label, accuracy, decision_values] = svmpredict(test_TZJ1_labels, test_TZJ1, model1);

clearvars CT_ID_Temp 








%  clearvars -except MaxVK_LR
        
        
        
        
        
end


