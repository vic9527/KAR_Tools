clear;clc;
warning off
format long g %不采用科学计数法

list=dir(['MSRAction3DSkeletonReal3D_7\training\','*.txt']);
kk=length(list);
 for ii=1:kk
     str = strcat ('MSRAction3DSkeletonReal3D_7\training\', list(ii).name);
     Bag{ii}=load(str);
 end
 
 for jj=1:kk
     
 
 Number=jj
% % %  jj=353;
 A=Bag{jj};%载入数据
 
 
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

%消除人体尺寸归一化



%数据清洗和补全
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




%关节点局部XYZ三轴角度偏移量

norm_Lkp1=sum(abs(Lkp1).^2,2).^(1/2);
Ang_Lkp1_X=acosd(Lkp1(:,1)./norm_Lkp1);
Ang_Lkp1_Y=acosd(Lkp1(:,2)./norm_Lkp1);
Ang_Lkp1_Z=acosd(Lkp1(:,3)./norm_Lkp1);



norm_Lkp5=sum(abs(Lkp5).^2,2).^(1/2);
Ang_Lkp5_X=acosd(Lkp5(:,1)./norm_Lkp5);
Ang_Lkp5_Y=acosd(Lkp5(:,2)./norm_Lkp5);
Ang_Lkp5_Z=acosd(Lkp5(:,3)./norm_Lkp5);

norm_Lkp6=sum(abs(Lkp6).^2,2).^(1/2);
Ang_Lkp6_X=acosd(Lkp6(:,1)./norm_Lkp6);
Ang_Lkp6_Y=acosd(Lkp6(:,2)./norm_Lkp6);
Ang_Lkp6_Z=acosd(Lkp6(:,3)./norm_Lkp6);



norm_Lkp9=sum(abs(Lkp9).^2,2).^(1/2);
Ang_Lkp9_X=acosd(Lkp9(:,1)./norm_Lkp9);
Ang_Lkp9_Y=acosd(Lkp9(:,2)./norm_Lkp9);
Ang_Lkp9_Z=acosd(Lkp9(:,3)./norm_Lkp9);

norm_Lkp10=sum(abs(Lkp10).^2,2).^(1/2);
Ang_Lkp10_X=acosd(Lkp10(:,1)./norm_Lkp10);
Ang_Lkp10_Y=acosd(Lkp10(:,2)./norm_Lkp10);
Ang_Lkp10_Z=acosd(Lkp10(:,3)./norm_Lkp10);



norm_Lkp13=sum(abs(Lkp13).^2,2).^(1/2);
Ang_Lkp13_X=acosd(Lkp13(:,1)./norm_Lkp13);
Ang_Lkp13_Y=acosd(Lkp13(:,2)./norm_Lkp13);
Ang_Lkp13_Z=acosd(Lkp13(:,3)./norm_Lkp13);

norm_Lkp14=sum(abs(Lkp14).^2,2).^(1/2);
Ang_Lkp14_X=acosd(Lkp14(:,1)./norm_Lkp14);
Ang_Lkp14_Y=acosd(Lkp14(:,2)./norm_Lkp14);
Ang_Lkp14_Z=acosd(Lkp14(:,3)./norm_Lkp14);



norm_Lkp17=sum(abs(Lkp17).^2,2).^(1/2);
Ang_Lkp17_X=acosd(Lkp17(:,1)./norm_Lkp17);
Ang_Lkp17_Y=acosd(Lkp17(:,2)./norm_Lkp17);
Ang_Lkp17_Z=acosd(Lkp17(:,3)./norm_Lkp17);

norm_Lkp18=sum(abs(Lkp18).^2,2).^(1/2);
Ang_Lkp18_X=acosd(Lkp18(:,1)./norm_Lkp18);
Ang_Lkp18_Y=acosd(Lkp18(:,2)./norm_Lkp18);
Ang_Lkp18_Z=acosd(Lkp18(:,3)./norm_Lkp18);


Ang_Lkp=[Ang_Lkp1_X,Ang_Lkp1_Y,Ang_Lkp1_Z,Ang_Lkp5_X,Ang_Lkp5_Y,Ang_Lkp5_Z,Ang_Lkp6_X,Ang_Lkp6_Y,Ang_Lkp6_Z,Ang_Lkp9_X,Ang_Lkp9_Y,Ang_Lkp9_Z,Ang_Lkp10_X,Ang_Lkp10_Y,Ang_Lkp10_Z,Ang_Lkp13_X,Ang_Lkp13_Y,Ang_Lkp13_Z,Ang_Lkp14_X,Ang_Lkp14_Y,Ang_Lkp14_Z,Ang_Lkp17_X,Ang_Lkp17_Y,Ang_Lkp17_Z,Ang_Lkp18_X,Ang_Lkp18_Y,Ang_Lkp18_Z];


%关节点自身XYZ三轴角度偏移量
norm_Mkp1=sum(abs(Mkp1).^2,2).^(1/2);
Ang_Mkp1_X=acosd(Mkp1(:,1)./norm_Mkp1);
Ang_Mkp1_Y=acosd(Mkp1(:,2)./norm_Mkp1);
Ang_Mkp1_Z=acosd(Mkp1(:,3)./norm_Mkp1);



norm_Mkp5=sum(abs(Mkp5).^2,2).^(1/2);
Ang_Mkp5_X=acosd(Mkp5(:,1)./norm_Mkp5);
Ang_Mkp5_Y=acosd(Mkp5(:,2)./norm_Mkp5);
Ang_Mkp5_Z=acosd(Mkp5(:,3)./norm_Mkp5);

norm_Mkp6=sum(abs(Mkp6).^2,2).^(1/2);
Ang_Mkp6_X=acosd(Mkp6(:,1)./norm_Mkp6);
Ang_Mkp6_Y=acosd(Mkp6(:,2)./norm_Mkp6);
Ang_Mkp6_Z=acosd(Mkp6(:,3)./norm_Mkp6);



norm_Mkp9=sum(abs(Mkp9).^2,2).^(1/2);
Ang_Mkp9_X=acosd(Mkp9(:,1)./norm_Mkp9);
Ang_Mkp9_Y=acosd(Mkp9(:,2)./norm_Mkp9);
Ang_Mkp9_Z=acosd(Mkp9(:,3)./norm_Mkp9);

norm_Mkp10=sum(abs(Mkp10).^2,2).^(1/2);
Ang_Mkp10_X=acosd(Mkp10(:,1)./norm_Mkp10);
Ang_Mkp10_Y=acosd(Mkp10(:,2)./norm_Mkp10);
Ang_Mkp10_Z=acosd(Mkp10(:,3)./norm_Mkp10);



norm_Mkp13=sum(abs(Mkp13).^2,2).^(1/2);
Ang_Mkp13_X=acosd(Mkp13(:,1)./norm_Mkp13);
Ang_Mkp13_Y=acosd(Mkp13(:,2)./norm_Mkp13);
Ang_Mkp13_Z=acosd(Mkp13(:,3)./norm_Mkp13);

norm_Mkp14=sum(abs(Mkp14).^2,2).^(1/2);
Ang_Mkp14_X=acosd(Mkp14(:,1)./norm_Mkp14);
Ang_Mkp14_Y=acosd(Mkp14(:,2)./norm_Mkp14);
Ang_Mkp14_Z=acosd(Mkp14(:,3)./norm_Mkp14);



norm_Mkp17=sum(abs(Mkp17).^2,2).^(1/2);
Ang_Mkp17_X=acosd(Mkp17(:,1)./norm_Mkp17);
Ang_Mkp17_Y=acosd(Mkp17(:,2)./norm_Mkp17);
Ang_Mkp17_Z=acosd(Mkp17(:,3)./norm_Mkp17);

norm_Mkp18=sum(abs(Mkp18).^2,2).^(1/2);
Ang_Mkp18_X=acosd(Mkp18(:,1)./norm_Mkp18);
Ang_Mkp18_Y=acosd(Mkp18(:,2)./norm_Mkp18);
Ang_Mkp18_Z=acosd(Mkp18(:,3)./norm_Mkp18);



Ang_Mkp=[Ang_Mkp1_X,Ang_Mkp1_Y,Ang_Mkp1_Z,Ang_Mkp5_X,Ang_Mkp5_Y,Ang_Mkp5_Z,Ang_Mkp6_X,Ang_Mkp6_Y,Ang_Mkp6_Z,Ang_Mkp9_X,Ang_Mkp9_Y,Ang_Mkp9_Z,Ang_Mkp10_X,Ang_Mkp10_Y,Ang_Mkp10_Z,Ang_Mkp13_X,Ang_Mkp13_Y,Ang_Mkp13_Z,Ang_Mkp14_X,Ang_Mkp14_Y,Ang_Mkp14_Z,Ang_Mkp17_X,Ang_Mkp17_Y,Ang_Mkp17_Z,Ang_Mkp18_X,Ang_Mkp18_Y,Ang_Mkp18_Z];


%关节点世界XYZ三轴角度偏移量
norm_Wkp=sum(abs(Wkp).^2,2).^(1/2);
Ang_Wkp_X=acosd(Wkp(:,1)./norm_Wkp);
Ang_Wkp_Y=acosd(Wkp(:,2)./norm_Wkp);
Ang_Wkp_Z=acosd(Wkp(:,3)./norm_Wkp);

Ang_Wkp=[Ang_Wkp_X,Ang_Wkp_Y,Ang_Wkp_Z];




Ang_LMW=[Ang_Lkp];

Ang_Temp{jj}=Ang_LMW';


clearvars -except Bag kk Ang_Temp


% % % 
% % % 
% % % %求时间序列上的均值，最大值，最小值。
% % % 
% % % %局部特征
% % % A_Mean_Lkp1(:,1)=mean(Ang_Lkp1_X);
% % % A_Mean_Lkp1(:,2)=mean(Ang_Lkp1_Y);
% % % A_Mean_Lkp1(:,3)=mean(Ang_Lkp1_Z);
% % % A_Max_Lkp1(:,1)=max(Ang_Lkp1_X);
% % % A_Max_Lkp1(:,2)=max(Ang_Lkp1_Y);
% % % A_Max_Lkp1(:,3)=max(Ang_Lkp1_Z);
% % % A_Min_Lkp1(:,1)=min(Ang_Lkp1_X);
% % % A_Min_Lkp1(:,2)=min(Ang_Lkp1_Y);
% % % A_Min_Lkp1(:,3)=min(Ang_Lkp1_Z);
% % % 
% % % Lkp1_all=[A_Mean_Lkp1,A_Max_Lkp1,A_Min_Lkp1];
% % % 
% % % 
% % % 
% % % A_Mean_Lkp5(:,1)=mean(Ang_Lkp5_X);
% % % A_Mean_Lkp5(:,2)=mean(Ang_Lkp5_Y);
% % % A_Mean_Lkp5(:,3)=mean(Ang_Lkp5_Z);
% % % A_Max_Lkp5(:,1)=max(Ang_Lkp5_X);
% % % A_Max_Lkp5(:,2)=max(Ang_Lkp5_Y);
% % % A_Max_Lkp5(:,3)=max(Ang_Lkp5_Z);
% % % A_Min_Lkp5(:,1)=min(Ang_Lkp5_X);
% % % A_Min_Lkp5(:,2)=min(Ang_Lkp5_Y);
% % % A_Min_Lkp5(:,3)=min(Ang_Lkp5_Z);
% % % 
% % % Lkp5_all=[A_Mean_Lkp5,A_Max_Lkp5,A_Min_Lkp5];
% % % 
% % % 
% % % 
% % % A_Mean_Lkp6(:,1)=mean(Ang_Lkp6_X);
% % % A_Mean_Lkp6(:,2)=mean(Ang_Lkp6_Y);
% % % A_Mean_Lkp6(:,3)=mean(Ang_Lkp6_Z);
% % % A_Max_Lkp6(:,1)=max(Ang_Lkp6_X);
% % % A_Max_Lkp6(:,2)=max(Ang_Lkp6_Y);
% % % A_Max_Lkp6(:,3)=max(Ang_Lkp6_Z);
% % % A_Min_Lkp6(:,1)=min(Ang_Lkp6_X);
% % % A_Min_Lkp6(:,2)=min(Ang_Lkp6_Y);
% % % A_Min_Lkp6(:,3)=min(Ang_Lkp6_Z);
% % % 
% % % Lkp6_all=[A_Mean_Lkp6,A_Max_Lkp6,A_Min_Lkp6];
% % % 
% % % 
% % % 
% % % A_Mean_Lkp9(:,1)=mean(Ang_Lkp9_X);
% % % A_Mean_Lkp9(:,2)=mean(Ang_Lkp9_Y);
% % % A_Mean_Lkp9(:,3)=mean(Ang_Lkp9_Z);
% % % A_Max_Lkp9(:,1)=max(Ang_Lkp9_X);
% % % A_Max_Lkp9(:,2)=max(Ang_Lkp9_Y);
% % % A_Max_Lkp9(:,3)=max(Ang_Lkp9_Z);
% % % A_Min_Lkp9(:,1)=min(Ang_Lkp9_X);
% % % A_Min_Lkp9(:,2)=min(Ang_Lkp9_Y);
% % % A_Min_Lkp9(:,3)=min(Ang_Lkp9_Z);
% % % 
% % % Lkp9_all=[A_Mean_Lkp9,A_Max_Lkp9,A_Min_Lkp9];
% % % 
% % % 
% % % 
% % % A_Mean_Lkp10(:,1)=mean(Ang_Lkp10_X);
% % % A_Mean_Lkp10(:,2)=mean(Ang_Lkp10_Y);
% % % A_Mean_Lkp10(:,3)=mean(Ang_Lkp10_Z);
% % % A_Max_Lkp10(:,1)=max(Ang_Lkp10_X);
% % % A_Max_Lkp10(:,2)=max(Ang_Lkp10_Y);
% % % A_Max_Lkp10(:,3)=max(Ang_Lkp10_Z);
% % % A_Min_Lkp10(:,1)=min(Ang_Lkp10_X);
% % % A_Min_Lkp10(:,2)=min(Ang_Lkp10_Y);
% % % A_Min_Lkp10(:,3)=min(Ang_Lkp10_Z);
% % % 
% % % Lkp10_all=[A_Mean_Lkp10,A_Max_Lkp10,A_Min_Lkp10];
% % % 
% % % 
% % % A_Mean_Lkp13(:,1)=mean(Ang_Lkp13_X);
% % % A_Mean_Lkp13(:,2)=mean(Ang_Lkp13_Y);
% % % A_Mean_Lkp13(:,3)=mean(Ang_Lkp13_Z);
% % % A_Max_Lkp13(:,1)=max(Ang_Lkp13_X);
% % % A_Max_Lkp13(:,2)=max(Ang_Lkp13_Y);
% % % A_Max_Lkp13(:,3)=max(Ang_Lkp13_Z);
% % % A_Min_Lkp13(:,1)=min(Ang_Lkp13_X);
% % % A_Min_Lkp13(:,2)=min(Ang_Lkp13_Y);
% % % A_Min_Lkp13(:,3)=min(Ang_Lkp13_Z);
% % % 
% % % Lkp13_all=[A_Mean_Lkp13,A_Max_Lkp13,A_Min_Lkp13];
% % % 
% % % 
% % % 
% % % A_Mean_Lkp14(:,1)=mean(Ang_Lkp14_X);
% % % A_Mean_Lkp14(:,2)=mean(Ang_Lkp14_Y);
% % % A_Mean_Lkp14(:,3)=mean(Ang_Lkp14_Z);
% % % A_Max_Lkp14(:,1)=max(Ang_Lkp14_X);
% % % A_Max_Lkp14(:,2)=max(Ang_Lkp14_Y);
% % % A_Max_Lkp14(:,3)=max(Ang_Lkp14_Z);
% % % A_Min_Lkp14(:,1)=min(Ang_Lkp14_X);
% % % A_Min_Lkp14(:,2)=min(Ang_Lkp14_Y);
% % % A_Min_Lkp14(:,3)=min(Ang_Lkp14_Z);
% % % 
% % % Lkp14_all=[A_Mean_Lkp14,A_Max_Lkp14,A_Min_Lkp14];
% % % 
% % % 
% % % 
% % % 
% % % 
% % % 
% % % 
% % % A_Mean_Lkp17(:,1)=mean(Ang_Lkp17_X);
% % % A_Mean_Lkp17(:,2)=mean(Ang_Lkp17_Y);
% % % A_Mean_Lkp17(:,3)=mean(Ang_Lkp17_Z);
% % % A_Max_Lkp17(:,1)=max(Ang_Lkp17_X);
% % % A_Max_Lkp17(:,2)=max(Ang_Lkp17_Y);
% % % A_Max_Lkp17(:,3)=max(Ang_Lkp17_Z);
% % % A_Min_Lkp17(:,1)=min(Ang_Lkp17_X);
% % % A_Min_Lkp17(:,2)=min(Ang_Lkp17_Y);
% % % A_Min_Lkp17(:,3)=min(Ang_Lkp17_Z);
% % % 
% % % Lkp17_all=[A_Mean_Lkp17,A_Max_Lkp17,A_Min_Lkp17];
% % % 
% % % 
% % % A_Mean_Lkp18(:,1)=mean(Ang_Lkp18_X);
% % % A_Mean_Lkp18(:,2)=mean(Ang_Lkp18_Y);
% % % A_Mean_Lkp18(:,3)=mean(Ang_Lkp18_Z);
% % % A_Max_Lkp18(:,1)=max(Ang_Lkp18_X);
% % % A_Max_Lkp18(:,2)=max(Ang_Lkp18_Y);
% % % A_Max_Lkp18(:,3)=max(Ang_Lkp18_Z);
% % % A_Min_Lkp18(:,1)=min(Ang_Lkp18_X);
% % % A_Min_Lkp18(:,2)=min(Ang_Lkp18_Y);
% % % A_Min_Lkp18(:,3)=min(Ang_Lkp18_Z);
% % % 
% % % Lkp18_all=[A_Mean_Lkp18,A_Max_Lkp18,A_Min_Lkp18];
% % % 
% % % 
% % % 
% % % 
% % % Lkp_all=[Lkp1_all,Lkp5_all,Lkp6_all,Lkp9_all,Lkp10_all,Lkp13_all,Lkp14_all,Lkp17_all,Lkp18_all];
% % % 
% % % 
% % % 
% % % 
% % % %自身特征
% % % 
% % % A_Mean_Mkp1(:,1)=mean(Ang_Mkp1_X);
% % % A_Mean_Mkp1(:,2)=mean(Ang_Mkp1_Y);
% % % A_Mean_Mkp1(:,3)=mean(Ang_Mkp1_Z);
% % % A_Max_Mkp1(:,1)=max(Ang_Mkp1_X);
% % % A_Max_Mkp1(:,2)=max(Ang_Mkp1_Y);
% % % A_Max_Mkp1(:,3)=max(Ang_Mkp1_Z);
% % % A_Min_Mkp1(:,1)=min(Ang_Mkp1_X);
% % % A_Min_Mkp1(:,2)=min(Ang_Mkp1_Y);
% % % A_Min_Mkp1(:,3)=min(Ang_Mkp1_Z);
% % % 
% % % Mkp1_all=[A_Mean_Mkp1,A_Max_Mkp1,A_Min_Mkp1];
% % % 
% % % 
% % % 
% % % A_Mean_Mkp5(:,1)=mean(Ang_Mkp5_X);
% % % A_Mean_Mkp5(:,2)=mean(Ang_Mkp5_Y);
% % % A_Mean_Mkp5(:,3)=mean(Ang_Mkp5_Z);
% % % A_Max_Mkp5(:,1)=max(Ang_Mkp5_X);
% % % A_Max_Mkp5(:,2)=max(Ang_Mkp5_Y);
% % % A_Max_Mkp5(:,3)=max(Ang_Mkp5_Z);
% % % A_Min_Mkp5(:,1)=min(Ang_Mkp5_X);
% % % A_Min_Mkp5(:,2)=min(Ang_Mkp5_Y);
% % % A_Min_Mkp5(:,3)=min(Ang_Mkp5_Z);
% % % 
% % % Mkp5_all=[A_Mean_Mkp5,A_Max_Mkp5,A_Min_Mkp5];
% % % 
% % % 
% % % 
% % % A_Mean_Mkp6(:,1)=mean(Ang_Mkp6_X);
% % % A_Mean_Mkp6(:,2)=mean(Ang_Mkp6_Y);
% % % A_Mean_Mkp6(:,3)=mean(Ang_Mkp6_Z);
% % % A_Max_Mkp6(:,1)=max(Ang_Mkp6_X);
% % % A_Max_Mkp6(:,2)=max(Ang_Mkp6_Y);
% % % A_Max_Mkp6(:,3)=max(Ang_Mkp6_Z);
% % % A_Min_Mkp6(:,1)=min(Ang_Mkp6_X);
% % % A_Min_Mkp6(:,2)=min(Ang_Mkp6_Y);
% % % A_Min_Mkp6(:,3)=min(Ang_Mkp6_Z);
% % % 
% % % Mkp6_all=[A_Mean_Mkp6,A_Max_Mkp6,A_Min_Mkp6];
% % % 
% % % 
% % % 
% % % 
% % % A_Mean_Mkp9(:,1)=mean(Ang_Mkp9_X);
% % % A_Mean_Mkp9(:,2)=mean(Ang_Mkp9_Y);
% % % A_Mean_Mkp9(:,3)=mean(Ang_Mkp9_Z);
% % % A_Max_Mkp9(:,1)=max(Ang_Mkp9_X);
% % % A_Max_Mkp9(:,2)=max(Ang_Mkp9_Y);
% % % A_Max_Mkp9(:,3)=max(Ang_Mkp9_Z);
% % % A_Min_Mkp9(:,1)=min(Ang_Mkp9_X);
% % % A_Min_Mkp9(:,2)=min(Ang_Mkp9_Y);
% % % A_Min_Mkp9(:,3)=min(Ang_Mkp9_Z);
% % % 
% % % Mkp9_all=[A_Mean_Mkp9,A_Max_Mkp9,A_Min_Mkp9];
% % % 
% % % 
% % % A_Mean_Mkp10(:,1)=mean(Ang_Mkp10_X);
% % % A_Mean_Mkp10(:,2)=mean(Ang_Mkp10_Y);
% % % A_Mean_Mkp10(:,3)=mean(Ang_Mkp10_Z);
% % % A_Max_Mkp10(:,1)=max(Ang_Mkp10_X);
% % % A_Max_Mkp10(:,2)=max(Ang_Mkp10_Y);
% % % A_Max_Mkp10(:,3)=max(Ang_Mkp10_Z);
% % % A_Min_Mkp10(:,1)=min(Ang_Mkp10_X);
% % % A_Min_Mkp10(:,2)=min(Ang_Mkp10_Y);
% % % A_Min_Mkp10(:,3)=min(Ang_Mkp10_Z);
% % % 
% % % Mkp10_all=[A_Mean_Mkp10,A_Max_Mkp10,A_Min_Mkp10];
% % % 
% % % 
% % % 
% % % 
% % % A_Mean_Mkp13(:,1)=mean(Ang_Mkp13_X);
% % % A_Mean_Mkp13(:,2)=mean(Ang_Mkp13_Y);
% % % A_Mean_Mkp13(:,3)=mean(Ang_Mkp13_Z);
% % % A_Max_Mkp13(:,1)=max(Ang_Mkp13_X);
% % % A_Max_Mkp13(:,2)=max(Ang_Mkp13_Y);
% % % A_Max_Mkp13(:,3)=max(Ang_Mkp13_Z);
% % % A_Min_Mkp13(:,1)=min(Ang_Mkp13_X);
% % % A_Min_Mkp13(:,2)=min(Ang_Mkp13_Y);
% % % A_Min_Mkp13(:,3)=min(Ang_Mkp13_Z);
% % % 
% % % Mkp13_all=[A_Mean_Mkp13,A_Max_Mkp13,A_Min_Mkp13];
% % % 
% % % 
% % % 
% % % A_Mean_Mkp14(:,1)=mean(Ang_Mkp14_X);
% % % A_Mean_Mkp14(:,2)=mean(Ang_Mkp14_Y);
% % % A_Mean_Mkp14(:,3)=mean(Ang_Mkp14_Z);
% % % A_Max_Mkp14(:,1)=max(Ang_Mkp14_X);
% % % A_Max_Mkp14(:,2)=max(Ang_Mkp14_Y);
% % % A_Max_Mkp14(:,3)=max(Ang_Mkp14_Z);
% % % A_Min_Mkp14(:,1)=min(Ang_Mkp14_X);
% % % A_Min_Mkp14(:,2)=min(Ang_Mkp14_Y);
% % % A_Min_Mkp14(:,3)=min(Ang_Mkp14_Z);
% % % 
% % % Mkp14_all=[A_Mean_Mkp14,A_Max_Mkp14,A_Min_Mkp14];
% % % 
% % % 
% % % 
% % % A_Mean_Mkp17(:,1)=mean(Ang_Mkp17_X);
% % % A_Mean_Mkp17(:,2)=mean(Ang_Mkp17_Y);
% % % A_Mean_Mkp17(:,3)=mean(Ang_Mkp17_Z);
% % % A_Max_Mkp17(:,1)=max(Ang_Mkp17_X);
% % % A_Max_Mkp17(:,2)=max(Ang_Mkp17_Y);
% % % A_Max_Mkp17(:,3)=max(Ang_Mkp17_Z);
% % % A_Min_Mkp17(:,1)=min(Ang_Mkp17_X);
% % % A_Min_Mkp17(:,2)=min(Ang_Mkp17_Y);
% % % A_Min_Mkp17(:,3)=min(Ang_Mkp17_Z);
% % % 
% % % Mkp17_all=[A_Mean_Mkp17,A_Max_Mkp17,A_Min_Mkp17];
% % % 
% % % 
% % % 
% % % A_Mean_Mkp18(:,1)=mean(Ang_Mkp18_X);
% % % A_Mean_Mkp18(:,2)=mean(Ang_Mkp18_Y);
% % % A_Mean_Mkp18(:,3)=mean(Ang_Mkp18_Z);
% % % A_Max_Mkp18(:,1)=max(Ang_Mkp18_X);
% % % A_Max_Mkp18(:,2)=max(Ang_Mkp18_Y);
% % % A_Max_Mkp18(:,3)=max(Ang_Mkp18_Z);
% % % A_Min_Mkp18(:,1)=min(Ang_Mkp18_X);
% % % A_Min_Mkp18(:,2)=min(Ang_Mkp18_Y);
% % % A_Min_Mkp18(:,3)=min(Ang_Mkp18_Z);
% % % 
% % % Mkp18_all=[A_Mean_Mkp18,A_Max_Mkp18,A_Min_Mkp18];
% % % 
% % % 
% % % 
% % % 
% % % Mkp_all=[Mkp1_all,Mkp5_all,Mkp6_all,Mkp9_all,Mkp10_all,Mkp13_all,Mkp14_all,Mkp17_all,Mkp18_all];
% % % 
% % % 
% % % 
% % % 
% % % 
% % % 
% % % %世界特征
% % % A_Mean_Wkp(:,1)=mean(Ang_Wkp_X);
% % % A_Mean_Wkp(:,2)=mean(Ang_Wkp_Y);
% % % A_Mean_Wkp(:,3)=mean(Ang_Wkp_Z);
% % % A_Max_Wkp(:,1)=max(Ang_Wkp_X);
% % % A_Max_Wkp(:,2)=max(Ang_Wkp_Y);
% % % A_Max_Wkp(:,3)=max(Ang_Wkp_Z);
% % % A_Min_Wkp(:,1)=min(Ang_Wkp_X);
% % % A_Min_Wkp(:,2)=min(Ang_Wkp_Y);
% % % A_Min_Wkp(:,3)=min(Ang_Wkp_Z);
% % % 
% % % 
% % % Wkp_all=[A_Mean_Wkp,A_Max_Wkp,A_Min_Wkp];
% % % 
% % % 
% % % 
% % % 
% % % 
% % % 
% % % %  TZ_acp_R(jj,:)=[Lkp_all,Mkp_all,Wkp_all];
% % %   TZ_acp_R(jj,:)=[Mkp_all];
% % % 
% % % 
% % % clearvars -except Bag kk jj TZ_acp_R 

 end
 
%  TZ_acp_R(isnan(TZ_acp_R)) = 0;

% TZ_acp_R_T=abs(TZ_acp_R');
% 
% [TZ_acp_R_T,ps] = mapminmax(TZ_acp_R_T,0,1); %%标准化
% 
% TZ_acp_R_Std=TZ_acp_R_T';
%  
% TZ_acp_R_New=TZ_acp_R_Std.*(TZ_acp_R./abs(TZ_acp_R));
 
 
 Ang=Ang_Temp';
 
 
 XLAng=Ang;
 
 
 clearvars -except XLAng
 save XLAng
 
 