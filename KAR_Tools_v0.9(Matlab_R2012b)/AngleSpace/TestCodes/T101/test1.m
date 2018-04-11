clear;clc;
% clearvars -except TZ_acp_R TZ_acp_R1 TZ_acp_R2 TZ_acp_R3 TZ_acp_R4 TZ_acp_R5 TZ_acp_R6 TZ_acp_R7 TZ_acp_R8 TZ_acp_R9 TZ_acp_R10 TZ_acp_R11 TZ_acp_R12;
warning off
format long g %不采用科学计数法

list=dir(['MSRAction3DSkeletonReal3D\','*.txt']);%%%%%%%%%%step1:修改G1;
kk=length(list);
 for ii=1:kk
     str = strcat ('MSRAction3DSkeletonReal3D\', list(ii).name);%%%%%%%%%%step2:修改G1;
     Bag{ii}=load(str);
 end
 
 for jj=1:kk
     
% % %  clearvars -except Bag kk jj TZ_acp_R V_Diff V_CT_Diff
 
 Number=jj
 A=Bag{jj};%载入数据
 
 
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Ctr_Tri1=k7;
Ctr_Tri2=((k2+k9+k11)-3.*k7)./3;
Ctr_Tri3=((k1+k8+k10)-3.*k7)./3;
Ctr_Tri4=((k6+k15+k17)-3.*k7)./3;
Ctr_Tri5=((k5+k14+k16)-3.*k7)./3;

CT_Diff1=sum(abs(diff(Ctr_Tri1)).^2,2).^(1/2);
CT_Diff2=sum(abs(diff(Ctr_Tri2)).^2,2).^(1/2);
CT_Diff3=sum(abs(diff(Ctr_Tri3)).^2,2).^(1/2);
CT_Diff4=sum(abs(diff(Ctr_Tri4)).^2,2).^(1/2);
CT_Diff5=sum(abs(diff(Ctr_Tri5)).^2,2).^(1/2);

% % % jj=1;
% V_CT_Diff(jj,1)=var(CT_Diff1);
% V_CT_Diff(jj,2)=var(CT_Diff2);
% V_CT_Diff(jj,3)=var(CT_Diff3);
% V_CT_Diff(jj,4)=var(CT_Diff4);
% V_CT_Diff(jj,5)=var(CT_Diff5);

V_CT_Diff(jj,:)=[var(CT_Diff1),var(CT_Diff2),var(CT_Diff3),var(CT_Diff4),var(CT_Diff5)];

% min(V_CT_Diff(1:end,2))
%threshold 设置阈值
Threshold = 0.0005;
V_CT_Diff(V_CT_Diff>=Threshold)=1;
V_CT_Diff(V_CT_Diff<Threshold)=0;

% % % V_CT_temp=num2str(V_CT_Diff);  
% % % V_CT_temp=char(strrep(cellstr(V_CT_temp),' ',''))
% % % V_CT_bin = bin2dec(V_CT_temp);





spv9up=k2-k9;
spv9dn=k11-k9;

spv8up=k1-k8;
spv8dn=k10-k8;

spv15up=k6-k15;
spv15dn=k17-k15;

spv14up=k5-k14;
spv14dn=k16-k14;

norm_spv5_6=sum(abs(spv9up).^2,2).^(1/2);
norm_spv7_6=sum(abs(spv9dn).^2,2).^(1/2);
D_acp4=acosd((dot(spv9up,spv9dn,2))./(norm_spv5_6.*norm_spv7_6));

norm_spv9_10=sum(abs(spv8up).^2,2).^(1/2);
norm_spv11_10=sum(abs(spv8dn).^2,2).^(1/2);
D_acp7=acosd((dot(spv8up,spv9dn,2))./(norm_spv9_10.*norm_spv11_10));

norm_spv13_14=sum(abs(spv15up).^2,2).^(1/2);
norm_spv15_14=sum(abs(spv15dn).^2,2).^(1/2);
D_acp10=acosd((dot(spv15up,spv15dn,2))./(norm_spv13_14.*norm_spv15_14));

norm_spv17_18=sum(abs(spv14up).^2,2).^(1/2);
norm_spv19_18=sum(abs(spv14dn).^2,2).^(1/2);
D_acp13=acosd((dot(spv14up,spv14dn,2))./(norm_spv17_18.*norm_spv19_18));

xx=size(A,1);
X=(1:xx)';
XX=(0:0.01:xx)';

sp1=spap2(4,3,X,D_acp4);
sp2=spap2(4,3,X,D_acp7);
sp3=spap2(4,3,X,D_acp10);
sp4=spap2(4,3,X,D_acp13);
F_fnder1=fnder(sp1,1); 
F_fnder2=fnder(sp2,1); 
F_fnder3=fnder(sp3,1); 
F_fnder4=fnder(sp4,1); 
T_fnder1=fnder(sp1,2); 
T_fnder2=fnder(sp2,2); 
T_fnder3=fnder(sp3,2); 
T_fnder4=fnder(sp4,2); 

D_sp1 = fnval(sp1,XX);
D_sp2 = fnval(sp2,XX);
D_sp3 = fnval(sp3,XX);
D_sp4 = fnval(sp4,XX);
D_F_fnder1=fnval(F_fnder1,XX); 
D_F_fnder2=fnval(F_fnder2,XX); 
D_F_fnder3=fnval(F_fnder3,XX); 
D_F_fnder4=fnval(F_fnder4,XX); 
D_T_fnder1=fnval(T_fnder1,XX); 
D_T_fnder2=fnval(T_fnder2,XX); 
D_T_fnder3=fnval(T_fnder3,XX); 
D_T_fnder4=fnval(T_fnder4,XX); 




% % Diff1=abs(diff(D_sp1));
% % Diff2=abs(diff(D_sp2));
% % Diff3=abs(diff(D_sp3));
% % Diff4=abs(diff(D_sp4));


% % Mean_Diff1=mean(Diff1);
% % Mean_Diff2=mean(Diff2);
% % Mean_Diff3=mean(Diff3);
% % Mean_Diff4=mean(Diff4);

% % % V_Diff(jj,1)=var(Diff1);
% % % V_Diff(jj,2)=var(Diff2);
% % % V_Diff(jj,3)=var(Diff3);
% % % V_Diff(jj,4)=var(Diff4);


% % % V_Diff(V_Diff>=threshold )=1;
% % % V_Diff(V_Diff<0.8)=0;
% %  
% % 
% %  



Max_D_sp1 = max(D_sp1);
Min_D_sp1 = min(D_sp1);
Max_D_F_fnder1 = max(D_F_fnder1);
Min_D_F_fnder1 = min(D_F_fnder1);
Max_D_T_fnder1 = max(D_T_fnder1);
Min_D_T_fnder1 = min(D_T_fnder1);

Max_D_sp2 = max(D_sp2);
Min_D_sp2 = min(D_sp2);
Max_D_F_fnder2 = max(D_F_fnder2);
Min_D_F_fnder2 = min(D_F_fnder2);
Max_D_T_fnder2 = max(D_T_fnder2);
Min_D_T_fnder2 = min(D_T_fnder2);

Max_D_sp3 = max(D_sp3);
Min_D_sp3 = min(D_sp3);
Max_D_F_fnder3 = max(D_F_fnder3);
Min_D_F_fnder3 = min(D_F_fnder3);
Max_D_T_fnder3 = max(D_T_fnder3);
Min_D_T_fnder3 = min(D_T_fnder3);

Max_D_sp4 = max(D_sp4);
Min_D_sp4 = min(D_sp4);
Max_D_F_fnder4 = max(D_F_fnder4);
Min_D_F_fnder4 = min(D_F_fnder4);
Max_D_T_fnder4 = max(D_T_fnder4);
Min_D_T_fnder4 = min(D_T_fnder4);

% % % Max_D_sp2 = max(D_sp2);
% % % Min_D_sp2 = min(D_sp2);
% % % Max_F_sp2 = max(D_Fsp2);
% % % Max_T_sp2 = max(D_Tsp2);
% % % 
% % % Max_D_sp3 = max(D_sp3);
% % % Min_D_sp3 = min(D_sp3);
% % % Max_F_sp3 = max(D_Fsp3);
% % % Max_T_sp3 = max(D_Tsp3);
% % % 
% % % Max_D_sp4 = max(D_sp4);
% % % Min_D_sp4 = min(D_sp4);
% % % Max_F_sp4 = max(D_Fsp4);
% % % Max_T_sp4 = max(D_Tsp4);

% % % jj=1
% % % TZ_acp_R(jj,:)=[Max_D_sp1,Max_D_sp2,Max_D_sp3,Max_D_sp4,Min_D_sp1,Min_D_sp2,Min_D_sp3,Min_D_sp4,Max_F_sp1,Max_F_sp2,Max_F_sp3,Max_F_sp4,Max_T_sp1,Max_T_sp2,Max_T_sp3,Max_T_sp4];
% % % clearvars -except TZ_acp_R Bag ii kk list str;
TZ_acp_R(jj,:)=[Max_D_sp1,Min_D_sp1,Max_D_F_fnder1,Min_D_F_fnder1,Max_D_T_fnder1,Min_D_T_fnder1,Max_D_sp2,Min_D_sp2,Max_D_F_fnder2,Min_D_F_fnder2,Max_D_T_fnder2,Min_D_T_fnder2,Max_D_sp3,Min_D_sp3,Max_D_F_fnder3,Min_D_F_fnder3,Max_D_T_fnder3,Min_D_T_fnder3,Max_D_sp4,Min_D_sp4,Max_D_F_fnder4,Min_D_F_fnder4,Max_D_T_fnder4,Min_D_T_fnder4];



%  plot(1:53,Diff3);
%  hold on;
% % % taylor = fnval(sp1,X);
% % % tstar = aveknt(t,k) 
% % % jumps = fnjmp(sp1,X) 
% % % scatter(X,D_acp4);
% % % hold on;
% % % plot(X,taylor);
% % % hold on;
% % % sp1=spap2(4,3,X,D_acp10);
% % % plot(X,D_acp4);
% % % hold on;
% % % fnplt(sp1,'r');
% % % yy = 1:size(D_acp13,1); zz = fnval(sp4,yy);%计算拟合的数据
% % % tt=polyfit(X,vals',12);
% % % z=polyval(tt,X);
% % % plot(X,vals,'r*',X,z,'b');

clearvars -except Bag kk jj TZ_acp_R V_CT_Diff

 end
 
V_CT_temp=num2str(V_CT_Diff);  
V_CT_temp=char(strrep(cellstr(V_CT_temp),' ',''));
V_CT_bin = bin2dec(V_CT_temp);
V_CT_Diff=[V_CT_Diff,V_CT_bin];

TZ_labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(30,1);11*ones(30,1);12*ones(30,1);13*ones(29,1);14*ones(30,1);15*ones(20,1);16*ones(30,1);17*ones(30,1);18*ones(30,1);19*ones(30,1);20*ones(30,1)]; %%给样本贴上类别标签
TZ_all=[TZ_labels,V_CT_Diff,TZ_acp_R];
 
clearvars -except TZ_all
 
TZ_XLJ=TZ_all;

id=randperm(566,200);
TZ_CSJ=TZ_all(id,:);
TZ_XLJ(id,:)=[];
 
% % %  CT_Cls = unique(TZ_all(:,7));
 XLJ_Cls = unique(TZ_XLJ(:,7));
 CSJ_Cls = unique(TZ_CSJ(:,7));

 
 for cc=1:size(CT_Cls,1);
eval(['CT_ID_',num2str(cc),'=','find(TZ_all(:,7)==CT_Cls(cc))',';']);
end
% %  clearvars cc CT_Cls
 
All_sub_label=0;
All_predict_label=0;
TZ_Sub_Temp_abn=0;
 for cc=1:size(CT_Cls,1);
CT_ID_Temp = find(TZ_all(:,7)==CT_Cls(cc)); 
% % % eval(['TZ_ID_',num2str(cc),'=','TZ_all(CT_ID_Temp,:)',';']);
    if size(CT_ID_Temp,1)<10 %小于10即为异常值，归一类。
    TZ_Sub_Temp_abn = [TZ_Sub_Temp_abn;CT_ID_Temp];
    continue;
    else
    TZ_Sub_Temp = TZ_all(CT_ID_Temp,:);
    end

TZ_XL_label = TZ_Sub_Temp(:,1);
TZ_XL_inst = TZ_Sub_Temp(:,8:end);

[AA,ps] = mapminmax(TZ_XL_inst',0,1); %%标准化
TZ_XL_inst = AA';

%寻找最佳SVM参数值
[bestmse,bestc,bestg] = SVMcgForClass(TZ_XL_label,TZ_XL_inst,-5,5,-5,5,3,1,1,1.5);
cmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg)];
%训练模型
model = svmtrain(TZ_XL_label,TZ_XL_inst,cmd);

%测试模型效果
[predict_label,accuracy,decision_values] = svmpredict(TZ_XL_label,TZ_XL_inst,model);
    

All_sub_label=[All_sub_label;TZ_XL_label];
All_predict_label=[All_predict_label;predict_label];

clearvars -except TZ_all CT_Cls cc All_sub_label All_predict_label TZ_Sub_Temp_abn

 end 
 
%对异常值进行svm
TZ_Sub_Temp_abn(1,:) = [];
TZ_Sub_Temp = TZ_all(TZ_Sub_Temp_abn,:); 
TZ_XL_label = TZ_Sub_Temp(:,1);
TZ_XL_inst = TZ_Sub_Temp(:,8:end);
[AA,ps] = mapminmax(TZ_XL_inst',0,1); %%标准化
TZ_XL_inst = AA';
%寻找最佳SVM参数值
[bestmse,bestc,bestg] = SVMcgForClass(TZ_XL_label,TZ_XL_inst,-5,5,-5,5,3,1,1,1.5);
cmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg)];
%训练模型
model = svmtrain(TZ_XL_label,TZ_XL_inst,cmd);
%测试模型效果
[predict_label,accuracy,decision_values] = svmpredict(TZ_XL_label,TZ_XL_inst,model);


All_sub_label(1,:) = [];
All_predict_label(1,:) = [];
All_sub_label=[All_sub_label;TZ_XL_label];
All_predict_label=[All_predict_label;predict_label];

C = cfmatrix(All_sub_label,All_predict_label);
% % % numel(setdiff(All_sub_label,All_predict_label))
P_Dft=All_predict_label(find(All_sub_label~=All_predict_label));

Fin_accuracy = 1-(size(P_Dft,1))/(size(All_sub_label,1));
F_P_accuracy=strcat(num2str(Fin_accuracy*100),'%')





 save TZ_20act_24;
 
 
 
 
 
 
 
 
 
 
 
 