clear;clc;
load vk2.mat;
load TZ_acp.mat


%��������5���ֹؽڵ������Ϣ����
vk1st=[vk(:,1),vk(:,2),vk(:,3)];
vk2nd=[vk(:,4),vk(:,5),vk(:,6),vk(:,7)];
vk3rd=[vk(:,8),vk(:,9),vk(:,10),vk(:,11)];
vk4th=[vk(:,12),vk(:,13),vk(:,14),vk(:,15)];
vk5th=[vk(:,16),vk(:,17),vk(:,18),vk(:,19)];
%��ȡ����5���ֹؽڵ�������������ֵ��
Max1st=max(vk1st')';
Max2nd=max(vk2nd')';
Max3rd=max(vk3rd')';
Max4th=max(vk4th')';
Max5th=max(vk5th')';
%��ȡ����5���ֹؽڵ����������Ϊ1�С�
MaxVK=[Max1st;Max2nd;Max3rd;Max4th;Max5th];

%��������5���ֹؽڵ��Ƿ����������߼�����
labels0= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(30,1);11*ones(30,1);12*ones(30,1);13*ones(29,1);14*ones(30,1);15*ones(20,1);16*ones(30,1);17*ones(30,1);18*ones(30,1);19*ones(30,1);20*ones(30,1)]; %%��������������ǩ
labels1= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);1*ones(29,1);0*ones(30,1);0*ones(20,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);1*ones(30,1)]; %%��������������ǩ
labels2= [1*ones(27,1);1*ones(27,1);1*ones(27,1);1*ones(26,1);1*ones(26,1);1*ones(26,1);1*ones(28,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(29,1);0*ones(30,1);0*ones(20,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1)]; %%��������������ǩ
labels3= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(6,1);1*ones(3,1);0*ones(6,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(29,1);0*ones(30,1);0*ones(20,1);1*ones(30,1);0*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(30,1)]; %%��������������ǩ
labels4= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(29,1);1*ones(30,1);1*ones(20,1);1*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1)]; %%��������������ǩ
labels5= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(29,1);0*ones(30,1);0*ones(20,1);1*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1)]; %%��������������ǩ
% Tlabels=[labels1,labels2,labels3,labels4,labels5];
labels=[labels1;labels2;labels3;labels4;labels5];

CP_Data=[labels,MaxVK];
clearvars -except CP_Data labels MaxVK vk Tlabels labels0 TZ_acp

id=randperm(2830,300);
% cs=CP_Data(id,:);
% CP_Data_Temp=CP_Data;
% CP_Data_Temp(id,:)=[];
% xl=CP_Data_Temp;

xl=CP_Data(id,:);
x=xl(:,2);
y=xl(:,1);
b =glmfit(x,y,'binomial', 'link', 'logit');
% p = glmval(b,cs(:,2), 'logit');
p = glmval(b,CP_Data(:,2), 'logit');
clearvars P
P(p>=0.5)=1;
P(p<0.5)=0;
P=P';

C = cfmatrix(CP_Data(:,1),P);
% C = cfmatrix(cs(:,1),P);
% [C,order] = confusionmat(labels,P)

% AC=sum(diag(C))/sum(C)
AC=trace(C)/sum(sum(C))

DB=[labels,P];

Plabels = [P(1:566),P(566+1:566*2),P(566*2+1:566*3),P(566*3+1:566*4),P(566*4+1:566*5)];

TZ_acp=[labels0,TZ_acp];

%תΪ2����
V_CT_temp=num2str(Plabels);  
V_CT_temp=char(strrep(cellstr(V_CT_temp),' ',''));
V_CT_bin = bin2dec(V_CT_temp);






CT_ID_Temp = find(V_CT_bin(:,1)==8); 
    TZJ=TZ_acp(CT_ID_Temp,:);
    TZJ1=TZJ(:,[1,20:43]);
A1=TZJ1(:,2:end);
[AA,ps] = mapminmax(A1',0,1); %%��׼��
A1 = AA';
id=randperm(228,100);
test_A=A1(id,:);
test_A_labels=TZJ1(id,1);
train_A=A1;
train_A_labels=TZJ1(:,1);
        [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_A_labels,train_A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);

    
    
    
CT_ID_Temp = find(V_CT_bin(:,1)==2); 
    TZJ=TZ_acp(CT_ID_Temp,:);
    TZJ2=TZJ(:,[1,13:16]);
    
    
    
    
    
    
CT_ID_Temp = find(V_CT_bin(:,1)==12); 
    TZJ=TZ_acp(CT_ID_Temp,:);
    TZJ3=TZJ(:,[1,5:12]);
    
    
    
    
CT_ID_Temp = find(V_CT_bin(:,1)==15); 
    TZJ4_PL=CT_ID_Temp;
CT_ID_Temp = find(V_CT_bin(:,1)==16);
    TZJ5_PL=CT_ID_Temp; 
CT_ID_Temp = find(V_CT_bin(:,1)==24);
    TZJ6_PL=CT_ID_Temp;   
    
    
    
CT_ID_Temp = find(V_CT_bin(:,1)~=24 & V_CT_bin(:,1)~=16 & V_CT_bin(:,1)~=15 & V_CT_bin(:,1)~=12 & V_CT_bin(:,1)~=2 & V_CT_bin(:,1)~=8);
    TZJ7=TZ_acp(CT_ID_Temp,:);
A1=TZJ7(:,2:end);
[AA,ps] = mapminmax(A1',0,1); %%��׼��
A1 = AA';
id=randperm(140,100);
test_A=A1(id,:);
test_A_labels=TZJ7(id,1);
train_A=A1;
train_A_labels=TZJ7(:,1);
        [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_A_labels,train_A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);

    
    
    
    
 
% % % 
% % % [M,N]=size(MaxVK);%%�������ά��
% % % indices = crossvalind('Kfold',MaxVK(1:M,N),30); 
% % % for k=1:30    %%//������֤k=100��100����������Ϊ���Լ�
% % % %       test_id = (indices == k); %%//���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
% % % %       train_id = ~test;%%//train��Ԫ�صı��Ϊ��testԪ�صı��
% % % train_id = (indices == k);
% % %         train_data=MaxVK(train_id,:);%%//�����ݼ��л��ֳ�train����������
% % %         train_labels=labels(train_id,:);%%//����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
% % % %         test_A=A(test,:);%%//test������
% % % %         test_A_labels=labels(test,:);
% % %    
% % % b =glmfit(train_data,train_labels,'binomial', 'link', 'logit');
% % % p = glmval(b,MaxVK, 'logit'); 
% % % P(p>=0.5)=1;
% % % P(p<0.5)=0;
% % % P=P';
% % % C = cfmatrix(labels,P);
% % % AC(k)=trace(C)/sum(sum(C))
% % % 
% % % clearvars -except labels MaxVK AC indices M N C
% % % 
% % % end
 




