clear;clc;
warning off
format long g %不采用科学计数法

%第一步：求逻辑参数b
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
 A=Bag_LR{jj};%载入数据
 

  
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Asize=size(A,1);

%求五部分重心
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

% PartC=[Part1_C,Part2_C,Part3_C,Part4_C,Part5_C];
% PartCD=diff(PartC);







for i = 2:Asize
    Part1_V(i-1,:)=sum((Part1_C(i,:)-Part1_C(1,:)).^2,2);

    Part2_V(i-1,:)=sum((Part2_C(i,:)-Part2_C(1,:)).^2,2);

    Part3_V(i-1,:)=sum((Part3_C(i,:)-Part3_C(1,:)).^2,2);

    Part4_V(i-1,:)=sum((Part4_C(i,:)-Part4_C(1,:)).^2,2);

    Part5_V(i-1,:)=sum((Part5_C(i,:)-Part5_C(1,:)).^2,2);
end

Part1_Cell{jj}=Part1_V;
Part2_Cell{jj}=Part2_V;
Part3_Cell{jj}=Part3_V;
Part4_Cell{jj}=Part4_V;
Part5_Cell{jj}=Part5_V;

% plot(Part1_V)
% hold on;
% plot(Part2_V)
% plot(Part3_V)
% plot(Part4_V)
% plot(Part5_V)
% 
% 
% 
% 
% Part1_V_Mean=mean(Part1_V);
% Part2_V_Mean=mean(Part2_V);
% Part3_V_Mean=mean(Part3_V);
% Part4_V_Mean=mean(Part4_V);
% Part5_V_Mean=mean(Part5_V);
% 
% Part1_V_Var=var(Part1_V);
% Part2_V_Var=var(Part2_V);
% Part3_V_Var=var(Part3_V);
% Part4_V_Var=var(Part4_V);
% Part5_V_Var=var(Part5_V);
% 
% Part_V_Mean(jj,:)=[Part1_V_Mean,Part2_V_Mean,Part3_V_Mean,Part4_V_Mean,Part5_V_Mean];
% 
% Part_V_Var(jj,:)=[Part1_V_Var,Part2_V_Var,Part3_V_Var,Part4_V_Var,Part5_V_Var];
% 
% 
% 
% % plot(Part5_V)
% 
% 
   clearvars -except Bag_LR kk1 Part1_Cell Part2_Cell Part3_Cell Part4_Cell Part5_Cell
%  

  end
  
  
  for jj=466:547
%   jj=100
figure,
   plot(Part1_Cell{jj},'r')
   hold on;
   plot(Part2_Cell{jj},'g')
   hold on;
   plot(Part3_Cell{jj},'b')
   hold on;
   plot(Part4_Cell{jj},'y')
   hold on;
   plot(Part5_Cell{jj},'k')
  end 
  
  plot(Part1_V_Var)
  
  
  
  
  
  
  
  
  
  
  
  Part_V=[Part_V_Mean,Part_V_Var];
 
   clearvars -except Part_V
  
  A=Part_V;
% [AA,ps] = mapminmax(A',0,1); %%标准化
% A = AA';
% % % labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(18,1);11*ones(30,1)]; %%给样本贴上类别标签

labels= [1*ones(27,1);1*ones(27,1);1*ones(27,1);1*ones(26,1);1*ones(26,1);1*ones(26,1);1*ones(27,1);1*ones(30,1);1*ones(30,1);2*ones(30,1);2*ones(30,1);[1*ones(6,1);2*ones(3,1);1*ones(6,1);2*ones(3,1);1*ones(3,1);2*ones(3,1);1*ones(3,1);2*ones(3,1)];3*ones(20,1);4*ones(29,1);4*ones(20,1);5*ones(30,1);1*ones(30,1);2*ones(30,1);6*ones(30,1);7*ones(22,1)]; %%给样本贴上类别标签
% A=[Part_V_Train01;Part_V_Test01];
%  labels= [Bag_Train_labels];
 
[M,N]=size(A);%%计算矩阵维度
% indices = crossvalind('LeaveMOut',A(1:M,N)); 
indices = crossvalind('Kfold',A(1:M,N),20); 
for k=1:20    %%//交叉验证k=20，20个包轮流作为测试集
        test = (indices == k); %%//获得test集元素在数据集中对应的单元编号
        train = ~test;%%//train集元素的编号为非test元素的编号
        train_A=A(train,:);%%//从数据集中划分出train样本的数据
        train_A_labels=labels(train,:);%%//获得样本集的测试目标，在本例中是实际分类情况
        test_A=A(test,:);%%//test样本集
        test_A_labels=labels(test,:);
        
        [AA,ps] = mapminmax(train_A',0,1); %%标准化
train_A = AA';

test_A = (mapminmax('apply', test_A', ps))'; %%标准化
        
        
        
        [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_A_labels,train_A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);
        K_accuracy(k)=accuracy(1);
end
% 显示混淆矩阵
[C,order] = confusionmat(test_A_labels,predict_label);
PredictAA=[test_A_labels,predict_label];

 MeanK_accuracy=mean(K_accuracy)

 
