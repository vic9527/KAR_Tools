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


%数据清洗和补全 重采样
XX=size(A,1);
xx=(1:XX)';
for pp=1:60
    %pp=26;
spA=spap2(4,3,xx,A(:,pp));
D_spA = fnval(spA,xx);
A(:,pp)=D_spA;
% scatter(xx,A(:,26))
% fnplt(spA,'r');
end
% 


for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Mkp1=k20-k7;
Mkp2=k3-k7;
Mkp3=k4-k7;

Mkp4=k13-k7;
Mkp5=k11-k7;
Mkp6=k9-k7;
Mkp7=k2-k7;

Mkp8=k12-k7;
Mkp9=k10-k7;
Mkp10=k8-k7;
Mkp11=k1-k7;

Mkp12=k19-k7;
Mkp13=k17-k7;
Mkp14=k15-k7;
Mkp15=k6-k7;

Mkp16=k18-k7;
Mkp17=k16-k7;
Mkp18=k14-k7;
Mkp19=k5-k7;

Mkp=[Mkp1,Mkp2,Mkp3,Mkp4,Mkp5,Mkp6,Mkp7,Mkp8,Mkp9,Mkp10,Mkp11,Mkp12,Mkp13,Mkp14,Mkp15,Mkp16,Mkp17,Mkp18,Mkp19];
% Mkp_Diff=abs(diff(Mkp));
Mkp_Diff=diff(Mkp);


for i=1:19
    VK_LR_D(:,i)=sqrt(sum((Mkp_Diff(:,i*3-2:i*3).^2),2));
end




FlattenedData = VK_LR_D(:)'; % 展开矩阵为一列，然后转置为一行。
Mkp_Diff_01_temp = mapminmax(FlattenedData, 0, 1); % 归一化。
Mkp_Diff_01 = reshape(Mkp_Diff_01_temp, size(VK_LR_D)); % 还原为原始矩阵形式。

 clearvars VK_LR_D

for i=1:19;
    VK_LR(jj,i)=var(Mkp_Diff_01(:,i)*(size(Mkp_Diff_01,1)-1));
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

Mkp1=k20-k7;
Mkp2=k3-k7;
Mkp3=k4-k7;

Mkp4=k13-k7;
Mkp5=k11-k7;
Mkp6=k9-k7;
Mkp7=k2-k7;

Mkp8=k12-k7;
Mkp9=k10-k7;
Mkp10=k8-k7;
Mkp11=k1-k7;

Mkp12=k19-k7;
Mkp13=k17-k7;
Mkp14=k15-k7;
Mkp15=k6-k7;

Mkp16=k18-k7;
Mkp17=k16-k7;
Mkp18=k14-k7;
Mkp19=k5-k7;

Mkp=[Mkp1,Mkp2,Mkp3,Mkp4,Mkp5,Mkp6,Mkp7,Mkp8,Mkp9,Mkp10,Mkp11,Mkp12,Mkp13,Mkp14,Mkp15,Mkp16,Mkp17,Mkp18,Mkp19];
% Mkp_Diff=abs(diff(Mkp));
Mkp_Diff=diff(Mkp);


for i=1:19
    VK_LR_D(:,i)=sqrt(sum((Mkp_Diff(:,i*3-2:i*3).^2),2));
end




FlattenedData = VK_LR_D(:)'; % 展开矩阵为一列，然后转置为一行。
Mkp_Diff_01_temp = mapminmax(FlattenedData, 0, 1); % 归一化。
Mkp_Diff_01 = reshape(Mkp_Diff_01_temp, size(VK_LR_D)); % 还原为原始矩阵形式。

 clearvars VK_LR_D

for i=1:19;
    VK_LR(jj,i)=var(Mkp_Diff_01(:,i)*(size(Mkp_Diff_01,1)-1));
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
clearvars -except CP_Data AllDataCS b

%%%求逻辑参数b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


p = glmval(b,AllDataCS(:,2), 'logit');
% clearvars P
P(p>=0.5)=1;
P(p<0.5)=0;
P=P';
%识别率
C = cfmatrix(AllDataCS(:,1),P);
AC=trace(C)/sum(sum(C))

clearvars -except CP_Data AllDataCS b



 
 
 
 
 