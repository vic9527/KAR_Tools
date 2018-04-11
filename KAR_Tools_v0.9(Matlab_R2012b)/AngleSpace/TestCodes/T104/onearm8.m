clear;clc;
warning off
format long g %不采用科学计数法

list=dir(['onearm\','*.txt']);
kk1=length(list);
 for ii=1:kk1
     str = strcat ('onearm\', list(ii).name);
     Bag_LR{ii}=load(str);
 end
 
 
 
  for jj=1:kk1
     
 
 Number=jj
% % %  jj=100;
 A=Bag_LR{jj};%载入数据
 

  
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

% % % A_MF = medfilt1(A); 
% % % A=A_MF;




% % % TT=30;
% % % WW=size(A,2);
% % % XX=size(A,1);
% % % nn=(1:(XX-1)/(TT-1):XX)';
% % % xx=(1:XX)';
% % % for pp=1:WW
% % %     %pp=3;
% % % spA=spap2(XX/2,3,xx,A(:,pp));
% % % D_spA = fnval(spA,nn);
% % % AA(:,pp)=D_spA;
% % % 
% % % end
% % % 
% % % A=AA;








for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Asize=size(A,1);




% % % % % % % % % % % VRA_C=k5-k3;
% % % % % % % % % % % VRA92=k9-k2;
% % % % % % % % % % % VRA29=k2-k9;
% % % % % % % % % % % 
% % % % % % % % % % % VRA119=k11-k9;
% % % % % % % % % % % 
% % % % % % % % % % %  for i = 1:Asize
% % % % % % % % % % %    VRA1_V(i,:)=acosd(dot(VRA_C(i,:),VRA92(i,:),2)/(norm(VRA_C(i,:))*norm(VRA92(i,:))));
% % % % % % % % % % %    VRA2_V(i,:)=acosd(dot(VRA29(i,:),VRA119(i,:),2)/(norm(VRA29(i,:))*norm(VRA119(i,:))));
% % % % % % % % % % % end
% % % % % % % % % % % 
% % % % % % % % % % % VRA1_VD=diff(VRA1_V);
% % % % % % % % % % % VRA2_VD=diff(VRA2_V);
% % % % % % % % % % % 
% % % % % % % % % % % VRA1_VD(VRA1_VD>0)=1;
% % % % % % % % % % % VRA1_VD(VRA1_VD<0)=0;
% % % % % % % % % % % VRA2_VD(VRA2_VD>0)=1;
% % % % % % % % % % % VRA2_VD(VRA2_VD<0)=0;
% % % % % % % % % % % 
% % % % % % % % % % % VRA_VD=[VRA1_VD,VRA2_VD];
% % % % % % % % % % % 
% % % % % % % % % % % V_CT_temp=num2str(VRA_VD);  
% % % % % % % % % % % V_CT_temp=char(strrep(cellstr(V_CT_temp),' ',''));
% % % % % % % % % % % VRA_HMM_O = bin2dec(V_CT_temp);
% % % % % % % % % % % VRA_HMM_O(VRA_HMM_O==0)=4;
% % % % % % % % % % % 
% % % % % % % % % % %  clearvars -except Bag_LR kk1 jj VRA_HMM_O VRA_HMM_O_all VRA_HMM_O_mat
% % % % % % % % % % % 
% % % % % % % % % % % VRA_HMM_O_mat(jj,:)=VRA_HMM_O';
% % % % % % % % % % % VRA_HMM_O_all{jj}=VRA_HMM_O';








VRA1=k9-k2;
% VRA2=k11-k2;
% VRA3=k13-k2;
VRA4=k11-k9;
% VRA5=k13-k9;
VRA6=k13-k11;

VRA1S=VRA1./[sqrt(sum(VRA1.^2,2)),sqrt(sum(VRA1.^2,2)),sqrt(sum(VRA1.^2,2))];
% VRA2S=VRA2./[sqrt(sum(VRA2.^2,2)),sqrt(sum(VRA2.^2,2)),sqrt(sum(VRA2.^2,2))];
% VRA3S=VRA3./[sqrt(sum(VRA3.^2,2)),sqrt(sum(VRA3.^2,2)),sqrt(sum(VRA3.^2,2))];
VRA4S=VRA4./[sqrt(sum(VRA4.^2,2)),sqrt(sum(VRA4.^2,2)),sqrt(sum(VRA4.^2,2))];
% VRA5S=VRA5./[sqrt(sum(VRA5.^2,2)),sqrt(sum(VRA5.^2,2)),sqrt(sum(VRA5.^2,2))];
VRA6S=VRA6./[sqrt(sum(VRA6.^2,2)),sqrt(sum(VRA6.^2,2)),sqrt(sum(VRA6.^2,2))];

VRAnS=[VRA1S,VRA4S,VRA6S];

VRAnS_D=diff(VRAnS);


VRA01=VRAnS_D;
VRA01(VRA01>0)=1;
VRA01(VRA01<0)=0;

% for i = 2:Asize
% VRA1S_D(i-1,:)=VRA1S(i,:)-VRA1S(1,:);
% VRA2S_D(i-1,:)=abs(VRA2S(i,:)-VRA2S(1,:));
% VRA3S_D(i-1,:)=abs(VRA3S(i,:)-VRA3S(1,:));
% VRA4S_D(i-1,:)=abs(VRA4S(i,:)-VRA4S(1,:));
% VRA5S_D(i-1,:)=abs(VRA5S(i,:)-VRA5S(1,:));
% VRA6S_D(i-1,:)=abs(VRA6S(i,:)-VRA6S(1,:));
% end


% % % % % % % % % % VRAnS_D=[VRA1S_D,VRA2S_D,VRA3S_D,VRA4S_D,VRA5S_D,VRA6S_D];
% % % % % % % % % % VRAnS_D=[VRA1S_D,VRA4S_D];

% % % % % % % % % % 
% % % % % % % % % % TT=30;
% % % % % % % % % % WW=size(VRAnS_D,2);
% % % % % % % % % % TZ_Cls_one=VRAnS_D;
% % % % % % % % % % XX=size(TZ_Cls_one,1);
% % % % % % % % % % nn=(1:(XX-1)/(TT-1):XX)';
% % % % % % % % % % xx=(1:XX)';
% % % % % % % % % % for pp=1:WW
% % % % % % % % % %     %pp=3;
% % % % % % % % % % TZ_Cls_spA=spap2(XX/2,3,xx,TZ_Cls_one(:,pp));
% % % % % % % % % % TZ_Cls_D_spA = fnval(TZ_Cls_spA,nn);
% % % % % % % % % % TZ_Cls_spone(:,pp)=TZ_Cls_D_spA;
% % % % % % % % % % % scatter(nn,TZ_Cls_spone(:,2))
% % % % % % % % % % % figure,fnplt(TZ_Cls_spA,'r');
% % % % % % % % % % % hold on;
% % % % % % % % % % end
% % % % % % % % % % % 

% % % % % % % % % % 
% % % % % % % % % % TZ_Cls_spone200=reshape(TZ_Cls_spone',[1,TT*WW]);
% % % % % % % % % % 
% % % % % % % % % % Part3_VRA(jj,:)=(TZ_Cls_spone200);




% VRA1S_Mean=mean(VRA1S_D);
% VRA1S_Var=var(VRA1S_D);
% VRA2S_Mean=mean(VRA2S_D);
% VRA2S_Var=var(VRA2S_D);
% VRA3S_Mean=mean(VRA3S_D);
% VRA3S_Var=var(VRA3S_D);
% VRA4S_Mean=mean(VRA4S_D);
% VRA4S_Var=var(VRA4S_D);
% VRA5S_Mean=mean(VRA5S_D);
% VRA5S_Var=var(VRA5S_D);
% VRA6S_Mean=mean(VRA6S_D);
% VRA6S_Var=var(VRA6S_D);
% 
% 
% 
% Part3_VRA(jj,:)=[VRA1S_Mean,VRA1S_Var,VRA2S_Mean,VRA2S_Var,VRA3S_Mean,VRA3S_Var,VRA4S_Mean,VRA4S_Var,VRA5S_Mean,VRA5S_Var,VRA6S_Mean,VRA6S_Var];
% 
% 
%  clearvars -except Bag_LR kk1 Part3_VRA

  end
  
%   
%   VRA_HMM_O_all=VRA_HMM_O_all';
 
% 
% clearvars -except Bag_LR kk1 Part3_VRA

 
%  
% A=Part3_VRA;
% [AA,ps] = mapminmax(A',0,1); %%标准化
% A = AA';
% % % % labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(28,1);8*ones(30,1);9*ones(30,1);10*ones(18,1);11*ones(30,1)]; %%给样本贴上类别标签
% 
% % labels= [1*ones(27,1);2*ones(27,1);2*ones(27,1);1*ones(26,1);2*ones(26,1);2*ones(26,1);2*ones(27,1);2*ones(30,1);2*ones(30,1);1*ones(18,1);2*ones(30,1)]; %%给样本贴上类别标签
% labels= [1*ones(27,1);2*ones(27,1);3*ones(27,1);4*ones(26,1);5*ones(26,1);6*ones(26,1);7*ones(27,1);8*ones(30,1);9*ones(30,1);12*ones(18,1);17*ones(30,1)]; %%给样本贴上类别标签
% 
% 
% [M,N]=size(A);%%计算矩阵维度
% % indices = crossvalind('LeaveMOut',A(1:M,N)); 
% indices = crossvalind('Kfold',A(1:M,N),10); 
% for k=1:10    %%//交叉验证k=20，20个包轮流作为测试集
%         test = (indices == k); %%//获得test集元素在数据集中对应的单元编号
%         train = ~test;%%//train集元素的编号为非test元素的编号
%         train_A=A(train,:);%%//从数据集中划分出train样本的数据
%         train_A_labels=labels(train,:);%%//获得样本集的测试目标，在本例中是实际分类情况
%         test_A=A(test,:);%%//test样本集
%         test_A_labels=labels(test,:);
%         [bestacc,bestc,bestg] = SVMcgForClass(train_A_labels,train_A);
%         cmdo = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
%         model = svmtrain(train_A_labels,train_A,cmdo);
%         [predict_label, accuracy, decision_values] = svmpredict(test_A_labels, test_A, model);
%         K_accuracy(k)=accuracy(1);
% end
% % 显示混淆矩阵
% [C,order] = confusionmat(test_A_labels,predict_label);
% PredictAA=[test_A_labels,predict_label];
% 
%  MeanK_accuracy=mean(K_accuracy)
% 
% 
%  



% % % % % % % % % % 
% % % % % % % % % % 
% % % % % % % % % % O = 4; Q = 4; 
% % % % % % % % % % % prior0 = normalise(rand(Q,1)); 
% % % % % % % % % % % transmat0 = mk_stochastic(rand(Q,Q)); obsmat0 = mk_stochastic(rand(Q,O));
% % % % % % % % % % %Now we sample nex=20 sequences of length T=10 each from this model, to use as training data.
% % % % % % % % % % % T=29; nex=27; 
% % % % % % % % % % % data000 = dhmm_sample(prior0, transmat0, obsmat0, nex, T);
% % % % % % % % % % data = VRA_HMM_O_mat(1,1:end);
% % % % % % % % % % 
% % % % % % % % % % %Here data is 20x10. Now we make a random guess as to what the parameters are,
% % % % % % % % % % prior1 = normalise(rand(Q,1)); 
% % % % % % % % % % transmat1 = mk_stochastic(rand(Q,Q)); obsmat1 = mk_stochastic(rand(Q,O));
% % % % % % % % % % %and improve our guess using 5 iterations of EM...
% % % % % % % % % % [LL, prior2, transmat2, obsmat2] = dhmm_em(data, prior1, transmat1, obsmat1, 'max_iter', 5);
% % % % % % % % % % 
% % % % % % % % % % 
% % % % % % % % % % 
% % % % % % % % % % for zz=1:size(VRA_HMM_O_mat,1)
% % % % % % % % % %     %zz=166;
% % % % % % % % % % %loglik 即用来预测测试数据的相似程度 越大越相似 0为最大
% % % % % % % % % % loglik1(zz,:) = dhmm_logprob(VRA_HMM_O_mat(zz,1:end), prior2, transmat2, obsmat2)
% % % % % % % % % % end
% % % % % % % % % % 
% % % % % % % % % % 
% % % % % % % % % % 
% % % % % % % % % % 
% % % % % % % % % % 
% % % % % % % % % % 






















cell_data= VRA_HMM_O_all;
 O = 1;%维度
    M = 4;
    Q = 4;
    train_num = 294;
    data =[];
    % initial guess of parameters
   cov_type = 'full';
    % initial guess of parameters
    prior0 = normalise(rand(Q,1));
    transmat0 = mk_stochastic(rand(Q,Q));
    for train_len = 1 : train_num
        data = [data(:, 1 : end), cell_data{train_len}];
    end
    
    [mu0, Sigma0] = mixgauss_init(Q*M, data, cov_type);
    mu0 = reshape(mu0, [O Q M]);
    Sigma0 = reshape(Sigma0, [O O Q M]);
    mixmat0 = mk_stochastic(rand(Q,M));
    [LL, HMM.prior, HMM.transmat, HMM.mu, HMM.Sigma, HMM.mixmat] = mhmm_em(cell_data(1 : train_num), prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', 50);
 

