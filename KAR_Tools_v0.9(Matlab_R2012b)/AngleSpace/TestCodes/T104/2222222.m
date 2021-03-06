clear;clc;
warning off
format long g %不采用科学计数法

list=dir(['onearm\','*.txt']);
kk1=length(list);
 for ii=1:kk1
     str = strcat ('onearm\', list(ii).name);
     Bag_LR{ii}=load(str);
 end
 
 
 
  for jj=1:kk1
     
 
 Number=jj
% % %  jj=100;
 A=Bag_LR{jj};%载入数据
 

  
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

% % % A_MF = medfilt1(A); 
% % % A=A_MF;


for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Asize=size(A,1);

% % % %双肩向量
VS3=k2-k1;
VSL=k9-k2;
SCHC=k3-k7;

Part3_CV=(k2+k9+k11)/3-k2;
Part3_C=Part3_CV./[sqrt(sum(Part3_CV.^2,2)),sqrt(sum(Part3_CV.^2,2)),sqrt(sum(Part3_CV.^2,2))];
% % % % % % % % % % Part3_C=Part3_CV/sqrt(sum(Part3_CV.^2,2));%错的
% % % Part3_C=VSL./[sqrt(sum(VS3.^2,2)),sqrt(sum(VS3.^2,2)),sqrt(sum(VS3.^2,2))];

% % % P2_Larm=(k2+k9+k11)/3-k2;
% % % P2_Larm_Norm=sqrt(sum(P2_Larm.^2,2));
% % % P2_IA_X=acosd(P2_Larm(:,1)./P2_Larm_Norm);
% % % P2_IA_Y=acosd(P2_Larm(:,2)./P2_Larm_Norm);
% % % P2_IA_Z=acosd(P2_Larm(:,3)./P2_Larm_Norm);
% % % P2_IA=[P2_IA_X,P2_IA_Y,P2_IA_Z];
% % % Part3_C=P2_IA;

for i = 2:Asize
VSL_Z(i-1,:)=abs(Part3_C(i,:)-Part3_C(1,:));
end


VSL_Z_Mean=mean(VSL_Z);
VSL_Z_Var=var(VSL_Z);


Part3_VSL(jj,:)=[VSL_Z_Mean,VSL_Z_Var];

 clearvars -except Bag_LR kk1 Part3_VSL

  end
  
  
  
 



 
 
A=Part3_VSL;
[AA,ps] = mapminmax(A',0,1); %%标准化
A = AA';
% % % labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(18,1);11*ones(30,1)]; %%给样本贴上类别标签

% labels= [1*ones(27,1);2*ones(27,1);2*ones(27,1);1*ones(26,1);2*ones(26,1);2*ones(26,1);2*ones(27,1);2*ones(30,1);2*ones(30,1);1*ones(18,1);2*ones(30,1)]; %%给样本贴上类别标签
labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(27,1);8*ones(30,1);9*ones(30,1);10*ones(18,1);11*ones(30,1)]; %%给样本贴上类别标签


[M,N]=size(A);%%计算矩阵维度
% indices = crossvalind('LeaveMOut',A(1:M,N)); 
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
end
% 显示混淆矩阵
[C,order] = confusionmat(test_A_labels,predict_label);
PredictAA=[test_A_labels,predict_label];

 MeanK_accuracy=mean(K_accuracy)

