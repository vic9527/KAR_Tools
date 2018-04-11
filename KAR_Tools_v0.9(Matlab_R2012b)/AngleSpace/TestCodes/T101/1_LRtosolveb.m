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
% % %  jj=2;
 A=Bag_LR{jj};%载入数据
 
 
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 


% %数据清洗和补全 重采样
% XX=size(A,1);
% xx=(1:XX)';
% for pp=1:60
%     %pp=26;
% spA=spap2(5,3,xx,A(:,pp));
% D_spA = fnval(spA,xx);
% A(:,pp)=D_spA;
% % scatter(xx,A(:,26))
% % fnplt(spA,'r');
% end
% % 


for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Lkp1=k20-k3;
Lkp2=k3-k4;
Lkp3=k4-k7;

Lkp4=k13-k11;
Lkp5=k11-k9;
Lkp6=k9-k2;
Lkp7=k2-k3;

Lkp8=k12-k10;
Lkp9=k10-k8;
Lkp10=k8-k1;
Lkp11=k1-k3;

Lkp12=k19-k17;
Lkp13=k17-k15;
Lkp14=k15-k6;
Lkp15=k6-k7;

Lkp16=k18-k16;
Lkp17=k16-k14;
Lkp18=k14-k5;
Lkp19=k5-k7;

Lkp=[Lkp1,Lkp2,Lkp3,Lkp4,Lkp5,Lkp6,Lkp7,Lkp8,Lkp9,Lkp10,Lkp11,Lkp12,Lkp13,Lkp14,Lkp15,Lkp16,Lkp17,Lkp18,Lkp19];
% Lkp_Diff=abs(diff(Lkp));
Lkp_Diff=diff(Lkp);


for i=1:19
eval(['VK_LR_D(:,i)','=','sqrt(sum((Lkp_Diff(:,i*3-2:i*3).^2),2))',';']);
end




FlattenedData = VK_LR_D(:)'; % 展开矩阵为一列，然后转置为一行。
Lkp_Diff_01_temp = mapminmax(FlattenedData, 0, 1); % 归一化。
Lkp_Diff_01 = reshape(Lkp_Diff_01_temp, size(VK_LR_D)); % 还原为原始矩阵形式。

 clearvars VK_LR_D

for i=1:19;
eval(['VK_LR(jj,i)','=','var(Lkp_Diff_01(:,i)*(size(Lkp_Diff_01,1)-1))',';']);
end

  end
 
 clearvars -except VK_LR
  
 %构建人体5部分关节点分类信息集合
VK_LR1st=[VK_LR(:,1),VK_LR(:,2),VK_LR(:,3)];
VK_LR2nd=[VK_LR(:,4),VK_LR(:,5),VK_LR(:,6),VK_LR(:,7)];
VK_LR3rd=[VK_LR(:,8),VK_LR(:,9),VK_LR(:,10),VK_LR(:,11)];
VK_LR4th=[VK_LR(:,12),VK_LR(:,13),VK_LR(:,14),VK_LR(:,15)];
VK_LR5th=[VK_LR(:,16),VK_LR(:,17),VK_LR(:,18),VK_LR(:,19)];
%提取人体5部分关节点分类特征，最大值。
Max1st=max(VK_LR1st')';
Max2nd=max(VK_LR2nd')';
Max3rd=max(VK_LR3rd')';
Max4th=max(VK_LR4th')';
Max5th=max(VK_LR5th')';
%提取人体5部分关节点分类特征置为1列。
MaxVK_LR=[Max1st;Max2nd;Max3rd;Max4th;Max5th];

   clearvars -except MaxVK_LR



%构建人体5部分关节点是否发生动作的逻辑特征
labels1= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1)]; %%给样本贴上类别标签
labels2= [1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1)]; %%给样本贴上类别标签
labels3= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1)]; %%给样本贴上类别标签
labels4= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1)]; %%给样本贴上类别标签
labels5= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1)]; %%给样本贴上类别标签
labels=[labels1;labels2;labels3;labels4;labels5];

CP_Data=[labels,MaxVK_LR];

clearvars -except CP_Data













list=dir(['MSRAction3DSkeletonReal3D\','*.txt']);
kk1=length(list);
 for ii=1:kk1
     str = strcat ('MSRAction3DSkeletonReal3D\', list(ii).name);
     Bag_LR{ii}=load(str);
 end
 
 for jj=1:kk1
     
 
 Number=jj
% % %  jj=3;
 A=Bag_LR{jj};%载入数据
 
 
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 


% % % %数据清洗和补全 重采样
% % % XX=size(A,1);
% % % xx=(1:XX)';
% % % for pp=1:60
% % %     %pp=26;
% % % spA=spap2(20,3,xx,A(:,pp));
% % % D_spA = fnval(spA,xx);
% % % A(:,pp)=D_spA;
% % % % scatter(xx,A(:,26))
% % % % fnplt(spA,'r');
% % % end
% % % % 


for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Lkp1=k20-k3;
Lkp2=k3-k4;
Lkp3=k4-k7;

Lkp4=k13-k11;
Lkp5=k11-k9;
Lkp6=k9-k2;
Lkp7=k2-k3;

Lkp8=k12-k10;
Lkp9=k10-k8;
Lkp10=k8-k1;
Lkp11=k1-k3;

Lkp12=k19-k17;
Lkp13=k17-k15;
Lkp14=k15-k6;
Lkp15=k6-k7;

Lkp16=k18-k16;
Lkp17=k16-k14;
Lkp18=k14-k5;
Lkp19=k5-k7;

Lkp=[Lkp1,Lkp2,Lkp3,Lkp4,Lkp5,Lkp6,Lkp7,Lkp8,Lkp9,Lkp10,Lkp11,Lkp12,Lkp13,Lkp14,Lkp15,Lkp16,Lkp17,Lkp18,Lkp19];
% Lkp_Diff=abs(diff(Lkp));
Lkp_Diff=diff(Lkp);



for i=1:19
eval(['VK_LR_D(:,i)','=','sqrt(sum((Lkp_Diff(:,i*3-2:i*3).^2),2))',';']);
end



FlattenedData = VK_LR_D(:)'; % 展开矩阵为一列，然后转置为一行。
Lkp_Diff_01_temp = mapminmax(FlattenedData, 0, 1); % 归一化。
Lkp_Diff_01 = reshape(Lkp_Diff_01_temp, size(VK_LR_D)); % 还原为原始矩阵形式。

clearvars VK_LR_D


for i=1:19;
eval(['VK_LR(jj,i)','=','var(Lkp_Diff_01(:,i)*(size(Lkp_Diff_01,1)-1))',';']);
end

  end
 
 clearvars -except VK_LR CP_Data
  
 %构建人体5部分关节点分类信息集合
VK_LR1st=[VK_LR(:,1),VK_LR(:,2),VK_LR(:,3)];
VK_LR2nd=[VK_LR(:,4),VK_LR(:,5),VK_LR(:,6),VK_LR(:,7)];
VK_LR3rd=[VK_LR(:,8),VK_LR(:,9),VK_LR(:,10),VK_LR(:,11)];
VK_LR4th=[VK_LR(:,12),VK_LR(:,13),VK_LR(:,14),VK_LR(:,15)];
VK_LR5th=[VK_LR(:,16),VK_LR(:,17),VK_LR(:,18),VK_LR(:,19)];
%提取人体5部分关节点分类特征，最大值。
Max1st=max(VK_LR1st')';
Max2nd=max(VK_LR2nd')';
Max3rd=max(VK_LR3rd')';
Max4th=max(VK_LR4th')';
Max5th=max(VK_LR5th')';
%提取人体5部分关节点分类特征置为1列。
MaxVK_LR=[Max1st;Max2nd;Max3rd;Max4th;Max5th];

   clearvars -except MaxVK_LR CP_Data

%%%%%%测试标签
labels1= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);1*ones(29,1);0*ones(30,1);0*ones(20,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);1*ones(30,1)]; %%给样本贴上类别标签
labels2= [1*ones(27,1);1*ones(27,1);1*ones(27,1);1*ones(26,1);1*ones(26,1);1*ones(26,1);1*ones(28,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(29,1);0*ones(30,1);0*ones(20,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1)]; %%给样本贴上类别标签
labels3= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(6,1);1*ones(3,1);0*ones(6,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(29,1);0*ones(30,1);0*ones(20,1);1*ones(30,1);0*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(30,1)]; %%给样本贴上类别标签
labels4= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(29,1);1*ones(30,1);1*ones(20,1);1*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1)]; %%给样本贴上类别标签
labels5= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(29,1);0*ones(30,1);0*ones(20,1);1*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1)]; %%给样本贴上类别标签
labels=[labels1;labels2;labels3;labels4;labels5];
AllDataCS=[labels,MaxVK_LR];

clearvars -except CP_Data AllDataCS











%逻辑回归分类
xl=CP_Data;
x=xl(:,2);
y=xl(:,1);
b =glmfit(x,y,'binomial', 'link', 'logit');
clearvars -except b

%%%求逻辑参数b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% % % % % % p = glmval(b,AllDataCS(:,2), 'logit');
% % % % % % % clearvars P
% % % % % % P(p>=0.5)=1;
% % % % % % P(p<0.5)=0;
% % % % % % P=P';
% % % % % % %识别率
% % % % % % C = cfmatrix(AllDataCS(:,1),P);
% % % % % % AC=trace(C)/sum(sum(C))
% % % % % % 
% % % % % % clearvars -except CP_Data AllDataCS b
% % % % % % 
% % % % % % % DB=[AllDataCS(:,1),P];
% % % % % % Plabels = [P(1:kk2),P(kk2+1:kk2*2),P(kk2*2+1:kk2*3),P(kk2*3+1:kk2*4),P(kk2*4+1:kk2*5)];

 
 
 
 
 