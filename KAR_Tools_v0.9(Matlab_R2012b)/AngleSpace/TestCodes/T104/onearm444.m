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





VRA1=k9-k2;
% VRA2=k11-k2;
% VRA3=k13-k2;
% VRA4=k11-k9;
% VRA5=k13-k9;
% VRA6=k13-k11;
VRA1S=VRA1./[sqrt(sum(VRA1.^2,2)),sqrt(sum(VRA1.^2,2)),sqrt(sum(VRA1.^2,2))];
% VRA2S=VRA2./[sqrt(sum(VRA2.^2,2)),sqrt(sum(VRA2.^2,2)),sqrt(sum(VRA2.^2,2))];
% VRA3S=VRA3./[sqrt(sum(VRA3.^2,2)),sqrt(sum(VRA3.^2,2)),sqrt(sum(VRA3.^2,2))];
% VRA4S=VRA4./[sqrt(sum(VRA4.^2,2)),sqrt(sum(VRA4.^2,2)),sqrt(sum(VRA4.^2,2))];
% VRA5S=VRA5./[sqrt(sum(VRA5.^2,2)),sqrt(sum(VRA5.^2,2)),sqrt(sum(VRA5.^2,2))];
% VRA6S=VRA6./[sqrt(sum(VRA6.^2,2)),sqrt(sum(VRA6.^2,2)),sqrt(sum(VRA6.^2,2))];

for i = 2:Asize
VRA1S_D(i-1,:)=VRA1S(i,:)-VRA1S(1,:);
% VRA2S_D(i-1,:)=abs(VRA2S(i,:)-VRA2S(1,:));
% VRA3S_D(i-1,:)=abs(VRA3S(i,:)-VRA3S(1,:));
% VRA4S_D(i-1,:)=abs(VRA4S(i,:)-VRA4S(1,:));
% VRA5S_D(i-1,:)=abs(VRA5S(i,:)-VRA5S(1,:));
% VRA6S_D(i-1,:)=abs(VRA6S(i,:)-VRA6S(1,:));
end


% VRAnS_D=[VRA1S_D,VRA2S_D,VRA3S_D,VRA4S_D,VRA5S_D,VRA6S_D];
% VRAnS_D=[VRA1S_D,VRA4S_D];

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
% VRA2S_Mean=mean(VRA2S_D);
% VRA2S_Var=var(VRA2S_D);
% VRA3S_Mean=mean(VRA3S_D);
% VRA3S_Var=var(VRA3S_D);
% VRA4S_Mean=mean(VRA4S_D);
% VRA4S_Var=var(VRA4S_D);
% VRA5S_Mean=mean(VRA5S_D);
% VRA5S_Var=var(VRA5S_D);
% VRA6S_Mean=mean(VRA6S_D);
% VRA6S_Var=var(VRA6S_D);



% Part3_VRA(jj,:)=[VRA1S_Mean,VRA1S_Var,VRA2S_Mean,VRA2S_Var,VRA3S_Mean,VRA3S_Var,VRA4S_Mean,VRA4S_Var,VRA5S_Mean,VRA5S_Var,VRA6S_Mean,VRA6S_Var];

 Part3_VRA(jj,:)=[VRA1S_Mean,VRA1S_Var];

 clearvars -except Bag_LR kk1 Part3_VRA

  end
  
  
  
 

clearvars -except Bag_LR kk1 Part3_VRA

 
 
A=Part3_VRA(2);
[AA,ps] = mapminmax(A',0,1); %%标准化
A = AA';
% % % labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(18,1);11*ones(30,1)]; %%给样本贴上类别标签

labels= [1*ones(27,1);2*ones(27,1);2*ones(27,1);1*ones(26,1);2*ones(26,1);2*ones(26,1);2*ones(27,1);2*ones(30,1);2*ones(30,1);1*ones(18,1);2*ones(30,1)]; %%给样本贴上类别标签
% labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(27,1);8*ones(30,1);9*ones(30,1);12*ones(18,1);17*ones(30,1)]; %%给样本贴上类别标签


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


 
 
 
 
 %聚类
 
%  T=clusterdata(Part3_VRA,0.9);








%随机获取150个点
% X = [randn(50,2)+ones(50,2);randn(50,2)-ones(50,2);randn(50,2)+[ones(50,1),-ones(50,1)]];
 X=A;
opts = statset('Display','final');
 
%调用Kmeans函数
%X N*P的数据矩阵
%Idx N*1的向量,存储的是每个点的聚类标号
%Ctrs K*P的矩阵,存储的是K个聚类质心位置
%SumD 1*K的和向量,存储的是类间所有点与该类质心点距离之和
%D N*K的矩阵，存储的是每个点与所有质心的距离;
 
[Idx,Ctrs,SumD,D] = kmeans(X,3,'Replicates',3,'Options',opts);
 
%画出聚类为1的点。X(Idx==1,1),为第一类的样本的第一个坐标；X(Idx==1,2)为第二类的样本的第二个坐标
plot(X(Idx==1,1),X(Idx==1,2),'r.','MarkerSize',14)
hold on
plot(X(Idx==2,1),X(Idx==2,2),'b.','MarkerSize',14)
hold on
plot(X(Idx==3,1),X(Idx==3,2),'g.','MarkerSize',14)
 
%绘出聚类中心点,kx表示是圆形
plot(Ctrs(:,1),Ctrs(:,2),'kx','MarkerSize',14,'LineWidth',4)
plot(Ctrs(:,1),Ctrs(:,2),'kx','MarkerSize',14,'LineWidth',4)
plot(Ctrs(:,1),Ctrs(:,2),'kx','MarkerSize',14,'LineWidth',4)
 
legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','NW')
 
Ctrs
SumD




X=Part3_VRA;
% 
% Step1 寻找变量之间的相似性
% 用pdist函数计算相似矩阵，有多种方法可以计算距离，进行计算之前最好先将数据用zscore函数进行标准化。
X2=zscore(X); %标准化数据
Y2=pdist(X2); %计算距离

% ?
% Step2 定义变量之间的连接
Z2=linkage(Y2);

% Step3 评价聚类信息
C2=cophenet(Z2,Y2); 
% //0.94698

% Step4 创建聚类，并作出谱系图
T=cluster(Z2,6);
H=dendrogram(Z2);


