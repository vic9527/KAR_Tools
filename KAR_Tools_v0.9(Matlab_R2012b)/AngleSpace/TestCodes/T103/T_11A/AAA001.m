clear;clc;
warning off
format long g %不采用科学计数法


 
list=dir(['A1\','*.txt']);
kk2=length(list);
 for ii=1:kk2
     str = strcat ('A1\', list(ii).name);
     Bag{ii}=load(str);
 end
 
%  clearvars -except Bag kk2 b str
 
 
 
  for jj=1:kk2
     
 
 Number=jj
% % %  jj=10;
 A=Bag{jj};%载入数据
 
% %  A_MF = medfilt1(A);
 



% % % [mm,nn]=size(A);
% % % A_80=reshape(A',nn*20,mm/20)'; 
% % % A_80=[ones(size(A_80,1),1),A_80];


A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end
kones=ones(size(A,1),1);
% A_80=[kones,k7,kones,k4,kones,k3,kones,k20,kones,k2,kones,k9,kones,k11,kones,k13,kones,k1,kones,k8,kones,k10,kones,k12,kones,k6,kones,k15,kones,k17,kones,k19,kones,k5,kones,k14,kones,k16,kones,k18,kones];
 A_80=[kones,k7,kones,k4,kones,k3,kones,k20,kones,k1,kones,k1,kones,k1,kones,k1,kones,k2,kones,k9,kones,k11,kones,k13,kones,k6,kones,k15,kones,k17,kones,k19,kones,k5,kones,k14,kones,k16,kones,k18,kones];

% % % A(:,4)=[];
% % % [mm,nn]=size(A);
% % % A=reshape(A',nn*20,mm/20)'; 

% 
% %数据清洗和补全 重采样
% XX=size(A,1);
% xx=(1:XX)';
% for pp=1:60
%     %pp=26;
% spA=spap2(4,3,xx,A(:,pp));
% D_spA = fnval(spA,xx);
% A(:,pp)=D_spA;
% % scatter(xx,A(:,26))
% % fnplt(spA,'r');
% end
% % 

% % % A_MF = medfilt1(A);
% % % A=A_MF;
% % % 
% % % % B = smooth(A(:,10),'lowess');
% % % plot(A(:,10));
% % % hold on;
% % % plot(A_MF(:,10));
% % % 
% % % for i=1:20;
% % % eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
% % % end
% % % 
% % % P9_Larm=k2-k9;
% % % P9_Sarm=k11-k9;
% % % P9_IA=acosd((dot(P9_Larm,P9_Sarm,2))./(sqrt(sum(P9_Larm.^2,2)).*sqrt(sum(P9_Sarm.^2,2))));
% % % figure,plot(P9_IA);
% % % 
% % % 
% % % P9_IA_Diff=diff(P9_IA);
% % % figure,plot(P9_IA_Diff);
% % % % hold on;
% % % 
% % % 
% % % XX=size(P9_IA,1);
% % % nn=(1:(XX-1)/59:XX)';
% % % xx=(1:XX)';
% % % for pp=1:1
% % %     %pp=3;
% % % SP_P9_IA=spap2(4,3,xx,P9_IA(:,pp));
% % % D_SP_P9_IA = fnval(SP_P9_IA,nn);
% % % D_SP_P9_IA_all(:,pp)=D_SP_P9_IA;
% % % % scatter(nn,D_SP_P9_IA_all(:,1))
% % % % hold on;fnplt(SP_P9_IA,'r');
% % % % hold on;
% % % plot(D_SP_P9_IA);
% % % D_SP_P9_IA_Diff=diff(D_SP_P9_IA);
% % % figure,plot(D_SP_P9_IA_Diff);
% % % hold on;
% % % end
% % % 
% % % 
% % % 






% Cls_X=k3-k7;
% Cls_Y=k2-k1;
% Cls_Z=cross(Cls_X,Cls_Y);
% 
% Cls_X_e=Cls_X./repmat(sqrt(sum(Cls_X.^2,2)),1,3);
% Cls_Y_e=Cls_Y./repmat(sqrt(sum(Cls_Y.^2,2)),1,3);
% Cls_Z_e=Cls_Z./repmat(sqrt(sum(Cls_Z.^2,2)),1,3);
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% WC2Cls_V1=k9-k2;
% WC_D=WC2Cls_V1;
% Cls_xx=size(WC_D,1);
% for i=1:Cls_xx
%     %i=3;
% TM=[Cls_X_e(i,:);Cls_Y_e(i,:);Cls_Z_e(i,:)]; 
% Cls_V1(i,:)=(TM*(WC_D(i,:))')';
% end
% 
% WC2Cls_V2=k11-k2;
% WC_D=WC2Cls_V2;
% Cls_xx=size(WC_D,1);
% for i=1:Cls_xx
% TM=[Cls_X_e(i,:);Cls_Y_e(i,:);Cls_Z_e(i,:)]; 
% Cls_V2(i,:)=(TM*(WC_D(i,:))')';
% end
% 
% Sarm=Cls_V2-Cls_V1;
% 
% LSarm_Cross=cross(Cls_V1,Sarm);
% YLarm_Cross=cross(Cls_Y_e,Cls_V1);
% 
% Larm_IA_XZ=atand(Cls_V1(:,1)./Cls_V1(:,3));
% Larm_IA_Y=acosd(Cls_V1(:,2)./sqrt(sum(Cls_V1.^2,2)));
% Larm_DA=acosd(dot(LSarm_Cross,YLarm_Cross,2)./(sqrt(sum(LSarm_Cross.^2,2)).*sqrt(sum(YLarm_Cross.^2,2))));
% LSarm_IA=acosd(dot(Cls_V1,Sarm,2)./(sqrt(sum(Cls_V1.^2,2)).*sqrt(sum(Sarm.^2,2))));
% 
% TZ_Cls_one=[Larm_IA_XZ,Larm_IA_Y,Larm_DA,LSarm_IA];
% 
%  clearvars -except Bag kk2 b TZ_Cls_one jj TZ_Cls

 
 
 
 
% XX=size(TZ_Cls_one,1);
% nn=(1:(XX-1)/9:XX)';
% xx=(1:XX)';
% for pp=1:4
%     %pp=3;
% TZ_Cls_spA=spap2(4,3,xx,TZ_Cls_one(:,pp));
% TZ_Cls_D_spA = fnval(TZ_Cls_spA,nn);
% TZ_Cls_spone(:,pp)=TZ_Cls_D_spA;
% % scatter(nn,TZ_Cls_spone(:,2))
% % figure,fnplt(TZ_Cls_spA,'r');
% % hold on;
% end
% % 
% 
% 
% TZ_Cls_spone200=reshape(TZ_Cls_spone',[1,10*4]);
% 
% TZ_Cls(jj,:)=(TZ_Cls_spone200);




% % % SaveName = strcat ('A1_skeleton_MF\', list(jj).name);
% % % 
% % % % save Save_str -ascii A_MF
% % % % eval(['save ' list(ii).name '.txt A_MF -ASCII'])
% % % eval(['save ' SaveName ' A_MF -ASCII'])




SaveName = strcat ('A1_skeleton_80\', list(jj).name);
eval(['save ' SaveName ' A_80 -ASCII'])

  end

   
  
  

