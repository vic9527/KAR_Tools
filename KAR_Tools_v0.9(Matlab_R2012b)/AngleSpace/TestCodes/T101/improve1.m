clear;clc;
% clearvars -except TZ_acp_R TZ_acp_R1 TZ_acp_R2 TZ_acp_R3 TZ_acp_R4 TZ_acp_R5 TZ_acp_R6 TZ_acp_R7 TZ_acp_R8 TZ_acp_R9 TZ_acp_R10 TZ_acp_R11 TZ_acp_R12;
warning off
format long g %不采用科学计数法

list=dir(['AS\AS1\','*.txt']);%%%%%%%%%%step1:修改G1;
kk=length(list);
 for ii=1:kk
     str = strcat ('AS\AS1\', list(ii).name);%%%%%%%%%%step2:修改G1;
     Bag{ii}=load(str);
 end
 
 for jj=1:kk
     
% % %  clearvars -except Bag kk jj TZ_acp_R V_Diff V_CT_Diff
%  jj=1;
 Number=jj
 A=Bag{jj};%载入数据
 
 
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

P1_R1=k20-k3;
P1_R2=k3-k4;
P1_R3=k4-k7;

P2_R1=k13-k11;
P2_R2=k11-k9;
P2_R3=k9-k2;

P3_R1=k12-k10;
P3_R2=k10-k8;
P3_R3=k8-k1;

P4_R1=k19-k17;
P4_R2=k17-k15;
P4_R3=k15-k6;

P5_R1=k18-k16;
P5_R2=k16-k14;
P5_R3=k14-k5;













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
 
TZJ=TZ_all;

TZJ(:,8:13)=bsxfun(@times,TZJ(:,8:13),TZJ(:,3));
TZJ(:,14:19)=bsxfun(@times,TZJ(:,14:19),TZJ(:,4));
TZJ(:,20:25)=bsxfun(@times,TZJ(:,20:25),TZJ(:,5));
TZJ(:,26:31)=bsxfun(@times,TZJ(:,26:31),TZJ(:,6));

% % % id=randperm(566,200);
% % % TZ_CSJ=TZ_all(id,:);
% % % TZ_XLJ(id,:)=[];
% % %  
% % % % % %  CT_Cls = unique(TZ_all(:,7));
% % %  XLJ_Cls = unique(TZ_XLJ(:,7));
% % %  CSJ_Cls = unique(TZ_CSJ(:,7));
% % % 
% % %  
% % %  for cc=1:size(CT_Cls,1);
% % % eval(['CT_ID_',num2str(cc),'=','find(TZ_all(:,7)==CT_Cls(cc))',';']);
% % % end
% % % % %  clearvars cc CT_Cls
% % %  
% % % All_sub_label=0;
% % % All_predict_label=0;
% % % TZ_Sub_Temp_abn=0;
% % %  for cc=1:size(CT_Cls,1);
% % % CT_ID_Temp = find(TZ_all(:,7)==CT_Cls(cc)); 
% % % % % % eval(['TZ_ID_',num2str(cc),'=','TZ_all(CT_ID_Temp,:)',';']);
% % %     if size(CT_ID_Temp,1)<10 %小于10即为异常值，归一类。
% % %     TZ_Sub_Temp_abn = [TZ_Sub_Temp_abn;CT_ID_Temp];
% % %     continue;
% % %     else
% % %     TZ_Sub_Temp = TZ_all(CT_ID_Temp,:);
% % %     end
% % % 
% % % TZ_XL_label = TZ_Sub_Temp(:,1);
% % % TZ_XL_inst = TZ_Sub_Temp(:,8:end);
% % % 
% % % [AA,ps] = mapminmax(TZ_XL_inst',0,1); %%标准化
% % % TZ_XL_inst = AA';
% % % 
% % % %寻找最佳SVM参数值
% % % [bestmse,bestc,bestg] = SVMcgForClass(TZ_XL_label,TZ_XL_inst,-5,5,-5,5,3,1,1,1.5);
% % % cmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg)];
% % % %训练模型
% % % model = svmtrain(TZ_XL_label,TZ_XL_inst,cmd);
% % % 
% % % %测试模型效果
% % % [predict_label,accuracy,decision_values] = svmpredict(TZ_XL_label,TZ_XL_inst,model);
% % %     
% % % 
% % % All_sub_label=[All_sub_label;TZ_XL_label];
% % % All_predict_label=[All_predict_label;predict_label];
% % % 
% % % clearvars -except TZ_all CT_Cls cc All_sub_label All_predict_label TZ_Sub_Temp_abn
% % % 
% % %  end 
% % %  
% % % %对异常值进行svm
% % % TZ_Sub_Temp_abn(1,:) = [];
% % % TZ_Sub_Temp = TZ_all(TZ_Sub_Temp_abn,:); 
% % % TZ_XL_label = TZ_Sub_Temp(:,1);
% % % TZ_XL_inst = TZ_Sub_Temp(:,8:end);
% % % [AA,ps] = mapminmax(TZ_XL_inst',0,1); %%标准化
% % % TZ_XL_inst = AA';
% % % %寻找最佳SVM参数值
% % % [bestmse,bestc,bestg] = SVMcgForClass(TZ_XL_label,TZ_XL_inst,-5,5,-5,5,3,1,1,1.5);
% % % cmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg)];
% % % %训练模型
% % % model = svmtrain(TZ_XL_label,TZ_XL_inst,cmd);
% % % %测试模型效果
% % % [predict_label,accuracy,decision_values] = svmpredict(TZ_XL_label,TZ_XL_inst,model);
% % % 
% % % 
% % % All_sub_label(1,:) = [];
% % % All_predict_label(1,:) = [];
% % % All_sub_label=[All_sub_label;TZ_XL_label];
% % % All_predict_label=[All_predict_label;predict_label];
% % % 
% % % C = cfmatrix(All_sub_label,All_predict_label);
% % % % % % numel(setdiff(All_sub_label,All_predict_label))
% % % P_Dft=All_predict_label(find(All_sub_label~=All_predict_label));
% % % 
% % % Fin_accuracy = 1-(size(P_Dft,1))/(size(All_sub_label,1));
% % % F_P_accuracy=strcat(num2str(Fin_accuracy*100),'%')
% % % 




 save TZ_20act_24;
 
 
 
 
 
 
 
 
 
 
 
 