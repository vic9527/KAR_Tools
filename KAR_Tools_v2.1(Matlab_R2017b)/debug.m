
clearvars -except TR_FV2nd_Struct TE_FV2nd_Struct TR_Label1st C1st_predict_Label

Ckind=101; %% 第一层分类下的第几大类编号。
TR_C2nd_C1={};
TE_C2nd_C1={};
C1_C2nd_Vaccuracy={};
C1_S2ndC_Best={};
C1_C2nd_predict_Label={};
C1_C2nd_predict_accuracy={};
for k=1:size(TR_Label1st,2)
    TR_C2nd_C1{k}=TR_FV2nd_Struct{k}(TR_Label1st{k}==Ckind);
    TE_C2nd_C1{k}=TE_FV2nd_Struct{k}(C1st_predict_Label{k}==Ckind);
end

switch Ckind
    
    case 101
        FVrange=[13:18];
    case 102
        FVrange=[7:18];   
    case 103
        FVrange=[25:30];       
    otherwise
        fprintf('Error!  =_=凸  \n' );
end 


 for kkk=1:252
     
     kkk
     kkk
     kkk
     kkk
     kkk
     kkk
     kkk
     kkk
     kkk
     kkk
             
  TrainData=TR_C2nd_C1{kkk};      
    
%% Step.1 动态数据分类器（2种）         
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A=[1:size(TrainData,1)]';
%[M,N]=size(A);%计算矩阵维度
%indices = crossvalind('Kfold',A(1:M,N),kk);     



label_Min=0;
label_Min_Num=0;
while label_Min<36
    
    kk=10;%设置几折
    indices_num=0;
    %indices_num_k=0;
    while indices_num~=kk %% 必须每折都有值
        indices = crossvalind('Kfold',1:size(TrainData,1),kk); 
        indices_num=numel(unique( indices));
       % indices_num_k=indices_num_k+1;
    end


    TE_DS={};
    TR_DS={};
            for k=1:kk    %交叉验证k=10，10个包轮流作为测试集
                test = (indices == k); 
                test_ID=find(test==1);
                train_ID=find(test==0);
                TE_DS{k}= TrainData(test_ID);%分配测试集
                TR_DS{k}= TrainData(train_ID);%分配训练集
            end
    clearvars  indices k test test_ID train_ID jj
    
   for k=1:kk 
    labelAA= cat(1,TR_DS{k}.label); %按列读取label值
    labelAA_Count= tabulate(labelAA);
    T=labelAA_Count(:,3);
    T(~T)=inf;
    [Min_label, Pos_label]=min(T);
    TR_DS_Cell=struct2cell(TR_DS{k});
    TR_DS_Cell= TR_DS_Cell';
    TR_DS_Cell_Min= TR_DS_Cell(find(cell2mat(TR_DS_Cell(:,2))== Pos_label),:);
    mink_num=0;     
    for mink=1:size(TR_DS_Cell_Min,1)
     mink_num=mink_num+ size(TR_DS_Cell_Min{mink},2);
    end
   labelAA_Min(k)=mink_num;
   end
   
   label_Min=min(labelAA_Min);
   
    label_Min_Num=label_Min_Num+1;
   
end
   
    if label_Min_Num>1
         fprintf('label_Min_Num: %d\n label_Min:%d\n',  label_Min_Num,label_Min);
    end
    
    clearvars labelAA 



  %% 使用HMM进行分类
 HMM_predict={};
 predict_label={};
 accuracy={};
 true_label={};
 HMM_accuracy=[];
 HMM_Models={};
for k=1:kk
  %%  k=10
%   param.O = 6;  % dimensionality of feature vector of each frame in an action sequence
%   param.Q = 6;   % number of states (default)
%   param.M = 6;    % number of mixtures
%   param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
%   param.max_iter = 10;    % number of iterations
%   param.verbose = 1;
 % Training
%  fprintf('HMM training.\n');
%  param.Q = 9;   % number of states
 HMM_Models{k} = hmmTrain(TR_DS{k}, FVrange);%tt
 % Testing
%  fprintf('HMM testing.\n');
 % prescale test data
 [accuracy{k}, predict_label{k}, true_label{k}] = hmmTest(TE_DS{k}, HMM_Models{k},FVrange);%tt
 HMM_predict{k}=predict_label{k};
 HMM_accuracy(k)=length(find(HMM_predict{k}==true_label{k}))/length(true_label{k});
end
 fprintf('HMM_accuracy: %.4f\n',  HMM_accuracy);
 
 clearvars accuracy HMM_Models HMM_predict predict_label true_label
 
 TrainData=struct;
 
end