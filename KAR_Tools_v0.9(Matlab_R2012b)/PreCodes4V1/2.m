clear;clc;
warning off
format long g %不采用科学计数法

%第一步：求逻辑参数b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

list=dir(['MSRAction3DSkeletonReal3D_112\','*.txt']);
kk1=length(list);
 for ii=1:kk1
     str = strcat ('MSRAction3DSkeletonReal3D_112\', list(ii).name);
     Bag_LR{ii}=load(str);
 end
 
 
 
  for jj=1:kk1
     
 
 Number=jj
% % %  jj=3;
 A=Bag_LR{jj};%载入数据
 

  
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Asize=size(A,1);

%五终端相对坐标
TP_len=k2-k1;
TP_lenNorm=mean(sqrt(sum(TP_len.^2,2)));


TP1=(k20-k7)/TP_lenNorm;
TP2=(k12-k1)/TP_lenNorm;
TP3=(k13-k2)/TP_lenNorm;
TP4=(k18-k5)/TP_lenNorm;
TP5=(k19-k6)/TP_lenNorm;


for i = 2:Asize
    TP1_V(i-1,:)=sum((TP1(i,:)-TP1(1,:)).^2,2);

    TP2_V(i-1,:)=sum((TP2(i,:)-TP2(1,:)).^2,2);

    TP3_V(i-1,:)=sum((TP3(i,:)-TP3(1,:)).^2,2);

    TP4_V(i-1,:)=sum((TP4(i,:)-TP4(1,:)).^2,2);

    TP5_V(i-1,:)=sum((TP5(i,:)-TP5(1,:)).^2,2);
end

% % % for i = 2:Asize
% % %     TP1_V(i-1,:)=sqrt(sum((TP1(i,:)-TP1(1,:)).^2,2))/sqrt(sum(TP1(1,:).^2,2));
% % % 
% % %     TP2_V(i-1,:)=sqrt(sum((TP2(i,:)-TP2(1,:)).^2,2))/sqrt(sum(TP2(1,:).^2,2));
% % % 
% % %     TP3_V(i-1,:)=sqrt(sum((TP3(i,:)-TP3(1,:)).^2,2))/sqrt(sum(TP3(1,:).^2,2));
% % % 
% % %     TP4_V(i-1,:)=sqrt(sum((TP4(i,:)-TP4(1,:)).^2,2))/sqrt(sum(TP4(1,:).^2,2));
% % % 
% % %     TP5_V(i-1,:)=sqrt(sum((TP5(i,:)-TP5(1,:)).^2,2))/sqrt(sum(TP5(1,:).^2,2));
% % % end

TP1_Cell{jj}=TP1_V;
TP2_Cell{jj}=TP2_V;
TP3_Cell{jj}=TP3_V;
TP4_Cell{jj}=TP4_V;
TP5_Cell{jj}=TP5_V;


   clearvars -except Bag_LR kk1 TP1_Cell TP2_Cell TP3_Cell TP4_Cell TP5_Cell
   
  end
  
% % % % % %   for jj=466:547
% % % % % % %   jj=100
% % % % % % figure,
% % % % % %    plot(TP1_Cell{jj},'r')
% % % % % %    hold on;
% % % % % %    plot(TP2_Cell{jj},'g')
% % % % % %    hold on;
% % % % % %    plot(TP3_Cell{jj},'b')
% % % % % %    hold on;
% % % % % %    plot(TP4_Cell{jj},'y')
% % % % % %    hold on;
% % % % % %    plot(TP5_Cell{jj},'k')
% % % % % %   end 
% % % % % %     

for jj=1:kk1
    jj
    %jj=6;
spTP1_Cell(jj)=spap2(20,3,[(1:size(TP1_Cell{jj},1))'],TP1_Cell{jj});
spTP2_Cell(jj)=spap2(20,3,[(1:size(TP2_Cell{jj},1))'],TP2_Cell{jj});
spTP3_Cell(jj)=spap2(20,3,[(1:size(TP3_Cell{jj},1))'],TP3_Cell{jj});
spTP4_Cell(jj)=spap2(20,3,[(1:size(TP4_Cell{jj},1))'],TP4_Cell{jj});
spTP5_Cell(jj)=spap2(20,3,[(1:size(TP5_Cell{jj},1))'],TP5_Cell{jj});

% figure,
% fnplt(spTP1_Cell(jj),'r');
% hold on;
% fnplt(spTP2_Cell(jj),'g');
% fnplt(spTP3_Cell(jj),'b');
% fnplt(spTP4_Cell(jj),'y');
% fnplt(spTP5_Cell(jj),'k');




       
% % % % % % y=fnint(spTP3_Cell(jj));
% % % % % % fnplt(y,'r');


end
  
for jj=1:kk1
    jj
intTP1(jj,:) = integral(@(x)fnval(spTP1_Cell(jj),x),1,size(TP1_Cell{jj},1));
intTP2(jj,:) = integral(@(x)fnval(spTP2_Cell(jj),x),1,size(TP2_Cell{jj},1));
intTP3(jj,:) = integral(@(x)fnval(spTP3_Cell(jj),x),1,size(TP3_Cell{jj},1));
intTP4(jj,:) = integral(@(x)fnval(spTP4_Cell(jj),x),1,size(TP4_Cell{jj},1));
intTP5(jj,:) = integral(@(x)fnval(spTP5_Cell(jj),x),1,size(TP5_Cell{jj},1));  
end
  
  
  
  intTP=[intTP1,intTP2,intTP3,intTP4,intTP5];
  
   clearvars -except  intTP kk1
  
% % %   %kk1=547
% % % for jj=1:kk1
% % %     jj
% % %    TP_Sum= sum(intTP(jj,1:5));
% % % pctTP(jj,1)=intTP(jj,1)/TP_Sum;
% % % pctTP(jj,2)=intTP(jj,2)/TP_Sum;
% % % pctTP(jj,3)=intTP(jj,3)/TP_Sum;
% % % pctTP(jj,4)=intTP(jj,4)/TP_Sum;
% % % pctTP(jj,5)=intTP(jj,5)/TP_Sum;
% % % 
% % % % sum(pctTP(jj,:))
% % % end
% % %   
% % %    clearvars -except  intTP pctTP

  
  
  %构建人体5部分关节点是否发生动作的逻辑特征
% labels1= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1)]; %%给样本贴上类别标签
% labels3= [1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1)]; %%给样本贴上类别标签
% labels2= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1)]; %%给样本贴上类别标签
% labels5= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1)]; %%给样本贴上类别标签
% labels4= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1)]; %%给样本贴上类别标签
% 
%   


% 
% LTP1=[labels1,intTP(:,1)];
% LTP2=[labels2,intTP(:,2)];
% LTP3=[labels3,intTP(:,3)];
% LTP4=[labels4,intTP(:,4)];
% LTP5=[labels5,intTP(:,5)];
  
    clearvars -except  intTP pctTP
  
  A=intTP;
[AA,ps] = mapminmax(A',0,1); %%标准化
A = AA';

labels= [1*ones(27,1);1*ones(27,1);1*ones(27,1);1*ones(26,1);1*ones(26,1);1*ones(26,1);1*ones(27,1);1*ones(30,1);1*ones(30,1);2*ones(30,1);2*ones(30,1);[1*ones(6,1);2*ones(3,1);1*ones(6,1);2*ones(3,1);1*ones(3,1);2*ones(3,1);1*ones(3,1);2*ones(3,1)];3*ones(20,1);4*ones(29,1);4*ones(20,1);5*ones(30,1);1*ones(30,1);2*ones(30,1);6*ones(30,1);7*ones(22,1)]; %%给样本贴上类别标签

 
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
        
% % %         [AA,ps] = mapminmax(train_A',0,1); %%标准化
% % % train_A = AA';
% % % 
% % % test_A = (mapminmax('apply', test_A', ps))'; %%标准化
% % %         
        
        
        [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-t 0' '-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_A_labels,train_A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);
        K_accuracy(k)=accuracy(1);
end
% 显示混淆矩阵
[C,order] = confusionmat(test_A_labels,predict_label);
PredictAA=[test_A_labels,predict_label];

 MeanK_accuracy=mean(K_accuracy)

 
