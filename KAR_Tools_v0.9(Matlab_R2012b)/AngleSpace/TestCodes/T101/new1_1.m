clear;clc;
warning off
format long g %不采用科学计数法

list=dir(['MSRAction3DSkeletonReal3D\','*.txt']);
kk=length(list);
 for ii=1:kk
     str = strcat ('MSRAction3DSkeletonReal3D\', list(ii).name);
     Bag{ii}=load(str);
 end
 
 for jj=1:kk
     
 
 Number=jj
% % %  jj=111;
 A=Bag{jj};%载入数据
 
 
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

%消除人体尺寸归一化
A=A/



%数据清洗和补全
XX=size(A,1);
xx=(1:XX)';
for pp=1:60
spA=spap2(4,3,xx,A(:,pp));
D_spA = fnval(spA,xx);
A(:,pp)=D_spA;
% scatter(xx,A(:,6))
% fnplt(spA,'r');
end



for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

%转换成自身坐标系
%

%关节点局部坐标系
Lkp1=k20-k3;
% Lkp2=k3-k4;
% Lkp3=k4-k7;

% Lkp4=k13-k11;
Lkp5=k11-k9;
Lkp6=k9-k2;
% Lkp7=k2-k3;

% Lkp8=k12-k10;
Lkp9=k10-k8;
Lkp10=k8-k1;
% Lkp11=k1-k3;

% Lkp12=k19-k17;
Lkp13=k17-k15;
Lkp14=k15-k6;
% Lkp15=k6-k7;

% Lkp16=k18-k16;
Lkp17=k16-k14;
Lkp18=k14-k5;
% Lkp19=k5-k7;

%关节点自身坐标系
Mkp1=(k20+k3)/2-k7;
% Mkp2=(k3+k4)/2-k7;
% Mkp3=(k4+k7)/2-k7;
% Mkp4=(k13+k11)/2-k7;
Mkp5=(k11+k9)/2-k7;
Mkp6=(k9+k2)/2-k7;
% Mkp7=(k2+k3)/2-k7;
% Mkp8=(k12+k10)/2-k7;
Mkp9=(k10+k8)/2-k7;
Mkp10=(k8+k1)/2-k7;
% Mkp11=(k1+k3)/2-k7;
% Mkp12=(k19+k17)/2-k7;
Mkp13=(k17+k15)/2-k7;
Mkp14=(k15+k6)/2-k7;
% Mkp15=(k6+k7)/2-k7;
% Mkp16=(k18+k16)/2-k7;
Mkp17=(k16+k14)/2-k7;
Mkp18=(k14+k5)/2-k7;
% Mkp19=(k5+k7)/2-k7;

%关节点世界坐标系
Wkp=k7;


% % % kp1=k11-k9;
% % % kp2=k9-k2;
% % % kp3=k10-k8;
% % % kp4=k8-k1;
% % % 
% % % kp5=k17-k15;
% % % kp6=k15-k6;
% % % kp7=k16-k14;
% % % kp8=k14-k5;


% % % norm_kp1=sum(abs(kp1).^2,2).^(1/2);
% % % Ang_kp1_X=acosd(kp1(:,1)./norm_kp1);
% % % Ang_kp1_Y=acosd(kp1(:,2)./norm_kp1);
% % % Ang_kp1_Z=acosd(kp1(:,3)./norm_kp1);
% % % 
% % % norm_kp2=sum(abs(kp2).^2,2).^(1/2);
% % % Ang_kp2_X=acosd(kp2(:,1)./norm_kp2);
% % % Ang_kp2_Y=acosd(kp2(:,2)./norm_kp2);
% % % Ang_kp2_Z=acosd(kp2(:,3)./norm_kp2);
% % % 
% % % norm_kp3=sum(abs(kp3).^2,2).^(1/2);
% % % Ang_kp3_X=acosd(kp3(:,1)./norm_kp3);
% % % Ang_kp3_Y=acosd(kp3(:,2)./norm_kp3);
% % % Ang_kp3_Z=acosd(kp3(:,3)./norm_kp3);
% % % 
% % % norm_kp4=sum(abs(kp4).^2,2).^(1/2);
% % % Ang_kp4_X=acosd(kp4(:,1)./norm_kp4);
% % % Ang_kp4_Y=acosd(kp4(:,2)./norm_kp4);
% % % Ang_kp4_Z=acosd(kp4(:,3)./norm_kp4);
% % % 
% % % norm_kp5=sum(abs(kp5).^2,2).^(1/2);
% % % Ang_kp5_X=acosd(kp5(:,1)./norm_kp5);
% % % Ang_kp5_Y=acosd(kp5(:,2)./norm_kp5);
% % % Ang_kp5_Z=acosd(kp5(:,3)./norm_kp5);
% % % 
% % % norm_kp6=sum(abs(kp6).^2,2).^(1/2);
% % % Ang_kp6_X=acosd(kp6(:,1)./norm_kp6);
% % % Ang_kp6_Y=acosd(kp6(:,2)./norm_kp6);
% % % Ang_kp6_Z=acosd(kp6(:,3)./norm_kp6);
% % % 
% % % norm_kp7=sum(abs(kp7).^2,2).^(1/2);
% % % Ang_kp7_X=acosd(kp7(:,1)./norm_kp7);
% % % Ang_kp7_Y=acosd(kp7(:,2)./norm_kp7);
% % % Ang_kp7_Z=acosd(kp7(:,3)./norm_kp7);
% % % 
% % % norm_kp8=sum(abs(kp8).^2,2).^(1/2);
% % % Ang_kp8_X=acosd(kp8(:,1)./norm_kp8);
% % % Ang_kp8_Y=acosd(kp8(:,2)./norm_kp8);
% % % Ang_kp8_Z=acosd(kp8(:,3)./norm_kp8);




%关节点局部XYZ三轴角度偏移量

norm_Lkp1=sum(abs(Lkp1).^2,2).^(1/2);
Ang_Lkp1_X=acosd(Lkp1(:,1)./norm_Lkp1);
Ang_Lkp1_Y=acosd(Lkp1(:,2)./norm_Lkp1);
Ang_Lkp1_Z=acosd(Lkp1(:,3)./norm_Lkp1);

% norm_Lkp2=sum(abs(Lkp2).^2,2).^(1/2);
% Ang_Lkp2_X=acosd(Lkp2(:,1)./norm_Lkp2);
% Ang_Lkp2_Y=acosd(Lkp2(:,2)./norm_Lkp2);
% Ang_Lkp2_Z=acosd(Lkp2(:,3)./norm_Lkp2);
% 
% norm_Lkp3=sum(abs(Lkp3).^2,2).^(1/2);
% Ang_Lkp3_X=acosd(Lkp3(:,1)./norm_Lkp3);
% Ang_Lkp3_Y=acosd(Lkp3(:,2)./norm_Lkp3);
% Ang_Lkp3_Z=acosd(Lkp3(:,3)./norm_Lkp3);
% 
% norm_Lkp4=sum(abs(Lkp4).^2,2).^(1/2);
% Ang_Lkp4_X=acosd(Lkp4(:,1)./norm_Lkp4);
% Ang_Lkp4_Y=acosd(Lkp4(:,2)./norm_Lkp4);
% Ang_Lkp4_Z=acosd(Lkp4(:,3)./norm_Lkp4);

norm_Lkp5=sum(abs(Lkp5).^2,2).^(1/2);
Ang_Lkp5_X=acosd(Lkp5(:,1)./norm_Lkp5);
Ang_Lkp5_Y=acosd(Lkp5(:,2)./norm_Lkp5);
Ang_Lkp5_Z=acosd(Lkp5(:,3)./norm_Lkp5);

norm_Lkp6=sum(abs(Lkp6).^2,2).^(1/2);
Ang_Lkp6_X=acosd(Lkp6(:,1)./norm_Lkp6);
Ang_Lkp6_Y=acosd(Lkp6(:,2)./norm_Lkp6);
Ang_Lkp6_Z=acosd(Lkp6(:,3)./norm_Lkp6);

% norm_Lkp7=sum(abs(Lkp7).^2,2).^(1/2);
% Ang_Lkp7_X=acosd(Lkp7(:,1)./norm_Lkp7);
% Ang_Lkp7_Y=acosd(Lkp7(:,2)./norm_Lkp7);
% Ang_Lkp7_Z=acosd(Lkp7(:,3)./norm_Lkp7);
% 
% norm_Lkp8=sum(abs(Lkp8).^2,2).^(1/2);
% Ang_Lkp8_X=acosd(Lkp8(:,1)./norm_Lkp8);
% Ang_Lkp8_Y=acosd(Lkp8(:,2)./norm_Lkp8);
% Ang_Lkp8_Z=acosd(Lkp8(:,3)./norm_Lkp8);

norm_Lkp9=sum(abs(Lkp9).^2,2).^(1/2);
Ang_Lkp9_X=acosd(Lkp9(:,1)./norm_Lkp9);
Ang_Lkp9_Y=acosd(Lkp9(:,2)./norm_Lkp9);
Ang_Lkp9_Z=acosd(Lkp9(:,3)./norm_Lkp9);

norm_Lkp10=sum(abs(Lkp10).^2,2).^(1/2);
Ang_Lkp10_X=acosd(Lkp10(:,1)./norm_Lkp10);
Ang_Lkp10_Y=acosd(Lkp10(:,2)./norm_Lkp10);
Ang_Lkp10_Z=acosd(Lkp10(:,3)./norm_Lkp10);

% norm_Lkp11=sum(abs(Lkp11).^2,2).^(1/2);
% Ang_Lkp11_X=acosd(Lkp11(:,1)./norm_Lkp11);
% Ang_Lkp11_Y=acosd(Lkp11(:,2)./norm_Lkp11);
% Ang_Lkp11_Z=acosd(Lkp11(:,3)./norm_Lkp11);
% 
% norm_Lkp12=sum(abs(Lkp12).^2,2).^(1/2);
% Ang_Lkp12_X=acosd(Lkp12(:,1)./norm_Lkp12);
% Ang_Lkp12_Y=acosd(Lkp12(:,2)./norm_Lkp12);
% Ang_Lkp12_Z=acosd(Lkp12(:,3)./norm_Lkp12);

norm_Lkp13=sum(abs(Lkp13).^2,2).^(1/2);
Ang_Lkp13_X=acosd(Lkp13(:,1)./norm_Lkp13);
Ang_Lkp13_Y=acosd(Lkp13(:,2)./norm_Lkp13);
Ang_Lkp13_Z=acosd(Lkp13(:,3)./norm_Lkp13);

norm_Lkp14=sum(abs(Lkp14).^2,2).^(1/2);
Ang_Lkp14_X=acosd(Lkp14(:,1)./norm_Lkp14);
Ang_Lkp14_Y=acosd(Lkp14(:,2)./norm_Lkp14);
Ang_Lkp14_Z=acosd(Lkp14(:,3)./norm_Lkp14);

% norm_Lkp15=sum(abs(Lkp15).^2,2).^(1/2);
% Ang_Lkp15_X=acosd(Lkp15(:,1)./norm_Lkp15);
% Ang_Lkp15_Y=acosd(Lkp15(:,2)./norm_Lkp15);
% Ang_Lkp15_Z=acosd(Lkp15(:,3)./norm_Lkp15);
% 
% norm_Lkp16=sum(abs(Lkp16).^2,2).^(1/2);
% Ang_Lkp16_X=acosd(Lkp16(:,1)./norm_Lkp16);
% Ang_Lkp16_Y=acosd(Lkp16(:,2)./norm_Lkp16);
% Ang_Lkp16_Z=acosd(Lkp16(:,3)./norm_Lkp16);

norm_Lkp17=sum(abs(Lkp17).^2,2).^(1/2);
Ang_Lkp17_X=acosd(Lkp17(:,1)./norm_Lkp17);
Ang_Lkp17_Y=acosd(Lkp17(:,2)./norm_Lkp17);
Ang_Lkp17_Z=acosd(Lkp17(:,3)./norm_Lkp17);

norm_Lkp18=sum(abs(Lkp18).^2,2).^(1/2);
Ang_Lkp18_X=acosd(Lkp18(:,1)./norm_Lkp18);
Ang_Lkp18_Y=acosd(Lkp18(:,2)./norm_Lkp18);
Ang_Lkp18_Z=acosd(Lkp18(:,3)./norm_Lkp18);

% norm_Lkp19=sum(abs(Lkp19).^2,2).^(1/2);
% Ang_Lkp19_X=acosd(Lkp19(:,1)./norm_Lkp19);
% Ang_Lkp19_Y=acosd(Lkp19(:,2)./norm_Lkp19);
% Ang_Lkp19_Z=acosd(Lkp19(:,3)./norm_Lkp19);




%关节点自身XYZ三轴角度偏移量
norm_Mkp1=sum(abs(Mkp1).^2,2).^(1/2);
Ang_Mkp1_X=acosd(Mkp1(:,1)./norm_Mkp1);
Ang_Mkp1_Y=acosd(Mkp1(:,2)./norm_Mkp1);
Ang_Mkp1_Z=acosd(Mkp1(:,3)./norm_Mkp1);

% norm_Mkp2=sum(abs(Mkp2).^2,2).^(1/2);
% Ang_Mkp2_X=acosd(Mkp2(:,1)./norm_Mkp2);
% Ang_Mkp2_Y=acosd(Mkp2(:,2)./norm_Mkp2);
% Ang_Mkp2_Z=acosd(Mkp2(:,3)./norm_Mkp2);
% 
% norm_Mkp3=sum(abs(Mkp3).^2,2).^(1/2);
% Ang_Mkp3_X=acosd(Mkp3(:,1)./norm_Mkp3);
% Ang_Mkp3_Y=acosd(Mkp3(:,2)./norm_Mkp3);
% Ang_Mkp3_Z=acosd(Mkp3(:,3)./norm_Mkp3);
% 
% norm_Mkp4=sum(abs(Mkp4).^2,2).^(1/2);
% Ang_Mkp4_X=acosd(Mkp4(:,1)./norm_Mkp4);
% Ang_Mkp4_Y=acosd(Mkp4(:,2)./norm_Mkp4);
% Ang_Mkp4_Z=acosd(Mkp4(:,3)./norm_Mkp4);

norm_Mkp5=sum(abs(Mkp5).^2,2).^(1/2);
Ang_Mkp5_X=acosd(Mkp5(:,1)./norm_Mkp5);
Ang_Mkp5_Y=acosd(Mkp5(:,2)./norm_Mkp5);
Ang_Mkp5_Z=acosd(Mkp5(:,3)./norm_Mkp5);

norm_Mkp6=sum(abs(Mkp6).^2,2).^(1/2);
Ang_Mkp6_X=acosd(Mkp6(:,1)./norm_Mkp6);
Ang_Mkp6_Y=acosd(Mkp6(:,2)./norm_Mkp6);
Ang_Mkp6_Z=acosd(Mkp6(:,3)./norm_Mkp6);

% norm_Mkp7=sum(abs(Mkp7).^2,2).^(1/2);
% Ang_Mkp7_X=acosd(Mkp7(:,1)./norm_Mkp7);
% Ang_Mkp7_Y=acosd(Mkp7(:,2)./norm_Mkp7);
% Ang_Mkp7_Z=acosd(Mkp7(:,3)./norm_Mkp7);
% 
% norm_Mkp8=sum(abs(Mkp8).^2,2).^(1/2);
% Ang_Mkp8_X=acosd(Mkp8(:,1)./norm_Mkp8);
% Ang_Mkp8_Y=acosd(Mkp8(:,2)./norm_Mkp8);
% Ang_Mkp8_Z=acosd(Mkp8(:,3)./norm_Mkp8);

norm_Mkp9=sum(abs(Mkp9).^2,2).^(1/2);
Ang_Mkp9_X=acosd(Mkp9(:,1)./norm_Mkp9);
Ang_Mkp9_Y=acosd(Mkp9(:,2)./norm_Mkp9);
Ang_Mkp9_Z=acosd(Mkp9(:,3)./norm_Mkp9);

norm_Mkp10=sum(abs(Mkp10).^2,2).^(1/2);
Ang_Mkp10_X=acosd(Mkp10(:,1)./norm_Mkp10);
Ang_Mkp10_Y=acosd(Mkp10(:,2)./norm_Mkp10);
Ang_Mkp10_Z=acosd(Mkp10(:,3)./norm_Mkp10);

% norm_Mkp11=sum(abs(Mkp11).^2,2).^(1/2);
% Ang_Mkp11_X=acosd(Mkp11(:,1)./norm_Mkp11);
% Ang_Mkp11_Y=acosd(Mkp11(:,2)./norm_Mkp11);
% Ang_Mkp11_Z=acosd(Mkp11(:,3)./norm_Mkp11);
% 
% norm_Mkp12=sum(abs(Mkp12).^2,2).^(1/2);
% Ang_Mkp12_X=acosd(Mkp12(:,1)./norm_Mkp12);
% Ang_Mkp12_Y=acosd(Mkp12(:,2)./norm_Mkp12);
% Ang_Mkp12_Z=acosd(Mkp12(:,3)./norm_Mkp12);

norm_Mkp13=sum(abs(Mkp13).^2,2).^(1/2);
Ang_Mkp13_X=acosd(Mkp13(:,1)./norm_Mkp13);
Ang_Mkp13_Y=acosd(Mkp13(:,2)./norm_Mkp13);
Ang_Mkp13_Z=acosd(Mkp13(:,3)./norm_Mkp13);

norm_Mkp14=sum(abs(Mkp14).^2,2).^(1/2);
Ang_Mkp14_X=acosd(Mkp14(:,1)./norm_Mkp14);
Ang_Mkp14_Y=acosd(Mkp14(:,2)./norm_Mkp14);
Ang_Mkp14_Z=acosd(Mkp14(:,3)./norm_Mkp14);

% norm_Mkp15=sum(abs(Mkp15).^2,2).^(1/2);
% Ang_Mkp15_X=acosd(Mkp15(:,1)./norm_Mkp15);
% Ang_Mkp15_Y=acosd(Mkp15(:,2)./norm_Mkp15);
% Ang_Mkp15_Z=acosd(Mkp15(:,3)./norm_Mkp15);
% 
% norm_Mkp16=sum(abs(Mkp16).^2,2).^(1/2);
% Ang_Mkp16_X=acosd(Mkp16(:,1)./norm_Mkp16);
% Ang_Mkp16_Y=acosd(Mkp16(:,2)./norm_Mkp16);
% Ang_Mkp16_Z=acosd(Mkp16(:,3)./norm_Mkp16);

norm_Mkp17=sum(abs(Mkp17).^2,2).^(1/2);
Ang_Mkp17_X=acosd(Mkp17(:,1)./norm_Mkp17);
Ang_Mkp17_Y=acosd(Mkp17(:,2)./norm_Mkp17);
Ang_Mkp17_Z=acosd(Mkp17(:,3)./norm_Mkp17);

norm_Mkp18=sum(abs(Mkp18).^2,2).^(1/2);
Ang_Mkp18_X=acosd(Mkp18(:,1)./norm_Mkp18);
Ang_Mkp18_Y=acosd(Mkp18(:,2)./norm_Mkp18);
Ang_Mkp18_Z=acosd(Mkp18(:,3)./norm_Mkp18);

% norm_Mkp19=sum(abs(Mkp19).^2,2).^(1/2);
% Ang_Mkp19_X=acosd(Mkp19(:,1)./norm_Mkp19);
% Ang_Mkp19_Y=acosd(Mkp19(:,2)./norm_Mkp19);
% Ang_Mkp19_Z=acosd(Mkp19(:,3)./norm_Mkp19);



%关节点世界XYZ三轴角度偏移量
norm_Wkp=sum(abs(Wkp).^2,2).^(1/2);
Ang_Wkp_X=acosd(Wkp(:,1)./norm_Wkp);
Ang_Wkp_Y=acosd(Wkp(:,2)./norm_Wkp);
Ang_Wkp_Z=acosd(Wkp(:,3)./norm_Wkp);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % jj=1; 调试
%求时间上的特征

% % % Max_kp1=max(diff(kp1));
% % % A_Max_kp1(:,1)=max(diff(Ang_kp1_X));
% % % A_Max_kp1(:,2)=max(diff(Ang_kp1_Y));
% % % A_Max_kp1(:,3)=max(diff(Ang_kp1_Z));
% % % 
% % % Max_kp2=max(diff(kp2));
% % % A_Max_kp2(:,1)=max(diff(Ang_kp2_X));
% % % A_Max_kp2(:,2)=max(diff(Ang_kp2_Y));
% % % A_Max_kp2(:,3)=max(diff(Ang_kp2_Z));
% % % 
% % % Max_kp3=max(diff(kp3));
% % % A_Max_kp3(:,1)=max(diff(Ang_kp3_X));
% % % A_Max_kp3(:,2)=max(diff(Ang_kp3_Y));
% % % A_Max_kp3(:,3)=max(diff(Ang_kp3_Z));
% % % 
% % % Max_kp4=max(diff(kp4));
% % % A_Max_kp4(:,1)=max(diff(Ang_kp4_X));
% % % A_Max_kp4(:,2)=max(diff(Ang_kp4_Y));
% % % A_Max_kp4(:,3)=max(diff(Ang_kp4_Z));
% % % 
% % % Max_kp5=max(diff(kp5));
% % % A_Max_kp5(:,1)=max(diff(Ang_kp5_X));
% % % A_Max_kp5(:,2)=max(diff(Ang_kp5_Y));
% % % A_Max_kp5(:,3)=max(diff(Ang_kp5_Z));
% % % 
% % % Max_kp6=max(diff(kp6));
% % % A_Max_kp6(:,1)=max(diff(Ang_kp6_X));
% % % A_Max_kp6(:,2)=max(diff(Ang_kp6_Y));
% % % A_Max_kp6(:,3)=max(diff(Ang_kp6_Z));
% % % 
% % % Max_kp7=max(diff(kp7));
% % % A_Max_kp7(:,1)=max(diff(Ang_kp7_X));
% % % A_Max_kp7(:,2)=max(diff(Ang_kp7_Y));
% % % A_Max_kp7(:,3)=max(diff(Ang_kp7_Z));
% % % 
% % % Max_kp8=max(diff(kp8));
% % % A_Max_kp8(:,1)=max(diff(Ang_kp8_X));
% % % A_Max_kp8(:,2)=max(diff(Ang_kp8_Y));
% % % A_Max_kp8(:,3)=max(diff(Ang_kp8_Z));

% % % % % % % % % % % % % % % % % % % % % %求时间上的特征

%求时间序列上的均值，最大值，最小值，方差值。

%局部特征
% S_Mean_Lkp1=mean(diff(Lkp1));
% S_Max_Lkp1=max(diff(Lkp1));
% S_Min_Lkp1=min(diff(Lkp1));
% S_Var_Lkp1=var(diff(Lkp1));
A_Mean_Lkp1(:,1)=mean(diff(Ang_Lkp1_X));
A_Mean_Lkp1(:,2)=mean(diff(Ang_Lkp1_Y));
A_Mean_Lkp1(:,3)=mean(diff(Ang_Lkp1_Z));
A_Max_Lkp1(:,1)=max(diff(Ang_Lkp1_X));
A_Max_Lkp1(:,2)=max(diff(Ang_Lkp1_Y));
A_Max_Lkp1(:,3)=max(diff(Ang_Lkp1_Z));
A_Min_Lkp1(:,1)=min(diff(Ang_Lkp1_X));
A_Min_Lkp1(:,2)=min(diff(Ang_Lkp1_Y));
A_Min_Lkp1(:,3)=min(diff(Ang_Lkp1_Z));
A_Var_Lkp1(:,1)=var(diff(Ang_Lkp1_X));
A_Var_Lkp1(:,2)=var(diff(Ang_Lkp1_Y));
A_Var_Lkp1(:,3)=var(diff(Ang_Lkp1_Z));
% Lkp1_all=[S_Mean_Lkp1,S_Max_Lkp1,S_Min_Lkp1,S_Var_Lkp1,A_Mean_Lkp1,A_Max_Lkp1,A_Min_Lkp1,A_Var_Lkp1];
Lkp1_all=[A_Mean_Lkp1,A_Max_Lkp1,A_Min_Lkp1,A_Var_Lkp1];

% S_Mean_Lkp2=mean(diff(Lkp2));
% S_Max_Lkp2=max(diff(Lkp2));
% S_Min_Lkp2=min(diff(Lkp2));
% S_Var_Lkp2=var(diff(Lkp2));
% A_Mean_Lkp2(:,1)=mean(diff(Ang_Lkp2_X));
% A_Mean_Lkp2(:,2)=mean(diff(Ang_Lkp2_Y));
% A_Mean_Lkp2(:,3)=mean(diff(Ang_Lkp2_Z));
% A_Max_Lkp2(:,1)=max(diff(Ang_Lkp2_X));
% A_Max_Lkp2(:,2)=max(diff(Ang_Lkp2_Y));
% A_Max_Lkp2(:,3)=max(diff(Ang_Lkp2_Z));
% A_Min_Lkp2(:,1)=min(diff(Ang_Lkp2_X));
% A_Min_Lkp2(:,2)=min(diff(Ang_Lkp2_Y));
% A_Min_Lkp2(:,3)=min(diff(Ang_Lkp2_Z));
% A_Var_Lkp2(:,1)=var(diff(Ang_Lkp2_X));
% A_Var_Lkp2(:,2)=var(diff(Ang_Lkp2_Y));
% A_Var_Lkp2(:,3)=var(diff(Ang_Lkp2_Z));
% Lkp2_all=[S_Mean_Lkp2,S_Max_Lkp2,S_Min_Lkp2,S_Var_Lkp2,A_Mean_Lkp2,A_Max_Lkp2,A_Min_Lkp2,A_Var_Lkp2];
% 
% 
% S_Mean_Lkp3=mean(diff(Lkp3));
% S_Max_Lkp3=max(diff(Lkp3));
% S_Min_Lkp3=min(diff(Lkp3));
% S_Var_Lkp3=var(diff(Lkp3));
% A_Mean_Lkp3(:,1)=mean(diff(Ang_Lkp3_X));
% A_Mean_Lkp3(:,2)=mean(diff(Ang_Lkp3_Y));
% A_Mean_Lkp3(:,3)=mean(diff(Ang_Lkp3_Z));
% A_Max_Lkp3(:,1)=max(diff(Ang_Lkp3_X));
% A_Max_Lkp3(:,2)=max(diff(Ang_Lkp3_Y));
% A_Max_Lkp3(:,3)=max(diff(Ang_Lkp3_Z));
% A_Min_Lkp3(:,1)=min(diff(Ang_Lkp3_X));
% A_Min_Lkp3(:,2)=min(diff(Ang_Lkp3_Y));
% A_Min_Lkp3(:,3)=min(diff(Ang_Lkp3_Z));
% A_Var_Lkp3(:,1)=var(diff(Ang_Lkp3_X));
% A_Var_Lkp3(:,2)=var(diff(Ang_Lkp3_Y));
% A_Var_Lkp3(:,3)=var(diff(Ang_Lkp3_Z));
% Lkp3_all=[S_Mean_Lkp3,S_Max_Lkp3,S_Min_Lkp3,S_Var_Lkp3,A_Mean_Lkp3,A_Max_Lkp3,A_Min_Lkp3,A_Var_Lkp3];
% 
% 
% S_Mean_Lkp4=mean(diff(Lkp4));
% S_Max_Lkp4=max(diff(Lkp4));
% S_Min_Lkp4=min(diff(Lkp4));
% S_Var_Lkp4=var(diff(Lkp4));
% A_Mean_Lkp4(:,1)=mean(diff(Ang_Lkp4_X));
% A_Mean_Lkp4(:,2)=mean(diff(Ang_Lkp4_Y));
% A_Mean_Lkp4(:,3)=mean(diff(Ang_Lkp4_Z));
% A_Max_Lkp4(:,1)=max(diff(Ang_Lkp4_X));
% A_Max_Lkp4(:,2)=max(diff(Ang_Lkp4_Y));
% A_Max_Lkp4(:,3)=max(diff(Ang_Lkp4_Z));
% A_Min_Lkp4(:,1)=min(diff(Ang_Lkp4_X));
% A_Min_Lkp4(:,2)=min(diff(Ang_Lkp4_Y));
% A_Min_Lkp4(:,3)=min(diff(Ang_Lkp4_Z));
% A_Var_Lkp4(:,1)=var(diff(Ang_Lkp4_X));
% A_Var_Lkp4(:,2)=var(diff(Ang_Lkp4_Y));
% A_Var_Lkp4(:,3)=var(diff(Ang_Lkp4_Z));
% Lkp4_all=[S_Mean_Lkp4,S_Max_Lkp4,S_Min_Lkp4,S_Var_Lkp4,A_Mean_Lkp4,A_Max_Lkp4,A_Min_Lkp4,A_Var_Lkp4];


% S_Mean_Lkp5=mean(diff(Lkp5));
% S_Max_Lkp5=max(diff(Lkp5));
% S_Min_Lkp5=min(diff(Lkp5));
% S_Var_Lkp5=var(diff(Lkp5));
A_Mean_Lkp5(:,1)=mean(diff(Ang_Lkp5_X));
A_Mean_Lkp5(:,2)=mean(diff(Ang_Lkp5_Y));
A_Mean_Lkp5(:,3)=mean(diff(Ang_Lkp5_Z));
A_Max_Lkp5(:,1)=max(diff(Ang_Lkp5_X));
A_Max_Lkp5(:,2)=max(diff(Ang_Lkp5_Y));
A_Max_Lkp5(:,3)=max(diff(Ang_Lkp5_Z));
A_Min_Lkp5(:,1)=min(diff(Ang_Lkp5_X));
A_Min_Lkp5(:,2)=min(diff(Ang_Lkp5_Y));
A_Min_Lkp5(:,3)=min(diff(Ang_Lkp5_Z));
A_Var_Lkp5(:,1)=var(diff(Ang_Lkp5_X));
A_Var_Lkp5(:,2)=var(diff(Ang_Lkp5_Y));
A_Var_Lkp5(:,3)=var(diff(Ang_Lkp5_Z));
% Lkp5_all=[S_Mean_Lkp5,S_Max_Lkp5,S_Min_Lkp5,S_Var_Lkp5,A_Mean_Lkp5,A_Max_Lkp5,A_Min_Lkp5,A_Var_Lkp5];
Lkp5_all=[A_Mean_Lkp5,A_Max_Lkp5,A_Min_Lkp5,A_Var_Lkp5];


% S_Mean_Lkp6=mean(diff(Lkp6));
% S_Max_Lkp6=max(diff(Lkp6));
% S_Min_Lkp6=min(diff(Lkp6));
% S_Var_Lkp6=var(diff(Lkp6));
A_Mean_Lkp6(:,1)=mean(diff(Ang_Lkp6_X));
A_Mean_Lkp6(:,2)=mean(diff(Ang_Lkp6_Y));
A_Mean_Lkp6(:,3)=mean(diff(Ang_Lkp6_Z));
A_Max_Lkp6(:,1)=max(diff(Ang_Lkp6_X));
A_Max_Lkp6(:,2)=max(diff(Ang_Lkp6_Y));
A_Max_Lkp6(:,3)=max(diff(Ang_Lkp6_Z));
A_Min_Lkp6(:,1)=min(diff(Ang_Lkp6_X));
A_Min_Lkp6(:,2)=min(diff(Ang_Lkp6_Y));
A_Min_Lkp6(:,3)=min(diff(Ang_Lkp6_Z));
A_Var_Lkp6(:,1)=var(diff(Ang_Lkp6_X));
A_Var_Lkp6(:,2)=var(diff(Ang_Lkp6_Y));
A_Var_Lkp6(:,3)=var(diff(Ang_Lkp6_Z));
% Lkp6_all=[S_Mean_Lkp6,S_Max_Lkp6,S_Min_Lkp6,S_Var_Lkp6,A_Mean_Lkp6,A_Max_Lkp6,A_Min_Lkp6,A_Var_Lkp6];
Lkp6_all=[A_Mean_Lkp6,A_Max_Lkp6,A_Min_Lkp6,A_Var_Lkp6];


% S_Mean_Lkp7=mean(diff(Lkp7));
% S_Max_Lkp7=max(diff(Lkp7));
% S_Min_Lkp7=min(diff(Lkp7));
% S_Var_Lkp7=var(diff(Lkp7));
% A_Mean_Lkp7(:,1)=mean(diff(Ang_Lkp7_X));
% A_Mean_Lkp7(:,2)=mean(diff(Ang_Lkp7_Y));
% A_Mean_Lkp7(:,3)=mean(diff(Ang_Lkp7_Z));
% A_Max_Lkp7(:,1)=max(diff(Ang_Lkp7_X));
% A_Max_Lkp7(:,2)=max(diff(Ang_Lkp7_Y));
% A_Max_Lkp7(:,3)=max(diff(Ang_Lkp7_Z));
% A_Min_Lkp7(:,1)=min(diff(Ang_Lkp7_X));
% A_Min_Lkp7(:,2)=min(diff(Ang_Lkp7_Y));
% A_Min_Lkp7(:,3)=min(diff(Ang_Lkp7_Z));
% A_Var_Lkp7(:,1)=var(diff(Ang_Lkp7_X));
% A_Var_Lkp7(:,2)=var(diff(Ang_Lkp7_Y));
% A_Var_Lkp7(:,3)=var(diff(Ang_Lkp7_Z));
% Lkp7_all=[S_Mean_Lkp7,S_Max_Lkp7,S_Min_Lkp7,S_Var_Lkp7,A_Mean_Lkp7,A_Max_Lkp7,A_Min_Lkp7,A_Var_Lkp7];
% 
% 
% S_Mean_Lkp8=mean(diff(Lkp8));
% S_Max_Lkp8=max(diff(Lkp8));
% S_Min_Lkp8=min(diff(Lkp8));
% S_Var_Lkp8=var(diff(Lkp8));
% A_Mean_Lkp8(:,1)=mean(diff(Ang_Lkp8_X));
% A_Mean_Lkp8(:,2)=mean(diff(Ang_Lkp8_Y));
% A_Mean_Lkp8(:,3)=mean(diff(Ang_Lkp8_Z));
% A_Max_Lkp8(:,1)=max(diff(Ang_Lkp8_X));
% A_Max_Lkp8(:,2)=max(diff(Ang_Lkp8_Y));
% A_Max_Lkp8(:,3)=max(diff(Ang_Lkp8_Z));
% A_Min_Lkp8(:,1)=min(diff(Ang_Lkp8_X));
% A_Min_Lkp8(:,2)=min(diff(Ang_Lkp8_Y));
% A_Min_Lkp8(:,3)=min(diff(Ang_Lkp8_Z));
% A_Var_Lkp8(:,1)=var(diff(Ang_Lkp8_X));
% A_Var_Lkp8(:,2)=var(diff(Ang_Lkp8_Y));
% A_Var_Lkp8(:,3)=var(diff(Ang_Lkp8_Z));
% Lkp8_all=[S_Mean_Lkp8,S_Max_Lkp8,S_Min_Lkp8,S_Var_Lkp8,A_Mean_Lkp8,A_Max_Lkp8,A_Min_Lkp8,A_Var_Lkp8];


% S_Mean_Lkp9=mean(diff(Lkp9));
% S_Max_Lkp9=max(diff(Lkp9));
% S_Min_Lkp9=min(diff(Lkp9));
% S_Var_Lkp9=var(diff(Lkp9));
A_Mean_Lkp9(:,1)=mean(diff(Ang_Lkp9_X));
A_Mean_Lkp9(:,2)=mean(diff(Ang_Lkp9_Y));
A_Mean_Lkp9(:,3)=mean(diff(Ang_Lkp9_Z));
A_Max_Lkp9(:,1)=max(diff(Ang_Lkp9_X));
A_Max_Lkp9(:,2)=max(diff(Ang_Lkp9_Y));
A_Max_Lkp9(:,3)=max(diff(Ang_Lkp9_Z));
A_Min_Lkp9(:,1)=min(diff(Ang_Lkp9_X));
A_Min_Lkp9(:,2)=min(diff(Ang_Lkp9_Y));
A_Min_Lkp9(:,3)=min(diff(Ang_Lkp9_Z));
A_Var_Lkp9(:,1)=var(diff(Ang_Lkp9_X));
A_Var_Lkp9(:,2)=var(diff(Ang_Lkp9_Y));
A_Var_Lkp9(:,3)=var(diff(Ang_Lkp9_Z));
% Lkp9_all=[S_Mean_Lkp9,S_Max_Lkp9,S_Min_Lkp9,S_Var_Lkp9,A_Mean_Lkp9,A_Max_Lkp9,A_Min_Lkp9,A_Var_Lkp9];
Lkp9_all=[A_Mean_Lkp9,A_Max_Lkp9,A_Min_Lkp9,A_Var_Lkp9];


% S_Mean_Lkp10=mean(diff(Lkp10));
% S_Max_Lkp10=max(diff(Lkp10));
% S_Min_Lkp10=min(diff(Lkp10));
% S_Var_Lkp10=var(diff(Lkp10));
A_Mean_Lkp10(:,1)=mean(diff(Ang_Lkp10_X));
A_Mean_Lkp10(:,2)=mean(diff(Ang_Lkp10_Y));
A_Mean_Lkp10(:,3)=mean(diff(Ang_Lkp10_Z));
A_Max_Lkp10(:,1)=max(diff(Ang_Lkp10_X));
A_Max_Lkp10(:,2)=max(diff(Ang_Lkp10_Y));
A_Max_Lkp10(:,3)=max(diff(Ang_Lkp10_Z));
A_Min_Lkp10(:,1)=min(diff(Ang_Lkp10_X));
A_Min_Lkp10(:,2)=min(diff(Ang_Lkp10_Y));
A_Min_Lkp10(:,3)=min(diff(Ang_Lkp10_Z));
A_Var_Lkp10(:,1)=var(diff(Ang_Lkp10_X));
A_Var_Lkp10(:,2)=var(diff(Ang_Lkp10_Y));
A_Var_Lkp10(:,3)=var(diff(Ang_Lkp10_Z));
% Lkp10_all=[S_Mean_Lkp10,S_Max_Lkp10,S_Min_Lkp10,S_Var_Lkp10,A_Mean_Lkp10,A_Max_Lkp10,A_Min_Lkp10,A_Var_Lkp10];
Lkp10_all=[A_Mean_Lkp10,A_Max_Lkp10,A_Min_Lkp10,A_Var_Lkp10];


% S_Mean_Lkp11=mean(diff(Lkp11));
% S_Max_Lkp11=max(diff(Lkp11));
% S_Min_Lkp11=min(diff(Lkp11));
% S_Var_Lkp11=var(diff(Lkp11));
% A_Mean_Lkp11(:,1)=mean(diff(Ang_Lkp11_X));
% A_Mean_Lkp11(:,2)=mean(diff(Ang_Lkp11_Y));
% A_Mean_Lkp11(:,3)=mean(diff(Ang_Lkp11_Z));
% A_Max_Lkp11(:,1)=max(diff(Ang_Lkp11_X));
% A_Max_Lkp11(:,2)=max(diff(Ang_Lkp11_Y));
% A_Max_Lkp11(:,3)=max(diff(Ang_Lkp11_Z));
% A_Min_Lkp11(:,1)=min(diff(Ang_Lkp11_X));
% A_Min_Lkp11(:,2)=min(diff(Ang_Lkp11_Y));
% A_Min_Lkp11(:,3)=min(diff(Ang_Lkp11_Z));
% A_Var_Lkp11(:,1)=var(diff(Ang_Lkp11_X));
% A_Var_Lkp11(:,2)=var(diff(Ang_Lkp11_Y));
% A_Var_Lkp11(:,3)=var(diff(Ang_Lkp11_Z));
% Lkp11_all=[S_Mean_Lkp11,S_Max_Lkp11,S_Min_Lkp11,S_Var_Lkp11,A_Mean_Lkp11,A_Max_Lkp11,A_Min_Lkp11,A_Var_Lkp11];
% 
% 
% S_Mean_Lkp12=mean(diff(Lkp12));
% S_Max_Lkp12=max(diff(Lkp12));
% S_Min_Lkp12=min(diff(Lkp12));
% S_Var_Lkp12=var(diff(Lkp12));
% A_Mean_Lkp12(:,1)=mean(diff(Ang_Lkp12_X));
% A_Mean_Lkp12(:,2)=mean(diff(Ang_Lkp12_Y));
% A_Mean_Lkp12(:,3)=mean(diff(Ang_Lkp12_Z));
% A_Max_Lkp12(:,1)=max(diff(Ang_Lkp12_X));
% A_Max_Lkp12(:,2)=max(diff(Ang_Lkp12_Y));
% A_Max_Lkp12(:,3)=max(diff(Ang_Lkp12_Z));
% A_Min_Lkp12(:,1)=min(diff(Ang_Lkp12_X));
% A_Min_Lkp12(:,2)=min(diff(Ang_Lkp12_Y));
% A_Min_Lkp12(:,3)=min(diff(Ang_Lkp12_Z));
% A_Var_Lkp12(:,1)=var(diff(Ang_Lkp12_X));
% A_Var_Lkp12(:,2)=var(diff(Ang_Lkp12_Y));
% A_Var_Lkp12(:,3)=var(diff(Ang_Lkp12_Z));
% Lkp12_all=[S_Mean_Lkp12,S_Max_Lkp12,S_Min_Lkp12,S_Var_Lkp12,A_Mean_Lkp12,A_Max_Lkp12,A_Min_Lkp12,A_Var_Lkp12];


% S_Mean_Lkp13=mean(diff(Lkp13));
% S_Max_Lkp13=max(diff(Lkp13));
% S_Min_Lkp13=min(diff(Lkp13));
% S_Var_Lkp13=var(diff(Lkp13));
A_Mean_Lkp13(:,1)=mean(diff(Ang_Lkp13_X));
A_Mean_Lkp13(:,2)=mean(diff(Ang_Lkp13_Y));
A_Mean_Lkp13(:,3)=mean(diff(Ang_Lkp13_Z));
A_Max_Lkp13(:,1)=max(diff(Ang_Lkp13_X));
A_Max_Lkp13(:,2)=max(diff(Ang_Lkp13_Y));
A_Max_Lkp13(:,3)=max(diff(Ang_Lkp13_Z));
A_Min_Lkp13(:,1)=min(diff(Ang_Lkp13_X));
A_Min_Lkp13(:,2)=min(diff(Ang_Lkp13_Y));
A_Min_Lkp13(:,3)=min(diff(Ang_Lkp13_Z));
A_Var_Lkp13(:,1)=var(diff(Ang_Lkp13_X));
A_Var_Lkp13(:,2)=var(diff(Ang_Lkp13_Y));
A_Var_Lkp13(:,3)=var(diff(Ang_Lkp13_Z));
% Lkp13_all=[S_Mean_Lkp13,S_Max_Lkp13,S_Min_Lkp13,S_Var_Lkp13,A_Mean_Lkp13,A_Max_Lkp13,A_Min_Lkp13,A_Var_Lkp13];
Lkp13_all=[A_Mean_Lkp13,A_Max_Lkp13,A_Min_Lkp13,A_Var_Lkp13];


% S_Mean_Lkp14=mean(diff(Lkp14));
% S_Max_Lkp14=max(diff(Lkp14));
% S_Min_Lkp14=min(diff(Lkp14));
% S_Var_Lkp14=var(diff(Lkp14));
A_Mean_Lkp14(:,1)=mean(diff(Ang_Lkp14_X));
A_Mean_Lkp14(:,2)=mean(diff(Ang_Lkp14_Y));
A_Mean_Lkp14(:,3)=mean(diff(Ang_Lkp14_Z));
A_Max_Lkp14(:,1)=max(diff(Ang_Lkp14_X));
A_Max_Lkp14(:,2)=max(diff(Ang_Lkp14_Y));
A_Max_Lkp14(:,3)=max(diff(Ang_Lkp14_Z));
A_Min_Lkp14(:,1)=min(diff(Ang_Lkp14_X));
A_Min_Lkp14(:,2)=min(diff(Ang_Lkp14_Y));
A_Min_Lkp14(:,3)=min(diff(Ang_Lkp14_Z));
A_Var_Lkp14(:,1)=var(diff(Ang_Lkp14_X));
A_Var_Lkp14(:,2)=var(diff(Ang_Lkp14_Y));
A_Var_Lkp14(:,3)=var(diff(Ang_Lkp14_Z));
% Lkp14_all=[S_Mean_Lkp14,S_Max_Lkp14,S_Min_Lkp14,S_Var_Lkp14,A_Mean_Lkp14,A_Max_Lkp14,A_Min_Lkp14,A_Var_Lkp14];
Lkp14_all=[A_Mean_Lkp14,A_Max_Lkp14,A_Min_Lkp14,A_Var_Lkp14];


% S_Mean_Lkp15=mean(diff(Lkp15));
% S_Max_Lkp15=max(diff(Lkp15));
% S_Min_Lkp15=min(diff(Lkp15));
% S_Var_Lkp15=var(diff(Lkp15));
% A_Mean_Lkp15(:,1)=mean(diff(Ang_Lkp15_X));
% A_Mean_Lkp15(:,2)=mean(diff(Ang_Lkp15_Y));
% A_Mean_Lkp15(:,3)=mean(diff(Ang_Lkp15_Z));
% A_Max_Lkp15(:,1)=max(diff(Ang_Lkp15_X));
% A_Max_Lkp15(:,2)=max(diff(Ang_Lkp15_Y));
% A_Max_Lkp15(:,3)=max(diff(Ang_Lkp15_Z));
% A_Min_Lkp15(:,1)=min(diff(Ang_Lkp15_X));
% A_Min_Lkp15(:,2)=min(diff(Ang_Lkp15_Y));
% A_Min_Lkp15(:,3)=min(diff(Ang_Lkp15_Z));
% A_Var_Lkp15(:,1)=var(diff(Ang_Lkp15_X));
% A_Var_Lkp15(:,2)=var(diff(Ang_Lkp15_Y));
% A_Var_Lkp15(:,3)=var(diff(Ang_Lkp15_Z));
% Lkp15_all=[S_Mean_Lkp15,S_Max_Lkp15,S_Min_Lkp15,S_Var_Lkp15,A_Mean_Lkp15,A_Max_Lkp15,A_Min_Lkp15,A_Var_Lkp15];
% 
% 
% S_Mean_Lkp16=mean(diff(Lkp16));
% S_Max_Lkp16=max(diff(Lkp16));
% S_Min_Lkp16=min(diff(Lkp16));
% S_Var_Lkp16=var(diff(Lkp16));
% A_Mean_Lkp16(:,1)=mean(diff(Ang_Lkp16_X));
% A_Mean_Lkp16(:,2)=mean(diff(Ang_Lkp16_Y));
% A_Mean_Lkp16(:,3)=mean(diff(Ang_Lkp16_Z));
% A_Max_Lkp16(:,1)=max(diff(Ang_Lkp16_X));
% A_Max_Lkp16(:,2)=max(diff(Ang_Lkp16_Y));
% A_Max_Lkp16(:,3)=max(diff(Ang_Lkp16_Z));
% A_Min_Lkp16(:,1)=min(diff(Ang_Lkp16_X));
% A_Min_Lkp16(:,2)=min(diff(Ang_Lkp16_Y));
% A_Min_Lkp16(:,3)=min(diff(Ang_Lkp16_Z));
% A_Var_Lkp16(:,1)=var(diff(Ang_Lkp16_X));
% A_Var_Lkp16(:,2)=var(diff(Ang_Lkp16_Y));
% A_Var_Lkp16(:,3)=var(diff(Ang_Lkp16_Z));
% Lkp16_all=[S_Mean_Lkp16,S_Max_Lkp16,S_Min_Lkp16,S_Var_Lkp16,A_Mean_Lkp16,A_Max_Lkp16,A_Min_Lkp16,A_Var_Lkp16];


% S_Mean_Lkp17=mean(diff(Lkp17));
% S_Max_Lkp17=max(diff(Lkp17));
% S_Min_Lkp17=min(diff(Lkp17));
% S_Var_Lkp17=var(diff(Lkp17));
A_Mean_Lkp17(:,1)=mean(diff(Ang_Lkp17_X));
A_Mean_Lkp17(:,2)=mean(diff(Ang_Lkp17_Y));
A_Mean_Lkp17(:,3)=mean(diff(Ang_Lkp17_Z));
A_Max_Lkp17(:,1)=max(diff(Ang_Lkp17_X));
A_Max_Lkp17(:,2)=max(diff(Ang_Lkp17_Y));
A_Max_Lkp17(:,3)=max(diff(Ang_Lkp17_Z));
A_Min_Lkp17(:,1)=min(diff(Ang_Lkp17_X));
A_Min_Lkp17(:,2)=min(diff(Ang_Lkp17_Y));
A_Min_Lkp17(:,3)=min(diff(Ang_Lkp17_Z));
A_Var_Lkp17(:,1)=var(diff(Ang_Lkp17_X));
A_Var_Lkp17(:,2)=var(diff(Ang_Lkp17_Y));
A_Var_Lkp17(:,3)=var(diff(Ang_Lkp17_Z));
% Lkp17_all=[S_Mean_Lkp17,S_Max_Lkp17,S_Min_Lkp17,S_Var_Lkp17,A_Mean_Lkp17,A_Max_Lkp17,A_Min_Lkp17,A_Var_Lkp17];
Lkp17_all=[A_Mean_Lkp17,A_Max_Lkp17,A_Min_Lkp17,A_Var_Lkp17];


% S_Mean_Lkp18=mean(diff(Lkp18));
% S_Max_Lkp18=max(diff(Lkp18));
% S_Min_Lkp18=min(diff(Lkp18));
% S_Var_Lkp18=var(diff(Lkp18));
A_Mean_Lkp18(:,1)=mean(diff(Ang_Lkp18_X));
A_Mean_Lkp18(:,2)=mean(diff(Ang_Lkp18_Y));
A_Mean_Lkp18(:,3)=mean(diff(Ang_Lkp18_Z));
A_Max_Lkp18(:,1)=max(diff(Ang_Lkp18_X));
A_Max_Lkp18(:,2)=max(diff(Ang_Lkp18_Y));
A_Max_Lkp18(:,3)=max(diff(Ang_Lkp18_Z));
A_Min_Lkp18(:,1)=min(diff(Ang_Lkp18_X));
A_Min_Lkp18(:,2)=min(diff(Ang_Lkp18_Y));
A_Min_Lkp18(:,3)=min(diff(Ang_Lkp18_Z));
A_Var_Lkp18(:,1)=var(diff(Ang_Lkp18_X));
A_Var_Lkp18(:,2)=var(diff(Ang_Lkp18_Y));
A_Var_Lkp18(:,3)=var(diff(Ang_Lkp18_Z));
% Lkp18_all=[S_Mean_Lkp18,S_Max_Lkp18,S_Min_Lkp18,S_Var_Lkp18,A_Mean_Lkp18,A_Max_Lkp18,A_Min_Lkp18,A_Var_Lkp18];
Lkp18_all=[A_Mean_Lkp18,A_Max_Lkp18,A_Min_Lkp18,A_Var_Lkp18];


% S_Mean_Lkp19=mean(diff(Lkp19));
% S_Max_Lkp19=max(diff(Lkp19));
% S_Min_Lkp19=min(diff(Lkp19));
% S_Var_Lkp19=var(diff(Lkp19));
% A_Mean_Lkp19(:,1)=mean(diff(Ang_Lkp19_X));
% A_Mean_Lkp19(:,2)=mean(diff(Ang_Lkp19_Y));
% A_Mean_Lkp19(:,3)=mean(diff(Ang_Lkp19_Z));
% A_Max_Lkp19(:,1)=max(diff(Ang_Lkp19_X));
% A_Max_Lkp19(:,2)=max(diff(Ang_Lkp19_Y));
% A_Max_Lkp19(:,3)=max(diff(Ang_Lkp19_Z));
% A_Min_Lkp19(:,1)=min(diff(Ang_Lkp19_X));
% A_Min_Lkp19(:,2)=min(diff(Ang_Lkp19_Y));
% A_Min_Lkp19(:,3)=min(diff(Ang_Lkp19_Z));
% A_Var_Lkp19(:,1)=var(diff(Ang_Lkp19_X));
% A_Var_Lkp19(:,2)=var(diff(Ang_Lkp19_Y));
% A_Var_Lkp19(:,3)=var(diff(Ang_Lkp19_Z));
% Lkp19_all=[S_Mean_Lkp19,S_Max_Lkp19,S_Min_Lkp19,S_Var_Lkp19,A_Mean_Lkp19,A_Max_Lkp19,A_Min_Lkp19,A_Var_Lkp19];
% 


% Lkp_all=[Lkp1_all,Lkp2_all,Lkp3_all,Lkp4_all,Lkp5_all,Lkp6_all,Lkp7_all,Lkp8_all,Lkp9_all,Lkp10_all,Lkp11_all,Lkp12_all,Lkp13_all,Lkp14_all,Lkp15_all,Lkp16_all,Lkp17_all,Lkp18_all,Lkp19_all];
Lkp_all=[Lkp1_all,Lkp5_all,Lkp6_all,Lkp9_all,Lkp10_all,Lkp13_all,Lkp14_all,Lkp17_all,Lkp18_all];




%自身特征
% S_Mean_Mkp1=mean(diff(Mkp1));
% S_Max_Mkp1=max(diff(Mkp1));
% S_Min_Mkp1=min(diff(Mkp1));
% S_Var_Mkp1=var(diff(Mkp1));
A_Mean_Mkp1(:,1)=mean(diff(Ang_Mkp1_X));
A_Mean_Mkp1(:,2)=mean(diff(Ang_Mkp1_Y));
A_Mean_Mkp1(:,3)=mean(diff(Ang_Mkp1_Z));
A_Max_Mkp1(:,1)=max(diff(Ang_Mkp1_X));
A_Max_Mkp1(:,2)=max(diff(Ang_Mkp1_Y));
A_Max_Mkp1(:,3)=max(diff(Ang_Mkp1_Z));
A_Min_Mkp1(:,1)=min(diff(Ang_Mkp1_X));
A_Min_Mkp1(:,2)=min(diff(Ang_Mkp1_Y));
A_Min_Mkp1(:,3)=min(diff(Ang_Mkp1_Z));
A_Var_Mkp1(:,1)=var(diff(Ang_Mkp1_X));
A_Var_Mkp1(:,2)=var(diff(Ang_Mkp1_Y));
A_Var_Mkp1(:,3)=var(diff(Ang_Mkp1_Z));
% Mkp1_all=[S_Mean_Mkp1,S_Max_Mkp1,S_Min_Mkp1,S_Var_Mkp1,A_Mean_Mkp1,A_Max_Mkp1,A_Min_Mkp1,A_Var_Mkp1];
Mkp1_all=[A_Mean_Mkp1,A_Max_Mkp1,A_Min_Mkp1,A_Var_Mkp1];

% S_Mean_Mkp2=mean(diff(Mkp2));
% S_Max_Mkp2=max(diff(Mkp2));
% S_Min_Mkp2=min(diff(Mkp2));
% S_Var_Mkp2=var(diff(Mkp2));
% A_Mean_Mkp2(:,1)=mean(diff(Ang_Mkp2_X));
% A_Mean_Mkp2(:,2)=mean(diff(Ang_Mkp2_Y));
% A_Mean_Mkp2(:,3)=mean(diff(Ang_Mkp2_Z));
% A_Max_Mkp2(:,1)=max(diff(Ang_Mkp2_X));
% A_Max_Mkp2(:,2)=max(diff(Ang_Mkp2_Y));
% A_Max_Mkp2(:,3)=max(diff(Ang_Mkp2_Z));
% A_Min_Mkp2(:,1)=min(diff(Ang_Mkp2_X));
% A_Min_Mkp2(:,2)=min(diff(Ang_Mkp2_Y));
% A_Min_Mkp2(:,3)=min(diff(Ang_Mkp2_Z));
% A_Var_Mkp2(:,1)=var(diff(Ang_Mkp2_X));
% A_Var_Mkp2(:,2)=var(diff(Ang_Mkp2_Y));
% A_Var_Mkp2(:,3)=var(diff(Ang_Mkp2_Z));
% Mkp2_all=[S_Mean_Mkp2,S_Max_Mkp2,S_Min_Mkp2,S_Var_Mkp2,A_Mean_Mkp2,A_Max_Mkp2,A_Min_Mkp2,A_Var_Mkp2];
% 
% 
% S_Mean_Mkp3=mean(diff(Mkp3));
% S_Max_Mkp3=max(diff(Mkp3));
% S_Min_Mkp3=min(diff(Mkp3));
% S_Var_Mkp3=var(diff(Mkp3));
% A_Mean_Mkp3(:,1)=mean(diff(Ang_Mkp3_X));
% A_Mean_Mkp3(:,2)=mean(diff(Ang_Mkp3_Y));
% A_Mean_Mkp3(:,3)=mean(diff(Ang_Mkp3_Z));
% A_Max_Mkp3(:,1)=max(diff(Ang_Mkp3_X));
% A_Max_Mkp3(:,2)=max(diff(Ang_Mkp3_Y));
% A_Max_Mkp3(:,3)=max(diff(Ang_Mkp3_Z));
% A_Min_Mkp3(:,1)=min(diff(Ang_Mkp3_X));
% A_Min_Mkp3(:,2)=min(diff(Ang_Mkp3_Y));
% A_Min_Mkp3(:,3)=min(diff(Ang_Mkp3_Z));
% A_Var_Mkp3(:,1)=var(diff(Ang_Mkp3_X));
% A_Var_Mkp3(:,2)=var(diff(Ang_Mkp3_Y));
% A_Var_Mkp3(:,3)=var(diff(Ang_Mkp3_Z));
% Mkp3_all=[S_Mean_Mkp3,S_Max_Mkp3,S_Min_Mkp3,S_Var_Mkp3,A_Mean_Mkp3,A_Max_Mkp3,A_Min_Mkp3,A_Var_Mkp3];
% 
% 
% S_Mean_Mkp4=mean(diff(Mkp4));
% S_Max_Mkp4=max(diff(Mkp4));
% S_Min_Mkp4=min(diff(Mkp4));
% S_Var_Mkp4=var(diff(Mkp4));
% A_Mean_Mkp4(:,1)=mean(diff(Ang_Mkp4_X));
% A_Mean_Mkp4(:,2)=mean(diff(Ang_Mkp4_Y));
% A_Mean_Mkp4(:,3)=mean(diff(Ang_Mkp4_Z));
% A_Max_Mkp4(:,1)=max(diff(Ang_Mkp4_X));
% A_Max_Mkp4(:,2)=max(diff(Ang_Mkp4_Y));
% A_Max_Mkp4(:,3)=max(diff(Ang_Mkp4_Z));
% A_Min_Mkp4(:,1)=min(diff(Ang_Mkp4_X));
% A_Min_Mkp4(:,2)=min(diff(Ang_Mkp4_Y));
% A_Min_Mkp4(:,3)=min(diff(Ang_Mkp4_Z));
% A_Var_Mkp4(:,1)=var(diff(Ang_Mkp4_X));
% A_Var_Mkp4(:,2)=var(diff(Ang_Mkp4_Y));
% A_Var_Mkp4(:,3)=var(diff(Ang_Mkp4_Z));
% Mkp4_all=[S_Mean_Mkp4,S_Max_Mkp4,S_Min_Mkp4,S_Var_Mkp4,A_Mean_Mkp4,A_Max_Mkp4,A_Min_Mkp4,A_Var_Mkp4];


% S_Mean_Mkp5=mean(diff(Mkp5));
% S_Max_Mkp5=max(diff(Mkp5));
% S_Min_Mkp5=min(diff(Mkp5));
% S_Var_Mkp5=var(diff(Mkp5));
A_Mean_Mkp5(:,1)=mean(diff(Ang_Mkp5_X));
A_Mean_Mkp5(:,2)=mean(diff(Ang_Mkp5_Y));
A_Mean_Mkp5(:,3)=mean(diff(Ang_Mkp5_Z));
A_Max_Mkp5(:,1)=max(diff(Ang_Mkp5_X));
A_Max_Mkp5(:,2)=max(diff(Ang_Mkp5_Y));
A_Max_Mkp5(:,3)=max(diff(Ang_Mkp5_Z));
A_Min_Mkp5(:,1)=min(diff(Ang_Mkp5_X));
A_Min_Mkp5(:,2)=min(diff(Ang_Mkp5_Y));
A_Min_Mkp5(:,3)=min(diff(Ang_Mkp5_Z));
A_Var_Mkp5(:,1)=var(diff(Ang_Mkp5_X));
A_Var_Mkp5(:,2)=var(diff(Ang_Mkp5_Y));
A_Var_Mkp5(:,3)=var(diff(Ang_Mkp5_Z));
% Mkp5_all=[S_Mean_Mkp5,S_Max_Mkp5,S_Min_Mkp5,S_Var_Mkp5,A_Mean_Mkp5,A_Max_Mkp5,A_Min_Mkp5,A_Var_Mkp5];
Mkp5_all=[A_Mean_Mkp5,A_Max_Mkp5,A_Min_Mkp5,A_Var_Mkp5];


% S_Mean_Mkp6=mean(diff(Mkp6));
% S_Max_Mkp6=max(diff(Mkp6));
% S_Min_Mkp6=min(diff(Mkp6));
% S_Var_Mkp6=var(diff(Mkp6));
A_Mean_Mkp6(:,1)=mean(diff(Ang_Mkp6_X));
A_Mean_Mkp6(:,2)=mean(diff(Ang_Mkp6_Y));
A_Mean_Mkp6(:,3)=mean(diff(Ang_Mkp6_Z));
A_Max_Mkp6(:,1)=max(diff(Ang_Mkp6_X));
A_Max_Mkp6(:,2)=max(diff(Ang_Mkp6_Y));
A_Max_Mkp6(:,3)=max(diff(Ang_Mkp6_Z));
A_Min_Mkp6(:,1)=min(diff(Ang_Mkp6_X));
A_Min_Mkp6(:,2)=min(diff(Ang_Mkp6_Y));
A_Min_Mkp6(:,3)=min(diff(Ang_Mkp6_Z));
A_Var_Mkp6(:,1)=var(diff(Ang_Mkp6_X));
A_Var_Mkp6(:,2)=var(diff(Ang_Mkp6_Y));
A_Var_Mkp6(:,3)=var(diff(Ang_Mkp6_Z));
% Mkp6_all=[S_Mean_Mkp6,S_Max_Mkp6,S_Min_Mkp6,S_Var_Mkp6,A_Mean_Mkp6,A_Max_Mkp6,A_Min_Mkp6,A_Var_Mkp6];
Mkp6_all=[A_Mean_Mkp6,A_Max_Mkp6,A_Min_Mkp6,A_Var_Mkp6];


% S_Mean_Mkp7=mean(diff(Mkp7));
% S_Max_Mkp7=max(diff(Mkp7));
% S_Min_Mkp7=min(diff(Mkp7));
% S_Var_Mkp7=var(diff(Mkp7));
% A_Mean_Mkp7(:,1)=mean(diff(Ang_Mkp7_X));
% A_Mean_Mkp7(:,2)=mean(diff(Ang_Mkp7_Y));
% A_Mean_Mkp7(:,3)=mean(diff(Ang_Mkp7_Z));
% A_Max_Mkp7(:,1)=max(diff(Ang_Mkp7_X));
% A_Max_Mkp7(:,2)=max(diff(Ang_Mkp7_Y));
% A_Max_Mkp7(:,3)=max(diff(Ang_Mkp7_Z));
% A_Min_Mkp7(:,1)=min(diff(Ang_Mkp7_X));
% A_Min_Mkp7(:,2)=min(diff(Ang_Mkp7_Y));
% A_Min_Mkp7(:,3)=min(diff(Ang_Mkp7_Z));
% A_Var_Mkp7(:,1)=var(diff(Ang_Mkp7_X));
% A_Var_Mkp7(:,2)=var(diff(Ang_Mkp7_Y));
% A_Var_Mkp7(:,3)=var(diff(Ang_Mkp7_Z));
% Mkp7_all=[S_Mean_Mkp7,S_Max_Mkp7,S_Min_Mkp7,S_Var_Mkp7,A_Mean_Mkp7,A_Max_Mkp7,A_Min_Mkp7,A_Var_Mkp7];
% 
% 
% S_Mean_Mkp8=mean(diff(Mkp8));
% S_Max_Mkp8=max(diff(Mkp8));
% S_Min_Mkp8=min(diff(Mkp8));
% S_Var_Mkp8=var(diff(Mkp8));
% A_Mean_Mkp8(:,1)=mean(diff(Ang_Mkp8_X));
% A_Mean_Mkp8(:,2)=mean(diff(Ang_Mkp8_Y));
% A_Mean_Mkp8(:,3)=mean(diff(Ang_Mkp8_Z));
% A_Max_Mkp8(:,1)=max(diff(Ang_Mkp8_X));
% A_Max_Mkp8(:,2)=max(diff(Ang_Mkp8_Y));
% A_Max_Mkp8(:,3)=max(diff(Ang_Mkp8_Z));
% A_Min_Mkp8(:,1)=min(diff(Ang_Mkp8_X));
% A_Min_Mkp8(:,2)=min(diff(Ang_Mkp8_Y));
% A_Min_Mkp8(:,3)=min(diff(Ang_Mkp8_Z));
% A_Var_Mkp8(:,1)=var(diff(Ang_Mkp8_X));
% A_Var_Mkp8(:,2)=var(diff(Ang_Mkp8_Y));
% A_Var_Mkp8(:,3)=var(diff(Ang_Mkp8_Z));
% Mkp8_all=[S_Mean_Mkp8,S_Max_Mkp8,S_Min_Mkp8,S_Var_Mkp8,A_Mean_Mkp8,A_Max_Mkp8,A_Min_Mkp8,A_Var_Mkp8];


% S_Mean_Mkp9=mean(diff(Mkp9));
% S_Max_Mkp9=max(diff(Mkp9));
% S_Min_Mkp9=min(diff(Mkp9));
% S_Var_Mkp9=var(diff(Mkp9));
A_Mean_Mkp9(:,1)=mean(diff(Ang_Mkp9_X));
A_Mean_Mkp9(:,2)=mean(diff(Ang_Mkp9_Y));
A_Mean_Mkp9(:,3)=mean(diff(Ang_Mkp9_Z));
A_Max_Mkp9(:,1)=max(diff(Ang_Mkp9_X));
A_Max_Mkp9(:,2)=max(diff(Ang_Mkp9_Y));
A_Max_Mkp9(:,3)=max(diff(Ang_Mkp9_Z));
A_Min_Mkp9(:,1)=min(diff(Ang_Mkp9_X));
A_Min_Mkp9(:,2)=min(diff(Ang_Mkp9_Y));
A_Min_Mkp9(:,3)=min(diff(Ang_Mkp9_Z));
A_Var_Mkp9(:,1)=var(diff(Ang_Mkp9_X));
A_Var_Mkp9(:,2)=var(diff(Ang_Mkp9_Y));
A_Var_Mkp9(:,3)=var(diff(Ang_Mkp9_Z));
% Mkp9_all=[S_Mean_Mkp9,S_Max_Mkp9,S_Min_Mkp9,S_Var_Mkp9,A_Mean_Mkp9,A_Max_Mkp9,A_Min_Mkp9,A_Var_Mkp9];
Mkp9_all=[A_Mean_Mkp9,A_Max_Mkp9,A_Min_Mkp9,A_Var_Mkp9];


% S_Mean_Mkp10=mean(diff(Mkp10));
% S_Max_Mkp10=max(diff(Mkp10));
% S_Min_Mkp10=min(diff(Mkp10));
% S_Var_Mkp10=var(diff(Mkp10));
A_Mean_Mkp10(:,1)=mean(diff(Ang_Mkp10_X));
A_Mean_Mkp10(:,2)=mean(diff(Ang_Mkp10_Y));
A_Mean_Mkp10(:,3)=mean(diff(Ang_Mkp10_Z));
A_Max_Mkp10(:,1)=max(diff(Ang_Mkp10_X));
A_Max_Mkp10(:,2)=max(diff(Ang_Mkp10_Y));
A_Max_Mkp10(:,3)=max(diff(Ang_Mkp10_Z));
A_Min_Mkp10(:,1)=min(diff(Ang_Mkp10_X));
A_Min_Mkp10(:,2)=min(diff(Ang_Mkp10_Y));
A_Min_Mkp10(:,3)=min(diff(Ang_Mkp10_Z));
A_Var_Mkp10(:,1)=var(diff(Ang_Mkp10_X));
A_Var_Mkp10(:,2)=var(diff(Ang_Mkp10_Y));
A_Var_Mkp10(:,3)=var(diff(Ang_Mkp10_Z));
% Mkp10_all=[S_Mean_Mkp10,S_Max_Mkp10,S_Min_Mkp10,S_Var_Mkp10,A_Mean_Mkp10,A_Max_Mkp10,A_Min_Mkp10,A_Var_Mkp10];
Mkp10_all=[A_Mean_Mkp10,A_Max_Mkp10,A_Min_Mkp10,A_Var_Mkp10];


% S_Mean_Mkp11=mean(diff(Mkp11));
% S_Max_Mkp11=max(diff(Mkp11));
% S_Min_Mkp11=min(diff(Mkp11));
% S_Var_Mkp11=var(diff(Mkp11));
% A_Mean_Mkp11(:,1)=mean(diff(Ang_Mkp11_X));
% A_Mean_Mkp11(:,2)=mean(diff(Ang_Mkp11_Y));
% A_Mean_Mkp11(:,3)=mean(diff(Ang_Mkp11_Z));
% A_Max_Mkp11(:,1)=max(diff(Ang_Mkp11_X));
% A_Max_Mkp11(:,2)=max(diff(Ang_Mkp11_Y));
% A_Max_Mkp11(:,3)=max(diff(Ang_Mkp11_Z));
% A_Min_Mkp11(:,1)=min(diff(Ang_Mkp11_X));
% A_Min_Mkp11(:,2)=min(diff(Ang_Mkp11_Y));
% A_Min_Mkp11(:,3)=min(diff(Ang_Mkp11_Z));
% A_Var_Mkp11(:,1)=var(diff(Ang_Mkp11_X));
% A_Var_Mkp11(:,2)=var(diff(Ang_Mkp11_Y));
% A_Var_Mkp11(:,3)=var(diff(Ang_Mkp11_Z));
% Mkp11_all=[S_Mean_Mkp11,S_Max_Mkp11,S_Min_Mkp11,S_Var_Mkp11,A_Mean_Mkp11,A_Max_Mkp11,A_Min_Mkp11,A_Var_Mkp11];
% 
% 
% S_Mean_Mkp12=mean(diff(Mkp12));
% S_Max_Mkp12=max(diff(Mkp12));
% S_Min_Mkp12=min(diff(Mkp12));
% S_Var_Mkp12=var(diff(Mkp12));
% A_Mean_Mkp12(:,1)=mean(diff(Ang_Mkp12_X));
% A_Mean_Mkp12(:,2)=mean(diff(Ang_Mkp12_Y));
% A_Mean_Mkp12(:,3)=mean(diff(Ang_Mkp12_Z));
% A_Max_Mkp12(:,1)=max(diff(Ang_Mkp12_X));
% A_Max_Mkp12(:,2)=max(diff(Ang_Mkp12_Y));
% A_Max_Mkp12(:,3)=max(diff(Ang_Mkp12_Z));
% A_Min_Mkp12(:,1)=min(diff(Ang_Mkp12_X));
% A_Min_Mkp12(:,2)=min(diff(Ang_Mkp12_Y));
% A_Min_Mkp12(:,3)=min(diff(Ang_Mkp12_Z));
% A_Var_Mkp12(:,1)=var(diff(Ang_Mkp12_X));
% A_Var_Mkp12(:,2)=var(diff(Ang_Mkp12_Y));
% A_Var_Mkp12(:,3)=var(diff(Ang_Mkp12_Z));
% Mkp12_all=[S_Mean_Mkp12,S_Max_Mkp12,S_Min_Mkp12,S_Var_Mkp12,A_Mean_Mkp12,A_Max_Mkp12,A_Min_Mkp12,A_Var_Mkp12];


% S_Mean_Mkp13=mean(diff(Mkp13));
% S_Max_Mkp13=max(diff(Mkp13));
% S_Min_Mkp13=min(diff(Mkp13));
% S_Var_Mkp13=var(diff(Mkp13));
A_Mean_Mkp13(:,1)=mean(diff(Ang_Mkp13_X));
A_Mean_Mkp13(:,2)=mean(diff(Ang_Mkp13_Y));
A_Mean_Mkp13(:,3)=mean(diff(Ang_Mkp13_Z));
A_Max_Mkp13(:,1)=max(diff(Ang_Mkp13_X));
A_Max_Mkp13(:,2)=max(diff(Ang_Mkp13_Y));
A_Max_Mkp13(:,3)=max(diff(Ang_Mkp13_Z));
A_Min_Mkp13(:,1)=min(diff(Ang_Mkp13_X));
A_Min_Mkp13(:,2)=min(diff(Ang_Mkp13_Y));
A_Min_Mkp13(:,3)=min(diff(Ang_Mkp13_Z));
A_Var_Mkp13(:,1)=var(diff(Ang_Mkp13_X));
A_Var_Mkp13(:,2)=var(diff(Ang_Mkp13_Y));
A_Var_Mkp13(:,3)=var(diff(Ang_Mkp13_Z));
% Mkp13_all=[S_Mean_Mkp13,S_Max_Mkp13,S_Min_Mkp13,S_Var_Mkp13,A_Mean_Mkp13,A_Max_Mkp13,A_Min_Mkp13,A_Var_Mkp13];
Mkp13_all=[A_Mean_Mkp13,A_Max_Mkp13,A_Min_Mkp13,A_Var_Mkp13];


% S_Mean_Mkp14=mean(diff(Mkp14));
% S_Max_Mkp14=max(diff(Mkp14));
% S_Min_Mkp14=min(diff(Mkp14));
% S_Var_Mkp14=var(diff(Mkp14));
A_Mean_Mkp14(:,1)=mean(diff(Ang_Mkp14_X));
A_Mean_Mkp14(:,2)=mean(diff(Ang_Mkp14_Y));
A_Mean_Mkp14(:,3)=mean(diff(Ang_Mkp14_Z));
A_Max_Mkp14(:,1)=max(diff(Ang_Mkp14_X));
A_Max_Mkp14(:,2)=max(diff(Ang_Mkp14_Y));
A_Max_Mkp14(:,3)=max(diff(Ang_Mkp14_Z));
A_Min_Mkp14(:,1)=min(diff(Ang_Mkp14_X));
A_Min_Mkp14(:,2)=min(diff(Ang_Mkp14_Y));
A_Min_Mkp14(:,3)=min(diff(Ang_Mkp14_Z));
A_Var_Mkp14(:,1)=var(diff(Ang_Mkp14_X));
A_Var_Mkp14(:,2)=var(diff(Ang_Mkp14_Y));
A_Var_Mkp14(:,3)=var(diff(Ang_Mkp14_Z));
% Mkp14_all=[S_Mean_Mkp14,S_Max_Mkp14,S_Min_Mkp14,S_Var_Mkp14,A_Mean_Mkp14,A_Max_Mkp14,A_Min_Mkp14,A_Var_Mkp14];
Mkp14_all=[A_Mean_Mkp14,A_Max_Mkp14,A_Min_Mkp14,A_Var_Mkp14];


% S_Mean_Mkp15=mean(diff(Mkp15));
% S_Max_Mkp15=max(diff(Mkp15));
% S_Min_Mkp15=min(diff(Mkp15));
% S_Var_Mkp15=var(diff(Mkp15));
% A_Mean_Mkp15(:,1)=mean(diff(Ang_Mkp15_X));
% A_Mean_Mkp15(:,2)=mean(diff(Ang_Mkp15_Y));
% A_Mean_Mkp15(:,3)=mean(diff(Ang_Mkp15_Z));
% A_Max_Mkp15(:,1)=max(diff(Ang_Mkp15_X));
% A_Max_Mkp15(:,2)=max(diff(Ang_Mkp15_Y));
% A_Max_Mkp15(:,3)=max(diff(Ang_Mkp15_Z));
% A_Min_Mkp15(:,1)=min(diff(Ang_Mkp15_X));
% A_Min_Mkp15(:,2)=min(diff(Ang_Mkp15_Y));
% A_Min_Mkp15(:,3)=min(diff(Ang_Mkp15_Z));
% A_Var_Mkp15(:,1)=var(diff(Ang_Mkp15_X));
% A_Var_Mkp15(:,2)=var(diff(Ang_Mkp15_Y));
% A_Var_Mkp15(:,3)=var(diff(Ang_Mkp15_Z));
% Mkp15_all=[S_Mean_Mkp15,S_Max_Mkp15,S_Min_Mkp15,S_Var_Mkp15,A_Mean_Mkp15,A_Max_Mkp15,A_Min_Mkp15,A_Var_Mkp15];
% 
% 
% S_Mean_Mkp16=mean(diff(Mkp16));
% S_Max_Mkp16=max(diff(Mkp16));
% S_Min_Mkp16=min(diff(Mkp16));
% S_Var_Mkp16=var(diff(Mkp16));
% A_Mean_Mkp16(:,1)=mean(diff(Ang_Mkp16_X));
% A_Mean_Mkp16(:,2)=mean(diff(Ang_Mkp16_Y));
% A_Mean_Mkp16(:,3)=mean(diff(Ang_Mkp16_Z));
% A_Max_Mkp16(:,1)=max(diff(Ang_Mkp16_X));
% A_Max_Mkp16(:,2)=max(diff(Ang_Mkp16_Y));
% A_Max_Mkp16(:,3)=max(diff(Ang_Mkp16_Z));
% A_Min_Mkp16(:,1)=min(diff(Ang_Mkp16_X));
% A_Min_Mkp16(:,2)=min(diff(Ang_Mkp16_Y));
% A_Min_Mkp16(:,3)=min(diff(Ang_Mkp16_Z));
% A_Var_Mkp16(:,1)=var(diff(Ang_Mkp16_X));
% A_Var_Mkp16(:,2)=var(diff(Ang_Mkp16_Y));
% A_Var_Mkp16(:,3)=var(diff(Ang_Mkp16_Z));
% Mkp16_all=[S_Mean_Mkp16,S_Max_Mkp16,S_Min_Mkp16,S_Var_Mkp16,A_Mean_Mkp16,A_Max_Mkp16,A_Min_Mkp16,A_Var_Mkp16];


% S_Mean_Mkp17=mean(diff(Mkp17));
% S_Max_Mkp17=max(diff(Mkp17));
% S_Min_Mkp17=min(diff(Mkp17));
% S_Var_Mkp17=var(diff(Mkp17));
A_Mean_Mkp17(:,1)=mean(diff(Ang_Mkp17_X));
A_Mean_Mkp17(:,2)=mean(diff(Ang_Mkp17_Y));
A_Mean_Mkp17(:,3)=mean(diff(Ang_Mkp17_Z));
A_Max_Mkp17(:,1)=max(diff(Ang_Mkp17_X));
A_Max_Mkp17(:,2)=max(diff(Ang_Mkp17_Y));
A_Max_Mkp17(:,3)=max(diff(Ang_Mkp17_Z));
A_Min_Mkp17(:,1)=min(diff(Ang_Mkp17_X));
A_Min_Mkp17(:,2)=min(diff(Ang_Mkp17_Y));
A_Min_Mkp17(:,3)=min(diff(Ang_Mkp17_Z));
A_Var_Mkp17(:,1)=var(diff(Ang_Mkp17_X));
A_Var_Mkp17(:,2)=var(diff(Ang_Mkp17_Y));
A_Var_Mkp17(:,3)=var(diff(Ang_Mkp17_Z));
% Mkp17_all=[S_Mean_Mkp17,S_Max_Mkp17,S_Min_Mkp17,S_Var_Mkp17,A_Mean_Mkp17,A_Max_Mkp17,A_Min_Mkp17,A_Var_Mkp17];
Mkp17_all=[A_Mean_Mkp17,A_Max_Mkp17,A_Min_Mkp17,A_Var_Mkp17];


% S_Mean_Mkp18=mean(diff(Mkp18));
% S_Max_Mkp18=max(diff(Mkp18));
% S_Min_Mkp18=min(diff(Mkp18));
% S_Var_Mkp18=var(diff(Mkp18));
A_Mean_Mkp18(:,1)=mean(diff(Ang_Mkp18_X));
A_Mean_Mkp18(:,2)=mean(diff(Ang_Mkp18_Y));
A_Mean_Mkp18(:,3)=mean(diff(Ang_Mkp18_Z));
A_Max_Mkp18(:,1)=max(diff(Ang_Mkp18_X));
A_Max_Mkp18(:,2)=max(diff(Ang_Mkp18_Y));
A_Max_Mkp18(:,3)=max(diff(Ang_Mkp18_Z));
A_Min_Mkp18(:,1)=min(diff(Ang_Mkp18_X));
A_Min_Mkp18(:,2)=min(diff(Ang_Mkp18_Y));
A_Min_Mkp18(:,3)=min(diff(Ang_Mkp18_Z));
A_Var_Mkp18(:,1)=var(diff(Ang_Mkp18_X));
A_Var_Mkp18(:,2)=var(diff(Ang_Mkp18_Y));
A_Var_Mkp18(:,3)=var(diff(Ang_Mkp18_Z));
% Mkp18_all=[S_Mean_Mkp18,S_Max_Mkp18,S_Min_Mkp18,S_Var_Mkp18,A_Mean_Mkp18,A_Max_Mkp18,A_Min_Mkp18,A_Var_Mkp18];
Mkp18_all=[A_Mean_Mkp18,A_Max_Mkp18,A_Min_Mkp18,A_Var_Mkp18];

% 
% S_Mean_Mkp19=mean(diff(Mkp19));
% S_Max_Mkp19=max(diff(Mkp19));
% S_Min_Mkp19=min(diff(Mkp19));
% S_Var_Mkp19=var(diff(Mkp19));
% A_Mean_Mkp19(:,1)=mean(diff(Ang_Mkp19_X));
% A_Mean_Mkp19(:,2)=mean(diff(Ang_Mkp19_Y));
% A_Mean_Mkp19(:,3)=mean(diff(Ang_Mkp19_Z));
% A_Max_Mkp19(:,1)=max(diff(Ang_Mkp19_X));
% A_Max_Mkp19(:,2)=max(diff(Ang_Mkp19_Y));
% A_Max_Mkp19(:,3)=max(diff(Ang_Mkp19_Z));
% A_Min_Mkp19(:,1)=min(diff(Ang_Mkp19_X));
% A_Min_Mkp19(:,2)=min(diff(Ang_Mkp19_Y));
% A_Min_Mkp19(:,3)=min(diff(Ang_Mkp19_Z));
% A_Var_Mkp19(:,1)=var(diff(Ang_Mkp19_X));
% A_Var_Mkp19(:,2)=var(diff(Ang_Mkp19_Y));
% A_Var_Mkp19(:,3)=var(diff(Ang_Mkp19_Z));
% Mkp19_all=[S_Mean_Mkp19,S_Max_Mkp19,S_Min_Mkp19,S_Var_Mkp19,A_Mean_Mkp19,A_Max_Mkp19,A_Min_Mkp19,A_Var_Mkp19];
% 


% Mkp_all=[Mkp1_all,Mkp2_all,Mkp3_all,Mkp4_all,Mkp5_all,Mkp6_all,Mkp7_all,Mkp8_all,Mkp9_all,Mkp10_all,Mkp11_all,Mkp12_all,Mkp13_all,Mkp14_all,Mkp15_all,Mkp16_all,Mkp17_all,Mkp18_all,Mkp19_all];

Mkp_all=[Mkp1_all,Mkp5_all,Mkp6_all,Mkp9_all,Mkp10_all,Mkp13_all,Mkp14_all,Mkp17_all,Mkp18_all];






%世界特征

% S_Mean_Wkp=mean(diff(Wkp));
% S_Max_Wkp=max(diff(Wkp));
% S_Min_Wkp=min(diff(Wkp));
% S_Var_Wkp=var(diff(Wkp));
A_Mean_Wkp(:,1)=mean(diff(Ang_Wkp_X));
A_Mean_Wkp(:,2)=mean(diff(Ang_Wkp_Y));
A_Mean_Wkp(:,3)=mean(diff(Ang_Wkp_Z));
A_Max_Wkp(:,1)=max(diff(Ang_Wkp_X));
A_Max_Wkp(:,2)=max(diff(Ang_Wkp_Y));
A_Max_Wkp(:,3)=max(diff(Ang_Wkp_Z));
A_Min_Wkp(:,1)=min(diff(Ang_Wkp_X));
A_Min_Wkp(:,2)=min(diff(Ang_Wkp_Y));
A_Min_Wkp(:,3)=min(diff(Ang_Wkp_Z));
A_Var_Wkp(:,1)=var(diff(Ang_Wkp_X));
A_Var_Wkp(:,2)=var(diff(Ang_Wkp_Y));
A_Var_Wkp(:,3)=var(diff(Ang_Wkp_Z));
% Wkp_all=[S_Mean_Wkp,S_Max_Wkp,S_Min_Wkp,S_Var_Wkp,A_Mean_Wkp,A_Max_Wkp,A_Min_Wkp,A_Var_Wkp];
Wkp_all=[A_Mean_Wkp,A_Max_Wkp,A_Min_Wkp,A_Var_Wkp];













% % % TZ_acp_R(jj,:)=[Max_kp1,A_Max_kp1,Max_kp2,A_Max_kp2,Max_kp3,A_Max_kp3,Max_kp4,A_Max_kp4,Max_kp5,A_Max_kp5,Max_kp6,A_Max_kp6,Max_kp7,A_Max_kp7,Max_kp8,A_Max_kp8];

TZ_acp_R(jj,:)=[Lkp_all,Mkp_all,Wkp_all];



clearvars -except Bag kk jj TZ_acp_R 

 end
 
%  TZ_acp_R(isnan(TZ_acp_R)) = 0;

TZ_acp_R_T=abs(TZ_acp_R');

[TZ_acp_R_T,ps] = mapminmax(TZ_acp_R_T,0,1); %%标准化

TZ_acp_R_Std=TZ_acp_R_T';
 
TZ_acp_R_New=TZ_acp_R_Std.*(TZ_acp_R./abs(TZ_acp_R));
 
 
 
 
 
 
 
 