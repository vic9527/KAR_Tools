clear;clc;
warning off
format long g %�����ÿ�ѧ������

%��һ�������߼�����b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

list=dir(['MSRAction3DSkeletonReal3D_LR\','*.txt']);
kk1=length(list);
 for ii=1:kk1
     str = strcat ('MSRAction3DSkeletonReal3D_LR\', list(ii).name);
     Bag_LR{ii}=load(str);
 end
 
 
 
  for jj=1:kk1
     
 
 Number=jj
% % %  jj=100;
 A=Bag_LR{jj};%��������
 

  
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Asize=size(A,1);

%���岿������
Part1_CV=(k3+k4+k7)/3-k7;
Part2_CV=(k1+k8+k10)/3-k1;
Part3_CV=(k2+k9+k11)/3-k2;
Part4_CV=(k5+k14+k16)/3-k5;
Part5_CV=(k6+k15+k17)/3-k6;

Part1_C=Part1_CV./[sqrt(sum(Part1_CV.^2,2)),sqrt(sum(Part1_CV.^2,2)),sqrt(sum(Part1_CV.^2,2))];
Part2_C=Part2_CV./[sqrt(sum(Part2_CV.^2,2)),sqrt(sum(Part2_CV.^2,2)),sqrt(sum(Part2_CV.^2,2))];
Part3_C=Part3_CV./[sqrt(sum(Part3_CV.^2,2)),sqrt(sum(Part3_CV.^2,2)),sqrt(sum(Part3_CV.^2,2))];
Part4_C=Part4_CV./[sqrt(sum(Part4_CV.^2,2)),sqrt(sum(Part4_CV.^2,2)),sqrt(sum(Part4_CV.^2,2))];
Part5_C=Part5_CV./[sqrt(sum(Part5_CV.^2,2)),sqrt(sum(Part5_CV.^2,2)),sqrt(sum(Part5_CV.^2,2))];

%���岿����������ÿ֡���һ֡�ĽǶ�
% % % for i = 2:Asize
% % %     Part1_V(i-1,:)=acosd(dot(Part1_C(i,:),Part1_C(1,:),2)/(norm(Part1_C(i,:))*norm(Part1_C(1,:))));
% % % end
% % % 
% % % for i = 2:Asize
% % %     Part2_V(i-1,:)=acosd(dot(Part2_C(i,:),Part2_C(1,:),2)/(norm(Part2_C(i,:))*norm(Part2_C(1,:))));
% % % end
% % % 
% % % for i = 2:Asize
% % %     Part3_V(i-1,:)=acosd(dot(Part3_C(i,:),Part3_C(1,:),2)/(norm(Part3_C(i,:))*norm(Part3_C(1,:))));
% % % end
% % % 
% % % for i = 2:Asize
% % %     Part4_V(i-1,:)=acosd(dot(Part4_C(i,:),Part4_C(1,:),2)/(norm(Part4_C(i,:))*norm(Part4_C(1,:))));
% % % end
% % % 
% % % for i = 2:Asize
% % %     Part5_V(i-1,:)=acosd(dot(Part5_C(i,:),Part5_C(1,:),2)/(norm(Part5_C(i,:))*norm(Part5_C(1,:))));
% % % end
% for i = 2:Asize
%     Part1_V(i-1,:)=acosd(dot(Part1_C(i,:),Part1_C(i-1,:),2)/(norm(Part1_C(i,:))*norm(Part1_C(i-1,:))));
% 
%     Part2_V(i-1,:)=acosd(dot(Part2_C(i,:),Part2_C(i-1,:),2)/(norm(Part2_C(i,:))*norm(Part2_C(i-1,:))));
% 
%     Part3_V(i-1,:)=acosd(dot(Part3_C(i,:),Part3_C(i-1,:),2)/(norm(Part3_C(i,:))*norm(Part3_C(i-1,:))));
% 
%     Part4_V(i-1,:)=acosd(dot(Part4_C(i,:),Part4_C(i-1,:),2)/(norm(Part4_C(i,:))*norm(Part4_C(i-1,:))));
% 
%     Part5_V(i-1,:)=acosd(dot(Part5_C(i,:),Part5_C(i-1,:),2)/(norm(Part5_C(i,:))*norm(Part5_C(i-1,:))));
% end
% for i = 2:Asize
%     Part1_V(i-1,:)=acosd(dot(Part1_C(i,:),Part1_C(1,:),2)/(norm(Part1_C(i,:))*norm(Part1_C(1,:))));
% 
%     Part2_V(i-1,:)=acosd(dot(Part2_C(i,:),Part2_C(1,:),2)/(norm(Part2_C(i,:))*norm(Part2_C(1,:))));
% 
%     Part3_V(i-1,:)=acosd(dot(Part3_C(i,:),Part3_C(1,:),2)/(norm(Part3_C(i,:))*norm(Part3_C(1,:))));
% 
%     Part4_V(i-1,:)=acosd(dot(Part4_C(i,:),Part4_C(1,:),2)/(norm(Part4_C(i,:))*norm(Part4_C(1,:))));
% 
%     Part5_V(i-1,:)=acosd(dot(Part5_C(i,:),Part5_C(1,:),2)/(norm(Part5_C(i,:))*norm(Part5_C(1,:))));
% end

for i = 2:Asize
    Part1_V(i-1,:)=abs(Part1_C(i,:)-Part1_C(1,:));

    Part2_V(i-1,:)=abs(Part2_C(i,:)-Part2_C(1,:));

    Part3_V(i-1,:)=abs(Part3_C(i,:)-Part3_C(1,:));

    Part4_V(i-1,:)=abs(Part4_C(i,:)-Part4_C(1,:));

    Part5_V(i-1,:)=abs(Part5_C(i,:)-Part5_C(1,:));
end

%ʶ�𾫶��½�=90%
% % % for i = 2:Asize
% % %     Part1_V(i-1,:)=max(abs(Part1_C(i,:)-Part1_C(1,:)));
% % % 
% % %     Part2_V(i-1,:)=max(abs(Part2_C(i,:)-Part2_C(1,:)));
% % % 
% % %     Part3_V(i-1,:)=max(abs(Part3_C(i,:)-Part3_C(1,:)));
% % % 
% % %     Part4_V(i-1,:)=max(abs(Part4_C(i,:)-Part4_C(1,:)));
% % % 
% % %     Part5_V(i-1,:)=max(abs(Part5_C(i,:)-Part5_C(1,:)));
% % % end


% % % for i = 2:Asize
% % %     Part1_V_Max(i-1,:)=max(abs(Part1_C(i,:)-Part1_C(1,:)));
% % % end







% % % 
% % % Part1_Cy=abs(Part1_C(:,2)-k7(:,2));
% % % Part2_Cxyz=abs(Part2_C-k7);
% % % Part3_Cxyz=abs(Part3_C-k7);
% % % Part4_Cxyz=abs(Part4_C-k7);
% % % Part5_Cxyz=abs(Part5_C-k7);
% % % 
% % % Part3_Cxyz_Max(jj,:)=max(var(Part3_Cxyz).*(size(Part3_Cxyz,1)-1));


Part1_V_Mean=mean(Part1_V);
Part2_V_Mean=mean(Part2_V);
Part3_V_Mean=mean(Part3_V);
Part4_V_Mean=mean(Part4_V);
Part5_V_Mean=mean(Part5_V);

Part1_V_Var=var(Part1_V);
Part2_V_Var=var(Part2_V);
Part3_V_Var=var(Part3_V);
Part4_V_Var=var(Part4_V);
Part5_V_Var=var(Part5_V);

Part_V_Mean(jj,:)=[Part1_V_Mean,Part2_V_Mean,Part3_V_Mean,Part4_V_Mean,Part5_V_Mean];

Part_V_Var(jj,:)=[Part1_V_Var,Part2_V_Var,Part3_V_Var,Part4_V_Var,Part5_V_Var];



% plot(Part5_V)


  clearvars -except Bag_LR kk1 Part_V_Mean Part_V_Var
 

  end
  
  Part_V=[Part_V_Mean,Part_V_Var];
 
   clearvars -except Part_V
  
  A=Part_V;
[AA,ps] = mapminmax(A',0,1); %%��׼��
A = AA';
% % % labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(18,1);11*ones(30,1)]; %%��������������ǩ

labels= [1*ones(27,1);1*ones(27,1);1*ones(27,1);1*ones(26,1);1*ones(26,1);1*ones(26,1);1*ones(27,1);1*ones(30,1);1*ones(30,1);2*ones(30,1);2*ones(30,1);[1*ones(6,1);2*ones(3,1);1*ones(6,1);2*ones(3,1);1*ones(3,1);2*ones(3,1);1*ones(3,1);2*ones(3,1)];3*ones(20,1);4*ones(29,1);4*ones(20,1);5*ones(30,1);1*ones(30,1);2*ones(30,1);6*ones(30,1);7*ones(22,1)]; %%��������������ǩ
% A=[Part_V_Train01;Part_V_Test01];
%  labels= [Bag_Train_labels];
 
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
        
%         [AA,ps] = mapminmax(train_A',0,1); %%��׼��
% train_A = AA';
% 
% test_A = (mapminmax('apply', test_A', ps))'; %%��׼��
        
        
        
        [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-t 2 ' '-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_A_labels,train_A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);
        K_accuracy(k)=accuracy(1);
end
% ��ʾ��������
[C,order] = confusionmat(test_A_labels,predict_label);
PredictAA=[test_A_labels,predict_label];

 MeanK_accuracy=mean(K_accuracy)

 
 
% % %   
% % %   
% % %   
% % %  
% % % labels3= [1*ones(27,1);1*ones(27,1);1*ones(27,1);1*ones(26,1);1*ones(26,1);1*ones(26,1);1*ones(27,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(20,1);0*ones(29,1);0*ones(20,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(22,1)]; %%��������������ǩ
% % % 
% % % 
% % % CP_Data=[labels3,Part_V_Var(:,3)];
% % % 
% % % 
% % % %�߼��ع����
% % % xl=CP_Data;
% % % x=xl(:,2);
% % % y=xl(:,1);
% % % b =glmfit(x,y,'binomial', 'link', 'logit');
% % % % clearvars -except CP_Data AllDataCS b
% % % 
% % % %%%���߼�����b
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 
% % % 
% % % p = glmval(b,CP_Data(:,2), 'logit');
% % % % clearvars P
% % % P(p>=0.5)=1;
% % % P(p<0.5)=0;
% % % P=P';
% % % %ʶ����
% % % C = cfmatrix(CP_Data(:,1),P);
% % % AC=trace(C)/sum(sum(C))
% % % 
% % % clearvars -except CP_Data AllDataCS b P
% % % 
% % % CP_Data1=[CP_Data, P];
% % % 
% % %  
 
 
 
 