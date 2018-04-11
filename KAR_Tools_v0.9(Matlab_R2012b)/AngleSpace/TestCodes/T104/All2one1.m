clear;clc;
warning off
format long g %不采用科学计数法

list=dir(['MSRAction3DSkeletonReal3D_LR\','*.txt']);
kk=length(list);
 for ii=1:kk
     str = strcat ('MSRAction3DSkeletonReal3D_LR\', list(ii).name);
     Bag_LR{ii}=load(str);
 end
 
 labels= [1*ones(27,1);1*ones(27,1);1*ones(27,1);1*ones(26,1);1*ones(26,1);1*ones(26,1);1*ones(27,1);1*ones(30,1);1*ones(30,1);2*ones(30,1);2*ones(30,1);[1*ones(6,1);2*ones(3,1);1*ones(6,1);2*ones(3,1);1*ones(3,1);2*ones(3,1);1*ones(3,1);2*ones(3,1)];3*ones(20,1);4*ones(29,1);4*ones(20,1);5*ones(30,1);1*ones(30,1);2*ones(30,1);6*ones(30,1);7*ones(22,1)]; %%给样本贴上类别标签

 
 A=[1:kk]';
[M,N]=size(A);%%计算矩阵维度
indices = crossvalind('Kfold',A(1:M,N),10); 


clearvars -except  Bag_LR indices labels


for k=1:10    %%//交叉验证k=10，10个包轮流作为测试集
  test = (indices == k); %%//获得test集元素在数据集中对应的单元编号
%   train = ~test;%%//train集元素的编号为非test元素的编号
  test_ID=find(test==1);
  train_ID=find(test==0);
 Bag_Test= Bag_LR(test_ID);
 Bag_Train= Bag_LR(train_ID);
 Bag_Test_labels=labels(test_ID);
 Bag_Train_labels=labels(train_ID);
    
 kk1_Train=size(train_ID,1);
  for jj=1:kk1_Train
     
 
 Number=jj
 A=Bag_Train{jj};%载入数据
 

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


for i = 2:Asize
    Part1_V(i-1,:)=abs(Part1_C(i,:)-Part1_C(1,:));

    Part2_V(i-1,:)=abs(Part2_C(i,:)-Part2_C(1,:));

    Part3_V(i-1,:)=abs(Part3_C(i,:)-Part3_C(1,:));

    Part4_V(i-1,:)=abs(Part4_C(i,:)-Part4_C(1,:));

    Part5_V(i-1,:)=abs(Part5_C(i,:)-Part5_C(1,:));
end



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




  end
  
  Part_V_Train=[Part_V_Mean,Part_V_Var];
  
  clearvars -except  Bag_LR indices labels  test  test_ID  train_ID  Bag_Test  Bag_Train  Bag_Test_labels  Bag_Train_labels Part_V_Train  kk1_Train k K_accuracy
   
   
   
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %   
  kk1_Test=size(test_ID,1);
  for jj=1:kk1_Test
     
 
 Number=jj
 A=Bag_Test{jj};%载入数据
 

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


for i = 2:Asize
    Part1_V(i-1,:)=abs(Part1_C(i,:)-Part1_C(1,:));

    Part2_V(i-1,:)=abs(Part2_C(i,:)-Part2_C(1,:));

    Part3_V(i-1,:)=abs(Part3_C(i,:)-Part3_C(1,:));

    Part4_V(i-1,:)=abs(Part4_C(i,:)-Part4_C(1,:));

    Part5_V(i-1,:)=abs(Part5_C(i,:)-Part5_C(1,:));
end



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




  end
  
  
  
  
  
  Part_V_Test=[Part_V_Mean,Part_V_Var];
 
  clearvars -except  Bag_LR indices labels  test  test_ID  train_ID  Bag_Test  Bag_Train  Bag_Test_labels  Bag_Train_labels Part_V_Train Part_V_Test  kk1_Train  kk1_Test k K_accuracy
 
  
  


[AA,ps1] = mapminmax(Part_V_Train',0,1); %%标准化
Part_V_Train01 = AA';

Part_V_Test01 = (mapminmax('apply', Part_V_Test', ps1))'; %%标准化

    [bestacc,bestc,bestg] = SVMcgForClass(Bag_Train_labels,Part_V_Train01);
    cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
    model = svmtrain(Bag_Train_labels,Part_V_Train01,cmdo);
    [predict_label, accuracy, decision_values] = svmpredict(Bag_Test_labels, Part_V_Test01, model);
  K_accuracy(k)=accuracy(1);
[C,order] = confusionmat(Bag_Test_labels,predict_label);
PredictAA=[Bag_Test_labels,predict_label];
   
  
end 
 
 MeanK_accuracy=mean(K_accuracy)
 
 
 
 
 
 
 
 
 
 
 
 
 
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





VRA1=k9-k2;
VRA2=k11-k2;
VRA3=k13-k2;
VRA4=k11-k9;
VRA5=k13-k9;
VRA6=k13-k11;
VRA1S=VRA1./[sqrt(sum(VRA1.^2,2)),sqrt(sum(VRA1.^2,2)),sqrt(sum(VRA1.^2,2))];
VRA2S=VRA2./[sqrt(sum(VRA2.^2,2)),sqrt(sum(VRA2.^2,2)),sqrt(sum(VRA2.^2,2))];
VRA3S=VRA3./[sqrt(sum(VRA3.^2,2)),sqrt(sum(VRA3.^2,2)),sqrt(sum(VRA3.^2,2))];
VRA4S=VRA4./[sqrt(sum(VRA4.^2,2)),sqrt(sum(VRA4.^2,2)),sqrt(sum(VRA4.^2,2))];
VRA5S=VRA5./[sqrt(sum(VRA5.^2,2)),sqrt(sum(VRA5.^2,2)),sqrt(sum(VRA5.^2,2))];
VRA6S=VRA6./[sqrt(sum(VRA6.^2,2)),sqrt(sum(VRA6.^2,2)),sqrt(sum(VRA6.^2,2))];

for i = 2:Asize
VRA1S_D(i-1,:)=VRA1S(i,:)-VRA1S(1,:);
VRA2S_D(i-1,:)=abs(VRA2S(i,:)-VRA2S(1,:));
VRA3S_D(i-1,:)=abs(VRA3S(i,:)-VRA3S(1,:));
VRA4S_D(i-1,:)=abs(VRA4S(i,:)-VRA4S(1,:));
VRA5S_D(i-1,:)=abs(VRA5S(i,:)-VRA5S(1,:));
VRA6S_D(i-1,:)=abs(VRA6S(i,:)-VRA6S(1,:));
end


% % % % % % % % % % VRAnS_D=[VRA1S_D,VRA2S_D,VRA3S_D,VRA4S_D,VRA5S_D,VRA6S_D];
% % % % % % % % % % VRAnS_D=[VRA1S_D,VRA4S_D];

% % % % % % % % % % 
% % % % % % % % % % TT=30;
% % % % % % % % % % WW=size(VRAnS_D,2);
% % % % % % % % % % TZ_Cls_one=VRAnS_D;
% % % % % % % % % % XX=size(TZ_Cls_one,1);
% % % % % % % % % % nn=(1:(XX-1)/(TT-1):XX)';
% % % % % % % % % % xx=(1:XX)';
% % % % % % % % % % for pp=1:WW
% % % % % % % % % %     %pp=3;
% % % % % % % % % % TZ_Cls_spA=spap2(XX/2,3,xx,TZ_Cls_one(:,pp));
% % % % % % % % % % TZ_Cls_D_spA = fnval(TZ_Cls_spA,nn);
% % % % % % % % % % TZ_Cls_spone(:,pp)=TZ_Cls_D_spA;
% % % % % % % % % % % scatter(nn,TZ_Cls_spone(:,2))
% % % % % % % % % % % figure,fnplt(TZ_Cls_spA,'r');
% % % % % % % % % % % hold on;
% % % % % % % % % % end
% % % % % % % % % % % 

% % % % % % % % % % 
% % % % % % % % % % TZ_Cls_spone200=reshape(TZ_Cls_spone',[1,TT*WW]);
% % % % % % % % % % 
% % % % % % % % % % Part3_VRA(jj,:)=(TZ_Cls_spone200);




VRA1S_Mean=mean(VRA1S_D);
VRA1S_Var=var(VRA1S_D);
VRA2S_Mean=mean(VRA2S_D);
VRA2S_Var=var(VRA2S_D);
VRA3S_Mean=mean(VRA3S_D);
VRA3S_Var=var(VRA3S_D);
VRA4S_Mean=mean(VRA4S_D);
VRA4S_Var=var(VRA4S_D);
VRA5S_Mean=mean(VRA5S_D);
VRA5S_Var=var(VRA5S_D);
VRA6S_Mean=mean(VRA6S_D);
VRA6S_Var=var(VRA6S_D);



Part3_VRA(jj,:)=[VRA1S_Mean,VRA1S_Var,VRA2S_Mean,VRA2S_Var,VRA3S_Mean,VRA3S_Var,VRA4S_Mean,VRA4S_Var,VRA5S_Mean,VRA5S_Var,VRA6S_Mean,VRA6S_Var];


 clearvars -except Bag_LR kk1 Part3_VRA

  end
  
  
  
 

clearvars -except Bag_LR kk1 Part3_VRA

 
 
A=Part_V;
[AA,ps] = mapminmax(A',0,1); %%标准化
A = AA';
% % % labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(18,1);11*ones(30,1)]; %%给样本贴上类别标签

% labels= [1*ones(27,1);2*ones(27,1);2*ones(27,1);1*ones(26,1);2*ones(26,1);2*ones(26,1);2*ones(27,1);2*ones(30,1);2*ones(30,1);1*ones(18,1);2*ones(30,1)]; %%给样本贴上类别标签
% labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(27,1);8*ones(30,1);9*ones(30,1);12*ones(18,1);17*ones(30,1)]; %%给样本贴上类别标签


% [M,N]=size(A);%%计算矩阵维度
% % indices = crossvalind('LeaveMOut',A(1:M,N)); 
% indices = crossvalind('Kfold',A(1:M,N),10); 
% for k=1:10    %%//交叉验证k=20，20个包轮流作为测试集
%         test = (indices == k); %%//获得test集元素在数据集中对应的单元编号
%         train = ~test;%%//train集元素的编号为非test元素的编号
%         train_A=A(train,:);%%//从数据集中划分出train样本的数据
%         train_A_labels=labels(train,:);%%//获得样本集的测试目标，在本例中是实际分类情况
%         test_A=A(test,:);%%//test样本集
%         test_A_labels=labels(test,:);
        [bestacc,bestc,bestg] = SVMcgForClass(Bag_Train_labels,A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(Bag_Train_labels,A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);
%         K_accuracy(k)=accuracy(1);
% end
% % 显示混淆矩阵
[C,order] = confusionmat(test_A_labels,predict_label);
PredictAA=[test_A_labels,predict_label];

 MeanK_accuracy=mean(K_accuracy)


 
 
 
 

