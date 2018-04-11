clear;clc;
warning off
format long g %不采用科学计数法


 
list=dir(['onearm\','*.txt']);
kk2=length(list);
 for ii=1:kk2
     str = strcat ('onearm\', list(ii).name);
     Bag{ii}=load(str);
 end
 
%  clearvars -except Bag kk2 b str
 
 
 
  for jj=1:kk2
     
 
 Number=jj
% % %  jj=13;
 A=Bag{jj};%载入数据



A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

A_MF = medfilt1(A); 
A=A_MF;



for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end




P2_Larm=k9-k2;
P2_Larm_Norm=sqrt(sum(P2_Larm.^2,2));
P2_IA_X=acosd(P2_Larm(:,1)./P2_Larm_Norm);
P2_IA_Y=acosd(P2_Larm(:,2)./P2_Larm_Norm);
P2_IA_Z=acosd(P2_Larm(:,3)./P2_Larm_Norm);
P2_IA=[P2_IA_X,P2_IA_Y,P2_IA_Z];

P9_Larm=k2-k9;
P9_Sarm=k11-k9;
P9_IA=acosd((dot(P9_Larm,P9_Sarm,2))./(sqrt(sum(P9_Larm.^2,2)).*sqrt(sum(P9_Sarm.^2,2))));
%  figure,plot(P2_IA(:,1));
%  hold on;
%   end



Ang=[P2_IA,P9_IA];
XX=size(Ang,1);
xx=(1:XX)';
cc=(1:(XX-1)/99:XX)';
for pp=1:4
    %pp=1;
spAng=spap2(XX,3,xx,Ang(:,pp));
D_spAng = fnval(spAng,cc);
% clearvars AngSP
AngSP(:,pp)=D_spAng;
% scatter(xx,Ang(:,1))
% fnplt(spAng,'r');
% hold on;
% plot(AngSP(:,1));
% hold on;
end
% 

% Ang_oppo=180-Ang;
% for pp=1:4
%     %pp=1;
% [MaxV,MaxL]=findpeaks(Ang(:,pp)); 
% [MinV,MinL]=findpeaks(Ang_oppo(:,pp)); 
% Ang_MaxV(jj,pp)=mean(MaxV);
% Ang_MinV(jj,pp)=mean(Ang(MinL));
% end

AngSP_oppo=180-AngSP;
for pp=1:4
    %pp=1;
[MaxV,MaxL]=findpeaks(AngSP(:,pp)); 
[MinV,MinL]=findpeaks(AngSP_oppo(:,pp)); 
AngSP_MaxV(jj,pp)=mean(MaxV);
AngSP_MinV(jj,pp)=mean(AngSP(MinL));
end




  end


% [pks,locs] = findpeaks(Ang)
% [MaxV,MaxL]=findpeaks(AngSP(:,1)); 
% Ang_oppo=180-Ang;
% [MinV,MinL]=findpeaks(Ang_oppo); 
% MinV=Ang(MinL)


% figure,plot(Ang);
%   end

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






% 
%   end

   
  
  

