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


CRA_X=k3-k7;
CRA_Y=k1-k2;
CRA_Z=cross(CRA_X,CRA_Y);

CRA_X_e=(CRA_X)./repmat(sqrt(sum(CRA_X.^2,2)),1,3);
CRA_Y_e=CRA_Y./repmat(sqrt(sum(CRA_Y.^2,2)),1,3);
CRA_Z_e=CRA_Z./repmat(sqrt(sum(CRA_Z.^2,2)),1,3);

WC2CRA_V1=k9-k2;
WC2CRA_V2=k11-k2;
WC2CRA_V3=k13-k2;
for i=1:Asize
    %i=3;
TM=[CRA_X_e(i,:);CRA_Y_e(i,:);CRA_Z_e(i,:)]; 
CRA_V1(i,:)=(TM*(WC2CRA_V1(i,:))')';
CRA_V2(i,:)=(TM*(WC2CRA_V2(i,:))')';
CRA_V3(i,:)=(TM*(WC2CRA_V3(i,:))')';
end



CRA_V1S=CRA_V1./[sqrt(sum(CRA_V1.^2,2)),sqrt(sum(CRA_V1.^2,2)),sqrt(sum(CRA_V1.^2,2))];
CRA_V2S=CRA_V2./[sqrt(sum(CRA_V2.^2,2)),sqrt(sum(CRA_V2.^2,2)),sqrt(sum(CRA_V2.^2,2))];
CRA_V3S=CRA_V3./[sqrt(sum(CRA_V3.^2,2)),sqrt(sum(CRA_V3.^2,2)),sqrt(sum(CRA_V3.^2,2))];


for i = 2:Asize
CRA_V1S_D(i-1,:)=abs(CRA_V1S(i,:)-CRA_V1S(1,:));
CRA_V2S_D(i-1,:)=abs(CRA_V2S(i,:)-CRA_V2S(1,:));
CRA_V3S_D(i-1,:)=abs(CRA_V3S(i,:)-CRA_V3S(1,:));
end


VRA1S_Mean=mean(CRA_V1S_D);
VRA1S_Var=var(CRA_V1S_D);
VRA2S_Mean=mean(CRA_V2S_D);
VRA2S_Var=var(CRA_V2S_D);
VRA3S_Mean=mean(CRA_V3S_D);
VRA3S_Var=var(CRA_V3S_D);

Part3_VRA(jj,:)=[VRA1S_Mean,VRA1S_Var,VRA2S_Mean,VRA2S_Var,VRA3S_Mean,VRA3S_Var];

 clearvars -except Bag_LR kk1 Part3_VRA

  end
  
  
  
 

clearvars -except Bag_LR kk1 Part3_VRA

 
 
A=Part3_VRA;
[AA,ps] = mapminmax(A',0,1); %%标准化
A = AA';
% % % labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(18,1);11*ones(30,1)]; %%给样本贴上类别标签

% labels= [1*ones(27,1);2*ones(27,1);2*ones(27,1);1*ones(26,1);2*ones(26,1);2*ones(26,1);2*ones(27,1);2*ones(30,1);2*ones(30,1);1*ones(18,1);2*ones(30,1)]; %%给样本贴上类别标签
labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(27,1);8*ones(30,1);9*ones(30,1);12*ones(18,1);17*ones(30,1)]; %%给样本贴上类别标签


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

