clear;clc;
warning off
format long g %�����ÿ�ѧ������

list=dir(['MSRAction3DSkeletonReal3D_LR\','*.txt']);
kk1=length(list);
 for ii=1:kk1
     str = strcat ('MSRAction3DSkeletonReal3D_LR\', list(ii).name);
     Bag_XL{ii}=load(str);
 end
 
list=dir(['MSRAction3DSkeletonReal3D\','*.txt']);
kk2=length(list);
 for ii=1:kk2
     str = strcat ('MSRAction3DSkeletonReal3D\', list(ii).name);
     Bag_CS{ii}=load(str);
 end
 
 clearvars -except Bag_XL Bag_CS kk1 kk2
 
  for jj=1:kk1
     
 
 Number=jj
% % %  jj=3;
 A=Bag_XL{jj};%��������
 
 
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 


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

Lkp_Diff=abs(diff(Lkp));


FlattenedData = Lkp_Diff(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
Lkp_Diff_01_temp = mapminmax(FlattenedData, 0, 1); % ��һ����
Lkp_Diff_01 = reshape(Lkp_Diff_01_temp, size(Lkp_Diff)); % ��ԭΪԭʼ������ʽ��

for i=1:19;
eval(['VK_XL(jj,i)','=','sum(var(Lkp_Diff_01(:,i*3-2:i*3))*(size(Lkp_Diff_01,1)-1))',';']);
end



%�ؽڵ�ֲ�XYZ����Ƕ�ƫ����

norm_Lkp1=sum(abs(Lkp1).^2,2).^(1/2);
Ang_Lkp1_X=acosd(Lkp1(:,1)./norm_Lkp1);
Ang_Lkp1_Y=acosd(Lkp1(:,2)./norm_Lkp1);
Ang_Lkp1_Z=acosd(Lkp1(:,3)./norm_Lkp1);

norm_Lkp2=sum(abs(Lkp2).^2,2).^(1/2);
Ang_Lkp2_X=acosd(Lkp2(:,1)./norm_Lkp2);
Ang_Lkp2_Y=acosd(Lkp2(:,2)./norm_Lkp2);
Ang_Lkp2_Z=acosd(Lkp2(:,3)./norm_Lkp2);

norm_Lkp3=sum(abs(Lkp3).^2,2).^(1/2);
Ang_Lkp3_X=acosd(Lkp3(:,1)./norm_Lkp3);
Ang_Lkp3_Y=acosd(Lkp3(:,2)./norm_Lkp3);
Ang_Lkp3_Z=acosd(Lkp3(:,3)./norm_Lkp3);

norm_Lkp4=sum(abs(Lkp4).^2,2).^(1/2);
Ang_Lkp4_X=acosd(Lkp4(:,1)./norm_Lkp4);
Ang_Lkp4_Y=acosd(Lkp4(:,2)./norm_Lkp4);
Ang_Lkp4_Z=acosd(Lkp4(:,3)./norm_Lkp4);

norm_Lkp5=sum(abs(Lkp5).^2,2).^(1/2);
Ang_Lkp5_X=acosd(Lkp5(:,1)./norm_Lkp5);
Ang_Lkp5_Y=acosd(Lkp5(:,2)./norm_Lkp5);
Ang_Lkp5_Z=acosd(Lkp5(:,3)./norm_Lkp5);

norm_Lkp6=sum(abs(Lkp6).^2,2).^(1/2);
Ang_Lkp6_X=acosd(Lkp6(:,1)./norm_Lkp6);
Ang_Lkp6_Y=acosd(Lkp6(:,2)./norm_Lkp6);
Ang_Lkp6_Z=acosd(Lkp6(:,3)./norm_Lkp6);

norm_Lkp7=sum(abs(Lkp7).^2,2).^(1/2);
Ang_Lkp7_X=acosd(Lkp7(:,1)./norm_Lkp7);
Ang_Lkp7_Y=acosd(Lkp7(:,2)./norm_Lkp7);
Ang_Lkp7_Z=acosd(Lkp7(:,3)./norm_Lkp7);

norm_Lkp8=sum(abs(Lkp8).^2,2).^(1/2);
Ang_Lkp8_X=acosd(Lkp8(:,1)./norm_Lkp8);
Ang_Lkp8_Y=acosd(Lkp8(:,2)./norm_Lkp8);
Ang_Lkp8_Z=acosd(Lkp8(:,3)./norm_Lkp8);

norm_Lkp9=sum(abs(Lkp9).^2,2).^(1/2);
Ang_Lkp9_X=acosd(Lkp9(:,1)./norm_Lkp9);
Ang_Lkp9_Y=acosd(Lkp9(:,2)./norm_Lkp9);
Ang_Lkp9_Z=acosd(Lkp9(:,3)./norm_Lkp9);

norm_Lkp10=sum(abs(Lkp10).^2,2).^(1/2);
Ang_Lkp10_X=acosd(Lkp10(:,1)./norm_Lkp10);
Ang_Lkp10_Y=acosd(Lkp10(:,2)./norm_Lkp10);
Ang_Lkp10_Z=acosd(Lkp10(:,3)./norm_Lkp10);

norm_Lkp11=sum(abs(Lkp11).^2,2).^(1/2);
Ang_Lkp11_X=acosd(Lkp11(:,1)./norm_Lkp11);
Ang_Lkp11_Y=acosd(Lkp11(:,2)./norm_Lkp11);
Ang_Lkp11_Z=acosd(Lkp11(:,3)./norm_Lkp11);

norm_Lkp12=sum(abs(Lkp12).^2,2).^(1/2);
Ang_Lkp12_X=acosd(Lkp12(:,1)./norm_Lkp12);
Ang_Lkp12_Y=acosd(Lkp12(:,2)./norm_Lkp12);
Ang_Lkp12_Z=acosd(Lkp12(:,3)./norm_Lkp12);

norm_Lkp13=sum(abs(Lkp13).^2,2).^(1/2);
Ang_Lkp13_X=acosd(Lkp13(:,1)./norm_Lkp13);
Ang_Lkp13_Y=acosd(Lkp13(:,2)./norm_Lkp13);
Ang_Lkp13_Z=acosd(Lkp13(:,3)./norm_Lkp13);

norm_Lkp14=sum(abs(Lkp14).^2,2).^(1/2);
Ang_Lkp14_X=acosd(Lkp14(:,1)./norm_Lkp14);
Ang_Lkp14_Y=acosd(Lkp14(:,2)./norm_Lkp14);
Ang_Lkp14_Z=acosd(Lkp14(:,3)./norm_Lkp14);

norm_Lkp15=sum(abs(Lkp15).^2,2).^(1/2);
Ang_Lkp15_X=acosd(Lkp15(:,1)./norm_Lkp15);
Ang_Lkp15_Y=acosd(Lkp15(:,2)./norm_Lkp15);
Ang_Lkp15_Z=acosd(Lkp15(:,3)./norm_Lkp15);

norm_Lkp16=sum(abs(Lkp16).^2,2).^(1/2);
Ang_Lkp16_X=acosd(Lkp16(:,1)./norm_Lkp16);
Ang_Lkp16_Y=acosd(Lkp16(:,2)./norm_Lkp16);
Ang_Lkp16_Z=acosd(Lkp16(:,3)./norm_Lkp16);

norm_Lkp17=sum(abs(Lkp17).^2,2).^(1/2);
Ang_Lkp17_X=acosd(Lkp17(:,1)./norm_Lkp17);
Ang_Lkp17_Y=acosd(Lkp17(:,2)./norm_Lkp17);
Ang_Lkp17_Z=acosd(Lkp17(:,3)./norm_Lkp17);

norm_Lkp18=sum(abs(Lkp18).^2,2).^(1/2);
Ang_Lkp18_X=acosd(Lkp18(:,1)./norm_Lkp18);
Ang_Lkp18_Y=acosd(Lkp18(:,2)./norm_Lkp18);
Ang_Lkp18_Z=acosd(Lkp18(:,3)./norm_Lkp18);

norm_Lkp19=sum(abs(Lkp19).^2,2).^(1/2);
Ang_Lkp19_X=acosd(Lkp19(:,1)./norm_Lkp19);
Ang_Lkp19_Y=acosd(Lkp19(:,2)./norm_Lkp19);
Ang_Lkp19_Z=acosd(Lkp19(:,3)./norm_Lkp19);



% % % % % % % % % % % % % % % % % % % % % %��ʱ���ϵ�����

%��ʱ�������ϵľ�ֵ�����ֵ����Сֵ������ֵ��

%�ֲ�����
A_Mean_Lkp1(:,1)=mean(abs(diff(Ang_Lkp1_X)));
A_Mean_Lkp1(:,2)=mean(abs(diff(Ang_Lkp1_Y)));
A_Mean_Lkp1(:,3)=mean(abs(diff(Ang_Lkp1_Z)));
A_Var_Lkp1(:,1)=var(abs(diff(Ang_Lkp1_X)));
A_Var_Lkp1(:,2)=var(abs(diff(Ang_Lkp1_Y)));
A_Var_Lkp1(:,3)=var(abs(diff(Ang_Lkp1_Z)));
Lkp1_all=[A_Mean_Lkp1,A_Var_Lkp1];

A_Mean_Lkp2(:,1)=mean(abs(diff(Ang_Lkp2_X)));
A_Mean_Lkp2(:,2)=mean(abs(diff(Ang_Lkp2_Y)));
A_Mean_Lkp2(:,3)=mean(abs(diff(Ang_Lkp2_Z)));
A_Var_Lkp2(:,1)=var(abs(diff(Ang_Lkp2_X)));
A_Var_Lkp2(:,2)=var(abs(diff(Ang_Lkp2_Y)));
A_Var_Lkp2(:,3)=var(abs(diff(Ang_Lkp2_Z)));
Lkp2_all=[A_Mean_Lkp2,A_Var_Lkp2];

A_Mean_Lkp3(:,1)=mean(abs(diff(Ang_Lkp3_X)));
A_Mean_Lkp3(:,2)=mean(abs(diff(Ang_Lkp3_Y)));
A_Mean_Lkp3(:,3)=mean(abs(diff(Ang_Lkp3_Z)));
A_Var_Lkp3(:,1)=var(abs(diff(Ang_Lkp3_X)));
A_Var_Lkp3(:,2)=var(abs(diff(Ang_Lkp3_Y)));
A_Var_Lkp3(:,3)=var(abs(diff(Ang_Lkp3_Z)));
Lkp3_all=[A_Mean_Lkp3,A_Var_Lkp3];

A_Mean_Lkp4(:,1)=mean(abs(diff(Ang_Lkp4_X)));
A_Mean_Lkp4(:,2)=mean(abs(diff(Ang_Lkp4_Y)));
A_Mean_Lkp4(:,3)=mean(abs(diff(Ang_Lkp4_Z)));
A_Var_Lkp4(:,1)=var(abs(diff(Ang_Lkp4_X)));
A_Var_Lkp4(:,2)=var(abs(diff(Ang_Lkp4_Y)));
A_Var_Lkp4(:,3)=var(abs(diff(Ang_Lkp4_Z)));
Lkp4_all=[A_Mean_Lkp4,A_Var_Lkp4];

A_Mean_Lkp5(:,1)=mean(abs(diff(Ang_Lkp5_X)));
A_Mean_Lkp5(:,2)=mean(abs(diff(Ang_Lkp5_Y)));
A_Mean_Lkp5(:,3)=mean(abs(diff(Ang_Lkp5_Z)));
A_Var_Lkp5(:,1)=var(abs(diff(Ang_Lkp5_X)));
A_Var_Lkp5(:,2)=var(abs(diff(Ang_Lkp5_Y)));
A_Var_Lkp5(:,3)=var(abs(diff(Ang_Lkp5_Z)));
Lkp5_all=[A_Mean_Lkp5,A_Var_Lkp5];

A_Mean_Lkp6(:,1)=mean(abs(diff(Ang_Lkp6_X)));
A_Mean_Lkp6(:,2)=mean(abs(diff(Ang_Lkp6_Y)));
A_Mean_Lkp6(:,3)=mean(abs(diff(Ang_Lkp6_Z)));
A_Var_Lkp6(:,1)=var(abs(diff(Ang_Lkp6_X)));
A_Var_Lkp6(:,2)=var(abs(diff(Ang_Lkp6_Y)));
A_Var_Lkp6(:,3)=var(abs(diff(Ang_Lkp6_Z)));
Lkp6_all=[A_Mean_Lkp6,A_Var_Lkp6];

A_Mean_Lkp7(:,1)=mean(abs(diff(Ang_Lkp7_X)));
A_Mean_Lkp7(:,2)=mean(abs(diff(Ang_Lkp7_Y)));
A_Mean_Lkp7(:,3)=mean(abs(diff(Ang_Lkp7_Z)));
A_Var_Lkp7(:,1)=var(abs(diff(Ang_Lkp7_X)));
A_Var_Lkp7(:,2)=var(abs(diff(Ang_Lkp7_Y)));
A_Var_Lkp7(:,3)=var(abs(diff(Ang_Lkp7_Z)));
Lkp7_all=[A_Mean_Lkp7,A_Var_Lkp7];

A_Mean_Lkp8(:,1)=mean(abs(diff(Ang_Lkp8_X)));
A_Mean_Lkp8(:,2)=mean(abs(diff(Ang_Lkp8_Y)));
A_Mean_Lkp8(:,3)=mean(abs(diff(Ang_Lkp8_Z)));
A_Var_Lkp8(:,1)=var(abs(diff(Ang_Lkp8_X)));
A_Var_Lkp8(:,2)=var(abs(diff(Ang_Lkp8_Y)));
A_Var_Lkp8(:,3)=var(abs(diff(Ang_Lkp8_Z)));
Lkp8_all=[A_Mean_Lkp8,A_Var_Lkp8];

A_Mean_Lkp9(:,1)=mean(abs(diff(Ang_Lkp9_X)));
A_Mean_Lkp9(:,2)=mean(abs(diff(Ang_Lkp9_Y)));
A_Mean_Lkp9(:,3)=mean(abs(diff(Ang_Lkp9_Z)));
A_Var_Lkp9(:,1)=var(abs(diff(Ang_Lkp9_X)));
A_Var_Lkp9(:,2)=var(abs(diff(Ang_Lkp9_Y)));
A_Var_Lkp9(:,3)=var(abs(diff(Ang_Lkp9_Z)));
Lkp9_all=[A_Mean_Lkp9,A_Var_Lkp9];

A_Mean_Lkp10(:,1)=mean(abs(diff(Ang_Lkp10_X)));
A_Mean_Lkp10(:,2)=mean(abs(diff(Ang_Lkp10_Y)));
A_Mean_Lkp10(:,3)=mean(abs(diff(Ang_Lkp10_Z)));
A_Var_Lkp10(:,1)=var(abs(diff(Ang_Lkp10_X)));
A_Var_Lkp10(:,2)=var(abs(diff(Ang_Lkp10_Y)));
A_Var_Lkp10(:,3)=var(abs(diff(Ang_Lkp10_Z)));
Lkp10_all=[A_Mean_Lkp10,A_Var_Lkp10];

A_Mean_Lkp11(:,1)=mean(abs(diff(Ang_Lkp11_X)));
A_Mean_Lkp11(:,2)=mean(abs(diff(Ang_Lkp11_Y)));
A_Mean_Lkp11(:,3)=mean(abs(diff(Ang_Lkp11_Z)));
A_Var_Lkp11(:,1)=var(abs(diff(Ang_Lkp11_X)));
A_Var_Lkp11(:,2)=var(abs(diff(Ang_Lkp11_Y)));
A_Var_Lkp11(:,3)=var(abs(diff(Ang_Lkp11_Z)));
Lkp11_all=[A_Mean_Lkp11,A_Var_Lkp11];

A_Mean_Lkp12(:,1)=mean(abs(diff(Ang_Lkp12_X)));
A_Mean_Lkp12(:,2)=mean(abs(diff(Ang_Lkp12_Y)));
A_Mean_Lkp12(:,3)=mean(abs(diff(Ang_Lkp12_Z)));
A_Var_Lkp12(:,1)=var(abs(diff(Ang_Lkp12_X)));
A_Var_Lkp12(:,2)=var(abs(diff(Ang_Lkp12_Y)));
A_Var_Lkp12(:,3)=var(abs(diff(Ang_Lkp12_Z)));
Lkp12_all=[A_Mean_Lkp12,A_Var_Lkp12];

A_Mean_Lkp13(:,1)=mean(abs(diff(Ang_Lkp13_X)));
A_Mean_Lkp13(:,2)=mean(abs(diff(Ang_Lkp13_Y)));
A_Mean_Lkp13(:,3)=mean(abs(diff(Ang_Lkp13_Z)));
A_Var_Lkp13(:,1)=var(abs(diff(Ang_Lkp13_X)));
A_Var_Lkp13(:,2)=var(abs(diff(Ang_Lkp13_Y)));
A_Var_Lkp13(:,3)=var(abs(diff(Ang_Lkp13_Z)));
Lkp13_all=[A_Mean_Lkp13,A_Var_Lkp13];

A_Mean_Lkp14(:,1)=mean(abs(diff(Ang_Lkp14_X)));
A_Mean_Lkp14(:,2)=mean(abs(diff(Ang_Lkp14_Y)));
A_Mean_Lkp14(:,3)=mean(abs(diff(Ang_Lkp14_Z)));
A_Var_Lkp14(:,1)=var(abs(diff(Ang_Lkp14_X)));
A_Var_Lkp14(:,2)=var(abs(diff(Ang_Lkp14_Y)));
A_Var_Lkp14(:,3)=var(abs(diff(Ang_Lkp14_Z)));
Lkp14_all=[A_Mean_Lkp14,A_Var_Lkp14];

A_Mean_Lkp15(:,1)=mean(abs(diff(Ang_Lkp15_X)));
A_Mean_Lkp15(:,2)=mean(abs(diff(Ang_Lkp15_Y)));
A_Mean_Lkp15(:,3)=mean(abs(diff(Ang_Lkp15_Z)));
A_Var_Lkp15(:,1)=var(abs(diff(Ang_Lkp15_X)));
A_Var_Lkp15(:,2)=var(abs(diff(Ang_Lkp15_Y)));
A_Var_Lkp15(:,3)=var(abs(diff(Ang_Lkp15_Z)));
Lkp15_all=[A_Mean_Lkp15,A_Var_Lkp15];

A_Mean_Lkp16(:,1)=mean(abs(diff(Ang_Lkp16_X)));
A_Mean_Lkp16(:,2)=mean(abs(diff(Ang_Lkp16_Y)));
A_Mean_Lkp16(:,3)=mean(abs(diff(Ang_Lkp16_Z)));
A_Var_Lkp16(:,1)=var(abs(diff(Ang_Lkp16_X)));
A_Var_Lkp16(:,2)=var(abs(diff(Ang_Lkp16_Y)));
A_Var_Lkp16(:,3)=var(abs(diff(Ang_Lkp16_Z)));
Lkp16_all=[A_Mean_Lkp16,A_Var_Lkp16];

A_Mean_Lkp17(:,1)=mean(abs(diff(Ang_Lkp17_X)));
A_Mean_Lkp17(:,2)=mean(abs(diff(Ang_Lkp17_Y)));
A_Mean_Lkp17(:,3)=mean(abs(diff(Ang_Lkp17_Z)));
A_Var_Lkp17(:,1)=var(abs(diff(Ang_Lkp17_X)));
A_Var_Lkp17(:,2)=var(abs(diff(Ang_Lkp17_Y)));
A_Var_Lkp17(:,3)=var(abs(diff(Ang_Lkp17_Z)));
Lkp17_all=[A_Mean_Lkp17,A_Var_Lkp17];

A_Mean_Lkp18(:,1)=mean(abs(diff(Ang_Lkp18_X)));
A_Mean_Lkp18(:,2)=mean(abs(diff(Ang_Lkp18_Y)));
A_Mean_Lkp18(:,3)=mean(abs(diff(Ang_Lkp18_Z)));
A_Var_Lkp18(:,1)=var(abs(diff(Ang_Lkp18_X)));
A_Var_Lkp18(:,2)=var(abs(diff(Ang_Lkp18_Y)));
A_Var_Lkp18(:,3)=var(abs(diff(Ang_Lkp18_Z)));
Lkp18_all=[A_Mean_Lkp18,A_Var_Lkp18];

A_Mean_Lkp19(:,1)=mean(abs(diff(Ang_Lkp19_X)));
A_Mean_Lkp19(:,2)=mean(abs(diff(Ang_Lkp19_Y)));
A_Mean_Lkp19(:,3)=mean(abs(diff(Ang_Lkp19_Z)));
A_Var_Lkp19(:,1)=var(abs(diff(Ang_Lkp19_X)));
A_Var_Lkp19(:,2)=var(abs(diff(Ang_Lkp19_Y)));
A_Var_Lkp19(:,3)=var(abs(diff(Ang_Lkp19_Z)));
Lkp19_all=[A_Mean_Lkp19,A_Var_Lkp19];






Lkp_XL(jj,:)=[Lkp1_all,Lkp2_all,Lkp3_all,Lkp4_all,Lkp5_all,Lkp6_all,Lkp7_all,Lkp8_all,Lkp9_all,Lkp10_all,Lkp11_all,Lkp12_all,Lkp13_all,Lkp14_all,Lkp15_all,Lkp16_all,Lkp17_all,Lkp18_all,Lkp19_all];




  end
 
 clearvars -except Bag_XL Bag_CS kk1 kk2 VK_XL Lkp_XL
  
  for jj=1:kk2
     
 
 Number=jj
% % %  jj=3;
 A=Bag_CS{jj};%��������
 
 
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 


%������ϴ�Ͳ�ȫ �ز���
XX=size(A,1);
xx=(1:XX)';
for pp=1:60
    %pp=26;
spA=spap2(20,3,xx,A(:,pp));
D_spA = fnval(spA,xx);
A(:,pp)=D_spA;
% scatter(xx,A(:,26))
% fnplt(spA,'r');
end
% 


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

Lkp_Diff=abs(diff(Lkp));


FlattenedData = Lkp_Diff(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
Lkp_Diff_01_temp = mapminmax(FlattenedData, 0, 1); % ��һ����
Lkp_Diff_01 = reshape(Lkp_Diff_01_temp, size(Lkp_Diff)); % ��ԭΪԭʼ������ʽ��

for i=1:19;
eval(['VK_CS(jj,i)','=','sum(var(Lkp_Diff_01(:,i*3-2:i*3))*(size(Lkp_Diff_01,1)-1))',';']);
end



%�ؽڵ�ֲ�XYZ����Ƕ�ƫ����

norm_Lkp1=sum(abs(Lkp1).^2,2).^(1/2);
Ang_Lkp1_X=acosd(Lkp1(:,1)./norm_Lkp1);
Ang_Lkp1_Y=acosd(Lkp1(:,2)./norm_Lkp1);
Ang_Lkp1_Z=acosd(Lkp1(:,3)./norm_Lkp1);

norm_Lkp2=sum(abs(Lkp2).^2,2).^(1/2);
Ang_Lkp2_X=acosd(Lkp2(:,1)./norm_Lkp2);
Ang_Lkp2_Y=acosd(Lkp2(:,2)./norm_Lkp2);
Ang_Lkp2_Z=acosd(Lkp2(:,3)./norm_Lkp2);

norm_Lkp3=sum(abs(Lkp3).^2,2).^(1/2);
Ang_Lkp3_X=acosd(Lkp3(:,1)./norm_Lkp3);
Ang_Lkp3_Y=acosd(Lkp3(:,2)./norm_Lkp3);
Ang_Lkp3_Z=acosd(Lkp3(:,3)./norm_Lkp3);

norm_Lkp4=sum(abs(Lkp4).^2,2).^(1/2);
Ang_Lkp4_X=acosd(Lkp4(:,1)./norm_Lkp4);
Ang_Lkp4_Y=acosd(Lkp4(:,2)./norm_Lkp4);
Ang_Lkp4_Z=acosd(Lkp4(:,3)./norm_Lkp4);

norm_Lkp5=sum(abs(Lkp5).^2,2).^(1/2);
Ang_Lkp5_X=acosd(Lkp5(:,1)./norm_Lkp5);
Ang_Lkp5_Y=acosd(Lkp5(:,2)./norm_Lkp5);
Ang_Lkp5_Z=acosd(Lkp5(:,3)./norm_Lkp5);

norm_Lkp6=sum(abs(Lkp6).^2,2).^(1/2);
Ang_Lkp6_X=acosd(Lkp6(:,1)./norm_Lkp6);
Ang_Lkp6_Y=acosd(Lkp6(:,2)./norm_Lkp6);
Ang_Lkp6_Z=acosd(Lkp6(:,3)./norm_Lkp6);

norm_Lkp7=sum(abs(Lkp7).^2,2).^(1/2);
Ang_Lkp7_X=acosd(Lkp7(:,1)./norm_Lkp7);
Ang_Lkp7_Y=acosd(Lkp7(:,2)./norm_Lkp7);
Ang_Lkp7_Z=acosd(Lkp7(:,3)./norm_Lkp7);

norm_Lkp8=sum(abs(Lkp8).^2,2).^(1/2);
Ang_Lkp8_X=acosd(Lkp8(:,1)./norm_Lkp8);
Ang_Lkp8_Y=acosd(Lkp8(:,2)./norm_Lkp8);
Ang_Lkp8_Z=acosd(Lkp8(:,3)./norm_Lkp8);

norm_Lkp9=sum(abs(Lkp9).^2,2).^(1/2);
Ang_Lkp9_X=acosd(Lkp9(:,1)./norm_Lkp9);
Ang_Lkp9_Y=acosd(Lkp9(:,2)./norm_Lkp9);
Ang_Lkp9_Z=acosd(Lkp9(:,3)./norm_Lkp9);

norm_Lkp10=sum(abs(Lkp10).^2,2).^(1/2);
Ang_Lkp10_X=acosd(Lkp10(:,1)./norm_Lkp10);
Ang_Lkp10_Y=acosd(Lkp10(:,2)./norm_Lkp10);
Ang_Lkp10_Z=acosd(Lkp10(:,3)./norm_Lkp10);

norm_Lkp11=sum(abs(Lkp11).^2,2).^(1/2);
Ang_Lkp11_X=acosd(Lkp11(:,1)./norm_Lkp11);
Ang_Lkp11_Y=acosd(Lkp11(:,2)./norm_Lkp11);
Ang_Lkp11_Z=acosd(Lkp11(:,3)./norm_Lkp11);

norm_Lkp12=sum(abs(Lkp12).^2,2).^(1/2);
Ang_Lkp12_X=acosd(Lkp12(:,1)./norm_Lkp12);
Ang_Lkp12_Y=acosd(Lkp12(:,2)./norm_Lkp12);
Ang_Lkp12_Z=acosd(Lkp12(:,3)./norm_Lkp12);

norm_Lkp13=sum(abs(Lkp13).^2,2).^(1/2);
Ang_Lkp13_X=acosd(Lkp13(:,1)./norm_Lkp13);
Ang_Lkp13_Y=acosd(Lkp13(:,2)./norm_Lkp13);
Ang_Lkp13_Z=acosd(Lkp13(:,3)./norm_Lkp13);

norm_Lkp14=sum(abs(Lkp14).^2,2).^(1/2);
Ang_Lkp14_X=acosd(Lkp14(:,1)./norm_Lkp14);
Ang_Lkp14_Y=acosd(Lkp14(:,2)./norm_Lkp14);
Ang_Lkp14_Z=acosd(Lkp14(:,3)./norm_Lkp14);

norm_Lkp15=sum(abs(Lkp15).^2,2).^(1/2);
Ang_Lkp15_X=acosd(Lkp15(:,1)./norm_Lkp15);
Ang_Lkp15_Y=acosd(Lkp15(:,2)./norm_Lkp15);
Ang_Lkp15_Z=acosd(Lkp15(:,3)./norm_Lkp15);

norm_Lkp16=sum(abs(Lkp16).^2,2).^(1/2);
Ang_Lkp16_X=acosd(Lkp16(:,1)./norm_Lkp16);
Ang_Lkp16_Y=acosd(Lkp16(:,2)./norm_Lkp16);
Ang_Lkp16_Z=acosd(Lkp16(:,3)./norm_Lkp16);

norm_Lkp17=sum(abs(Lkp17).^2,2).^(1/2);
Ang_Lkp17_X=acosd(Lkp17(:,1)./norm_Lkp17);
Ang_Lkp17_Y=acosd(Lkp17(:,2)./norm_Lkp17);
Ang_Lkp17_Z=acosd(Lkp17(:,3)./norm_Lkp17);

norm_Lkp18=sum(abs(Lkp18).^2,2).^(1/2);
Ang_Lkp18_X=acosd(Lkp18(:,1)./norm_Lkp18);
Ang_Lkp18_Y=acosd(Lkp18(:,2)./norm_Lkp18);
Ang_Lkp18_Z=acosd(Lkp18(:,3)./norm_Lkp18);

norm_Lkp19=sum(abs(Lkp19).^2,2).^(1/2);
Ang_Lkp19_X=acosd(Lkp19(:,1)./norm_Lkp19);
Ang_Lkp19_Y=acosd(Lkp19(:,2)./norm_Lkp19);
Ang_Lkp19_Z=acosd(Lkp19(:,3)./norm_Lkp19);



% % % % % % % % % % % % % % % % % % % % % %��ʱ���ϵ�����

%��ʱ�������ϵľ�ֵ�����ֵ����Сֵ������ֵ��

%�ֲ�����
A_Mean_Lkp1(:,1)=mean(abs(diff(Ang_Lkp1_X)));
A_Mean_Lkp1(:,2)=mean(abs(diff(Ang_Lkp1_Y)));
A_Mean_Lkp1(:,3)=mean(abs(diff(Ang_Lkp1_Z)));
A_Var_Lkp1(:,1)=var(abs(diff(Ang_Lkp1_X)));
A_Var_Lkp1(:,2)=var(abs(diff(Ang_Lkp1_Y)));
A_Var_Lkp1(:,3)=var(abs(diff(Ang_Lkp1_Z)));
Lkp1_all=[A_Mean_Lkp1,A_Var_Lkp1];

A_Mean_Lkp2(:,1)=mean(abs(diff(Ang_Lkp2_X)));
A_Mean_Lkp2(:,2)=mean(abs(diff(Ang_Lkp2_Y)));
A_Mean_Lkp2(:,3)=mean(abs(diff(Ang_Lkp2_Z)));
A_Var_Lkp2(:,1)=var(abs(diff(Ang_Lkp2_X)));
A_Var_Lkp2(:,2)=var(abs(diff(Ang_Lkp2_Y)));
A_Var_Lkp2(:,3)=var(abs(diff(Ang_Lkp2_Z)));
Lkp2_all=[A_Mean_Lkp2,A_Var_Lkp2];

A_Mean_Lkp3(:,1)=mean(abs(diff(Ang_Lkp3_X)));
A_Mean_Lkp3(:,2)=mean(abs(diff(Ang_Lkp3_Y)));
A_Mean_Lkp3(:,3)=mean(abs(diff(Ang_Lkp3_Z)));
A_Var_Lkp3(:,1)=var(abs(diff(Ang_Lkp3_X)));
A_Var_Lkp3(:,2)=var(abs(diff(Ang_Lkp3_Y)));
A_Var_Lkp3(:,3)=var(abs(diff(Ang_Lkp3_Z)));
Lkp3_all=[A_Mean_Lkp3,A_Var_Lkp3];

A_Mean_Lkp4(:,1)=mean(abs(diff(Ang_Lkp4_X)));
A_Mean_Lkp4(:,2)=mean(abs(diff(Ang_Lkp4_Y)));
A_Mean_Lkp4(:,3)=mean(abs(diff(Ang_Lkp4_Z)));
A_Var_Lkp4(:,1)=var(abs(diff(Ang_Lkp4_X)));
A_Var_Lkp4(:,2)=var(abs(diff(Ang_Lkp4_Y)));
A_Var_Lkp4(:,3)=var(abs(diff(Ang_Lkp4_Z)));
Lkp4_all=[A_Mean_Lkp4,A_Var_Lkp4];

A_Mean_Lkp5(:,1)=mean(abs(diff(Ang_Lkp5_X)));
A_Mean_Lkp5(:,2)=mean(abs(diff(Ang_Lkp5_Y)));
A_Mean_Lkp5(:,3)=mean(abs(diff(Ang_Lkp5_Z)));
A_Var_Lkp5(:,1)=var(abs(diff(Ang_Lkp5_X)));
A_Var_Lkp5(:,2)=var(abs(diff(Ang_Lkp5_Y)));
A_Var_Lkp5(:,3)=var(abs(diff(Ang_Lkp5_Z)));
Lkp5_all=[A_Mean_Lkp5,A_Var_Lkp5];

A_Mean_Lkp6(:,1)=mean(abs(diff(Ang_Lkp6_X)));
A_Mean_Lkp6(:,2)=mean(abs(diff(Ang_Lkp6_Y)));
A_Mean_Lkp6(:,3)=mean(abs(diff(Ang_Lkp6_Z)));
A_Var_Lkp6(:,1)=var(abs(diff(Ang_Lkp6_X)));
A_Var_Lkp6(:,2)=var(abs(diff(Ang_Lkp6_Y)));
A_Var_Lkp6(:,3)=var(abs(diff(Ang_Lkp6_Z)));
Lkp6_all=[A_Mean_Lkp6,A_Var_Lkp6];

A_Mean_Lkp7(:,1)=mean(abs(diff(Ang_Lkp7_X)));
A_Mean_Lkp7(:,2)=mean(abs(diff(Ang_Lkp7_Y)));
A_Mean_Lkp7(:,3)=mean(abs(diff(Ang_Lkp7_Z)));
A_Var_Lkp7(:,1)=var(abs(diff(Ang_Lkp7_X)));
A_Var_Lkp7(:,2)=var(abs(diff(Ang_Lkp7_Y)));
A_Var_Lkp7(:,3)=var(abs(diff(Ang_Lkp7_Z)));
Lkp7_all=[A_Mean_Lkp7,A_Var_Lkp7];

A_Mean_Lkp8(:,1)=mean(abs(diff(Ang_Lkp8_X)));
A_Mean_Lkp8(:,2)=mean(abs(diff(Ang_Lkp8_Y)));
A_Mean_Lkp8(:,3)=mean(abs(diff(Ang_Lkp8_Z)));
A_Var_Lkp8(:,1)=var(abs(diff(Ang_Lkp8_X)));
A_Var_Lkp8(:,2)=var(abs(diff(Ang_Lkp8_Y)));
A_Var_Lkp8(:,3)=var(abs(diff(Ang_Lkp8_Z)));
Lkp8_all=[A_Mean_Lkp8,A_Var_Lkp8];

A_Mean_Lkp9(:,1)=mean(abs(diff(Ang_Lkp9_X)));
A_Mean_Lkp9(:,2)=mean(abs(diff(Ang_Lkp9_Y)));
A_Mean_Lkp9(:,3)=mean(abs(diff(Ang_Lkp9_Z)));
A_Var_Lkp9(:,1)=var(abs(diff(Ang_Lkp9_X)));
A_Var_Lkp9(:,2)=var(abs(diff(Ang_Lkp9_Y)));
A_Var_Lkp9(:,3)=var(abs(diff(Ang_Lkp9_Z)));
Lkp9_all=[A_Mean_Lkp9,A_Var_Lkp9];

A_Mean_Lkp10(:,1)=mean(abs(diff(Ang_Lkp10_X)));
A_Mean_Lkp10(:,2)=mean(abs(diff(Ang_Lkp10_Y)));
A_Mean_Lkp10(:,3)=mean(abs(diff(Ang_Lkp10_Z)));
A_Var_Lkp10(:,1)=var(abs(diff(Ang_Lkp10_X)));
A_Var_Lkp10(:,2)=var(abs(diff(Ang_Lkp10_Y)));
A_Var_Lkp10(:,3)=var(abs(diff(Ang_Lkp10_Z)));
Lkp10_all=[A_Mean_Lkp10,A_Var_Lkp10];

A_Mean_Lkp11(:,1)=mean(abs(diff(Ang_Lkp11_X)));
A_Mean_Lkp11(:,2)=mean(abs(diff(Ang_Lkp11_Y)));
A_Mean_Lkp11(:,3)=mean(abs(diff(Ang_Lkp11_Z)));
A_Var_Lkp11(:,1)=var(abs(diff(Ang_Lkp11_X)));
A_Var_Lkp11(:,2)=var(abs(diff(Ang_Lkp11_Y)));
A_Var_Lkp11(:,3)=var(abs(diff(Ang_Lkp11_Z)));
Lkp11_all=[A_Mean_Lkp11,A_Var_Lkp11];

A_Mean_Lkp12(:,1)=mean(abs(diff(Ang_Lkp12_X)));
A_Mean_Lkp12(:,2)=mean(abs(diff(Ang_Lkp12_Y)));
A_Mean_Lkp12(:,3)=mean(abs(diff(Ang_Lkp12_Z)));
A_Var_Lkp12(:,1)=var(abs(diff(Ang_Lkp12_X)));
A_Var_Lkp12(:,2)=var(abs(diff(Ang_Lkp12_Y)));
A_Var_Lkp12(:,3)=var(abs(diff(Ang_Lkp12_Z)));
Lkp12_all=[A_Mean_Lkp12,A_Var_Lkp12];

A_Mean_Lkp13(:,1)=mean(abs(diff(Ang_Lkp13_X)));
A_Mean_Lkp13(:,2)=mean(abs(diff(Ang_Lkp13_Y)));
A_Mean_Lkp13(:,3)=mean(abs(diff(Ang_Lkp13_Z)));
A_Var_Lkp13(:,1)=var(abs(diff(Ang_Lkp13_X)));
A_Var_Lkp13(:,2)=var(abs(diff(Ang_Lkp13_Y)));
A_Var_Lkp13(:,3)=var(abs(diff(Ang_Lkp13_Z)));
Lkp13_all=[A_Mean_Lkp13,A_Var_Lkp13];

A_Mean_Lkp14(:,1)=mean(abs(diff(Ang_Lkp14_X)));
A_Mean_Lkp14(:,2)=mean(abs(diff(Ang_Lkp14_Y)));
A_Mean_Lkp14(:,3)=mean(abs(diff(Ang_Lkp14_Z)));
A_Var_Lkp14(:,1)=var(abs(diff(Ang_Lkp14_X)));
A_Var_Lkp14(:,2)=var(abs(diff(Ang_Lkp14_Y)));
A_Var_Lkp14(:,3)=var(abs(diff(Ang_Lkp14_Z)));
Lkp14_all=[A_Mean_Lkp14,A_Var_Lkp14];

A_Mean_Lkp15(:,1)=mean(abs(diff(Ang_Lkp15_X)));
A_Mean_Lkp15(:,2)=mean(abs(diff(Ang_Lkp15_Y)));
A_Mean_Lkp15(:,3)=mean(abs(diff(Ang_Lkp15_Z)));
A_Var_Lkp15(:,1)=var(abs(diff(Ang_Lkp15_X)));
A_Var_Lkp15(:,2)=var(abs(diff(Ang_Lkp15_Y)));
A_Var_Lkp15(:,3)=var(abs(diff(Ang_Lkp15_Z)));
Lkp15_all=[A_Mean_Lkp15,A_Var_Lkp15];

A_Mean_Lkp16(:,1)=mean(abs(diff(Ang_Lkp16_X)));
A_Mean_Lkp16(:,2)=mean(abs(diff(Ang_Lkp16_Y)));
A_Mean_Lkp16(:,3)=mean(abs(diff(Ang_Lkp16_Z)));
A_Var_Lkp16(:,1)=var(abs(diff(Ang_Lkp16_X)));
A_Var_Lkp16(:,2)=var(abs(diff(Ang_Lkp16_Y)));
A_Var_Lkp16(:,3)=var(abs(diff(Ang_Lkp16_Z)));
Lkp16_all=[A_Mean_Lkp16,A_Var_Lkp16];

A_Mean_Lkp17(:,1)=mean(abs(diff(Ang_Lkp17_X)));
A_Mean_Lkp17(:,2)=mean(abs(diff(Ang_Lkp17_Y)));
A_Mean_Lkp17(:,3)=mean(abs(diff(Ang_Lkp17_Z)));
A_Var_Lkp17(:,1)=var(abs(diff(Ang_Lkp17_X)));
A_Var_Lkp17(:,2)=var(abs(diff(Ang_Lkp17_Y)));
A_Var_Lkp17(:,3)=var(abs(diff(Ang_Lkp17_Z)));
Lkp17_all=[A_Mean_Lkp17,A_Var_Lkp17];

A_Mean_Lkp18(:,1)=mean(abs(diff(Ang_Lkp18_X)));
A_Mean_Lkp18(:,2)=mean(abs(diff(Ang_Lkp18_Y)));
A_Mean_Lkp18(:,3)=mean(abs(diff(Ang_Lkp18_Z)));
A_Var_Lkp18(:,1)=var(abs(diff(Ang_Lkp18_X)));
A_Var_Lkp18(:,2)=var(abs(diff(Ang_Lkp18_Y)));
A_Var_Lkp18(:,3)=var(abs(diff(Ang_Lkp18_Z)));
Lkp18_all=[A_Mean_Lkp18,A_Var_Lkp18];

A_Mean_Lkp19(:,1)=mean(abs(diff(Ang_Lkp19_X)));
A_Mean_Lkp19(:,2)=mean(abs(diff(Ang_Lkp19_Y)));
A_Mean_Lkp19(:,3)=mean(abs(diff(Ang_Lkp19_Z)));
A_Var_Lkp19(:,1)=var(abs(diff(Ang_Lkp19_X)));
A_Var_Lkp19(:,2)=var(abs(diff(Ang_Lkp19_Y)));
A_Var_Lkp19(:,3)=var(abs(diff(Ang_Lkp19_Z)));
Lkp19_all=[A_Mean_Lkp19,A_Var_Lkp19];






Lkp_all(jj,:)=[Lkp1_all,Lkp2_all,Lkp3_all,Lkp4_all,Lkp5_all,Lkp6_all,Lkp7_all,Lkp8_all,Lkp9_all,Lkp10_all,Lkp11_all,Lkp12_all,Lkp13_all,Lkp14_all,Lkp15_all,Lkp16_all,Lkp17_all,Lkp18_all,Lkp19_all];








  end
  
   clearvars -except Bag_XL Bag_CS kk1 kk2 VK_XL VK_CS Lkp_all Lkp_XL
  
  

  
  
  
  

%��������5���ֹؽڵ������Ϣ����
VK_XL1st=[VK_XL(:,1),VK_XL(:,2),VK_XL(:,3)];
VK_XL2nd=[VK_XL(:,4),VK_XL(:,5),VK_XL(:,6),VK_XL(:,7)];
VK_XL3rd=[VK_XL(:,8),VK_XL(:,9),VK_XL(:,10),VK_XL(:,11)];
VK_XL4th=[VK_XL(:,12),VK_XL(:,13),VK_XL(:,14),VK_XL(:,15)];
VK_XL5th=[VK_XL(:,16),VK_XL(:,17),VK_XL(:,18),VK_XL(:,19)];
%��ȡ����5���ֹؽڵ�������������ֵ��
Max1st=max(VK_XL1st')';
Max2nd=max(VK_XL2nd')';
Max3rd=max(VK_XL3rd')';
Max4th=max(VK_XL4th')';
Max5th=max(VK_XL5th')';
%��ȡ����5���ֹؽڵ����������Ϊ1�С�
MaxVK_XL=[Max1st;Max2nd;Max3rd;Max4th;Max5th];

   clearvars -except Bag_XL Bag_CS kk1 kk2 VK_XL VK_CS MaxVK_XL Lkp_all Lkp_XL

%��������5���ֹؽڵ������Ϣ����
VK_CS1st=[VK_CS(:,1),VK_CS(:,2),VK_CS(:,3)];
VK_CS2nd=[VK_CS(:,4),VK_CS(:,5),VK_CS(:,6),VK_CS(:,7)];
VK_CS3rd=[VK_CS(:,8),VK_CS(:,9),VK_CS(:,10),VK_CS(:,11)];
VK_CS4th=[VK_CS(:,12),VK_CS(:,13),VK_CS(:,14),VK_CS(:,15)];
VK_CS5th=[VK_CS(:,16),VK_CS(:,17),VK_CS(:,18),VK_CS(:,19)];
%��ȡ����5���ֹؽڵ�������������ֵ��
Max1st=max(VK_CS1st')';
Max2nd=max(VK_CS2nd')';
Max3rd=max(VK_CS3rd')';
Max4th=max(VK_CS4th')';
Max5th=max(VK_CS5th')';
%��ȡ����5���ֹؽڵ����������Ϊ1�С�
MaxVK_CS=[Max1st;Max2nd;Max3rd;Max4th;Max5th];

   clearvars -except Bag_XL Bag_CS kk1 kk2 VK_XL VK_CS MaxVK_XL MaxVK_CS Lkp_all Lkp_XL



%��������5���ֹؽڵ��Ƿ����������߼�����
labels1= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1)]; %%��������������ǩ
labels2= [1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1)]; %%��������������ǩ
labels3= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1)]; %%��������������ǩ
labels4= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);1*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1)]; %%��������������ǩ
labels5= [0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1);0*ones(3,1)]; %%��������������ǩ
labels=[labels1;labels2;labels3;labels4;labels5];
CP_Data=[labels,MaxVK_XL];

clearvars -except Bag_XL Bag_CS kk1 kk2 VK_XL VK_CS MaxVK_XL MaxVK_CS CP_Data Lkp_all Lkp_XL



%%%%%%���Ա�ǩ
labels1= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);1*ones(29,1);0*ones(30,1);0*ones(20,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);1*ones(30,1)]; %%��������������ǩ
labels2= [1*ones(27,1);1*ones(27,1);1*ones(27,1);1*ones(26,1);1*ones(26,1);1*ones(26,1);1*ones(28,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(29,1);0*ones(30,1);0*ones(20,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1);1*ones(30,1)]; %%��������������ǩ
labels3= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(6,1);1*ones(3,1);0*ones(6,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(3,1);1*ones(3,1);0*ones(29,1);0*ones(30,1);0*ones(20,1);1*ones(30,1);0*ones(30,1);1*ones(30,1);1*ones(30,1);0*ones(30,1)]; %%��������������ǩ
labels4= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(29,1);1*ones(30,1);1*ones(20,1);1*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1)]; %%��������������ǩ
labels5= [0*ones(27,1);0*ones(27,1);0*ones(27,1);0*ones(26,1);0*ones(26,1);0*ones(26,1);0*ones(28,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(29,1);0*ones(30,1);0*ones(20,1);1*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1);0*ones(30,1)]; %%��������������ǩ
labels=[labels1;labels2;labels3;labels4;labels5];
AllDataCS=[labels,MaxVK_CS];

clearvars -except Bag_XL Bag_CS kk1 kk2 VK_XL VK_CS MaxVK_XL MaxVK_CS CP_Data AllDataCS Lkp_all Lkp_XL




%�߼��ع����
xl=CP_Data;
x=xl(:,2);
y=xl(:,1);
b =glmfit(x,y,'binomial', 'link', 'logit');
p = glmval(b,AllDataCS(:,2), 'logit');
clearvars P
P(p>=0.5)=1;
P(p<0.5)=0;
P=P';
%ʶ����
C = cfmatrix(AllDataCS(:,1),P);
AC=trace(C)/sum(sum(C))

% DB=[AllDataCS(:,1),P];
Plabels = [P(1:kk2),P(kk2+1:kk2*2),P(kk2*2+1:kk2*3),P(kk2*3+1:kk2*4),P(kk2*4+1:kk2*5)];


% % % XLlabels0= [1*ones(3,1);2*ones(3,1);3*ones(3,1);4*ones(3,1);5*ones(3,1);6*ones(3,1);7*ones(3,1);8*ones(3,1);9*ones(3,1);10*ones(3,1);11*ones(3,1);12*ones(6,1);13*ones(3,1);14*ones(3,1);15*ones(3,1);16*ones(3,1);17*ones(3,1);18*ones(3,1);19*ones(3,1);20*ones(3,1)]; %%��������������ǩ
% % % XLTZ_SVM=[XLlabels0,Lkp_XL];
labels0= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(30,1);11*ones(30,1);12*ones(30,1);13*ones(29,1);14*ones(30,1);15*ones(20,1);16*ones(30,1);17*ones(30,1);18*ones(30,1);19*ones(30,1);20*ones(30,1)]; %%��������������ǩ
TZ_acp=[labels0,Lkp_all];

%תΪ2����
V_CT_temp=num2str(Plabels);  
V_CT_temp=char(strrep(cellstr(V_CT_temp),' ',''));
V_CT_bin = bin2dec(V_CT_temp);





%������
CT_ID_Temp = find(V_CT_bin(:,1)==8); 
    TZJ=TZ_acp(CT_ID_Temp,:);
    TZJ1=TZJ(:,[1,20:43]);
%     TZJ1_XL=XLTZ_SVM(:,[1,20:43]);
A_XL=TZJ1_XL(:,2:end);   
A=TZJ1(:,2:end);

[AA,ps] = mapminmax(A_XL',0,1); %%��׼��
A_XL = AA';
[AA,ps] = mapminmax(A',0,1); %%��׼��
A = AA';


test_A=A;
test_A_labels=TZJ1(:,1);

train_A=A_XL;
train_A_labels=TZJ1_XL(:,1);

        [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_A_labels,train_A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);

    
    
    
CT_ID_Temp = find(V_CT_bin(:,1)==2); 
    TZJ=TZ_acp(CT_ID_Temp,:);
    TZJ2=TZJ(:,[1,13:16]);
    
    
    
    
    
    
CT_ID_Temp = find(V_CT_bin(:,1)==12); 
    TZJ=TZ_acp(CT_ID_Temp,:);
    TZJ3=TZJ(:,[1,5:12]);
    
    
    
    
CT_ID_Temp = find(V_CT_bin(:,1)==15); 
    TZJ4_PL=CT_ID_Temp;
CT_ID_Temp = find(V_CT_bin(:,1)==16);
    TZJ5_PL=CT_ID_Temp; 
CT_ID_Temp = find(V_CT_bin(:,1)==24);
    TZJ6_PL=CT_ID_Temp;   
    
    
    
CT_ID_Temp = find(V_CT_bin(:,1)~=24 & V_CT_bin(:,1)~=16 & V_CT_bin(:,1)~=15 & V_CT_bin(:,1)~=12 & V_CT_bin(:,1)~=2 & V_CT_bin(:,1)~=8);
    TZJ7=TZ_acp(CT_ID_Temp,:);
A1=TZJ7(:,2:end);
[AA,ps] = mapminmax(A1',0,1); %%��׼��
A1 = AA';
id=randperm(130,100);
test_A=A1(id,:);
test_A_labels=TZJ7(id,1);
train_A=A1;
train_A_labels=TZJ7(:,1);
        [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
        cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
        model = svmtrain(train_A_labels,train_A,cmdo);
        [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);

    
    
    
    
 
% % % 
% % % [M,N]=size(MaxVK);%%�������ά��
% % % indices = crossvalind('Kfold',MaxVK(1:M,N),30); 
% % % for k=1:30    %%//������֤k=100��100����������Ϊ���Լ�
% % % %       test_id = (indices == k); %%//���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
% % % %       train_id = ~test;%%//train��Ԫ�صı��Ϊ��testԪ�صı��
% % % train_id = (indices == k);
% % %         train_data=MaxVK(train_id,:);%%//�����ݼ��л��ֳ�train����������
% % %         train_labels=labels(train_id,:);%%//����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
% % % %         test_A=A(test,:);%%//test������
% % % %         test_A_labels=labels(test,:);
% % %    
% % % b =glmfit(train_data,train_labels,'binomial', 'link', 'logit');
% % % p = glmval(b,MaxVK, 'logit'); 
% % % P(p>=0.5)=1;
% % % P(p<0.5)=0;
% % % P=P';
% % % C = cfmatrix(labels,P);
% % % AC(k)=trace(C)/sum(sum(C))
% % % 
% % % clearvars -except labels MaxVK AC indices M N C
% % % 
% % % end
 




