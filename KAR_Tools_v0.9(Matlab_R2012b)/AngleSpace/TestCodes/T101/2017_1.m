clear;clc;
warning off
format long g %�����ÿ�ѧ������

list=dir(['MSRAction3DSkeletonReal3D\','*.txt']);
kk=length(list);
 for ii=1:kk
     str = strcat ('MSRAction3DSkeletonReal3D\', list(ii).name);
     Bag{ii}=load(str);
 end
 
 for jj=1:kk
     
 
 Number=jj
% % %  jj=3;
 A=Bag{jj};%��������
 
 
A(:,4)=[];
[mm,nn]=size(A);
A1=reshape(A',nn*20,mm/20)'; 

% %��������ߴ��һ��
% 
% 
% 
% % % %������ϴ�Ͳ�ȫ �ز���
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
% 
% 
% for i=1:20;
% eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
% eval(['vk(jj,i)','=','sum(var(A(:,i*3-2:i*3)))',';']);
% end

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
% eval(['vk(jj,i)','=','sum(var(A(:,i*3-2:i*3)))',';']);
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

% Lkp1_Diff=diff(Lkp1);

Lkp=[Lkp1,Lkp2,Lkp3,Lkp4,Lkp5,Lkp6,Lkp7,Lkp8,Lkp9,Lkp10,Lkp11,Lkp12,Lkp13,Lkp14,Lkp15,Lkp16,Lkp17,Lkp18,Lkp19];

Lkp_Diff=abs(diff(Lkp));

% clearvars -except Lkp Lkp_Diff jj Bag;
%���������һ��
% train_data_feature=train_data_feature';
% [train_data_feature,PS_train]=mapminmax(train_data_feature,0,1);
% train_data_feature=train_data_feature';

% [AA,ps] = mapminmax(Lkp_Diff',0,1); %%��׼��
% Lkp_Diff_01 = AA';

FlattenedData = Lkp_Diff(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
Lkp_Diff_01_temp = mapminmax(FlattenedData, 0, 1); % ��һ����
Lkp_Diff_01 = reshape(Lkp_Diff_01_temp, size(Lkp_Diff)); % ��ԭΪԭʼ������ʽ��
% % % Lkp_Diff_01 = Lkp_Diff;
 for i=1:19;
% eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
eval(['vk(jj,i)','=','sum(var(Lkp_Diff_01(:,i*3-2:i*3))*(size(Lkp_Diff_01,1)-1))',';']);
end



% % % % %�������ƶȹ�һ��
% % % % % % % for i=1:19;
% % % % % % % % eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
% % % % % % % % eval(['vk(jj,i)','=','sum(var(Lkp_Diff_01(:,i*3-2:i*3)))',';']);
% % % % % % % Lkp_Diff_cos01=Lkp_Diff(:,i*3-2:i*3)/mean(sqrt(sum(Lkp(:,i*3-2:i*3).*Lkp(:,i*3-2:i*3),2)));
% % % % % % % eval(['vk(jj,i)','=','sum(var(Lkp_Diff_cos01)*(size(Lkp_Diff_cos01,1)-1))',';']);
% % % % % % % 
% % % % % % % end
% % % % 
% % % % for i=1:19;
% % % % %%% i=1;
% % % % Lkp_Diff_cos01=Lkp_Diff(:,i*3-2:i*3)/mean(sqrt(sum(Lkp(:,i*3-2:i*3).*Lkp(:,i*3-2:i*3),2)));
% % % % eval(['vk(jj,i*3-2:i*3)','=','var(Lkp_Diff_cos01)*(size(Lkp_Diff_cos01,1)-1)',';']);
% % % % 
% % % % end
% % % % 
% % % % 
% % % % FlattenedData = vk(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
% % % % Lkp_Diff_01_temp = mapminmax(FlattenedData, 0, 1); % ��һ����
% % % % vk_01 = reshape(Lkp_Diff_01_temp, size(vk)); % ��ԭΪԭʼ������ʽ��






 end

clearvars -except vk vk_01


save vk2

 
 
 
 
 
 
 