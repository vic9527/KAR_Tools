%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vic Woo (vic.woo@qq.com)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% ��̬�������ݸ�ʽMat(M,1+N):M������������1��Ϊ��ǩ������N����������
%%
%% ��һ�����-��ʼ   

function [ Testing_label,Testing_Label1st,Vaccuracy, S1stC_Best, predict_Label, predict_accuracy]=C1st(TrainData, TestData)

% TrainData=TR_DS(1);
% TestData=TE_DS(1);
 %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 %% step.0 ���佻����֤��          
[TrainT, TrainV]=UIVboost(TrainData{1},5,2); %UIVboost_Struct
[TrainT_label, TrainT_data,  TrainT_Label1st]=DS_Extraction(TrainT);
[TrainV_label, TrainV_data, TrainV_Label1st]=DS_Extraction(TrainV);   
TrainData_TrainingSet=P5C_Cell(TrainT_data);
TrainData_ValidationSet=P5C_Cell(TrainV_data);
            TrD_T=TrainData_TrainingSet;            
            TrL_T=TrainT_Label1st;
            TeD_V=TrainData_ValidationSet;
            TeL_V=TrainV_Label1st;
                   
          
 %% Step.1 ��̬���ݷ�������11�֣�         
 %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% �������м���
 %%  parpool 

LDA_predict={};
LDA_accuracy={};

KNN_predict={};
KNN_accuracy={};

NB_predict={};
NB_accuracy={};

C4_5_predict={};
C4_5_accuracy={};

CART_predict={};
CART_accuracy={};

SVM_predict={};
SVM_accuracy={};

RF_predict={};
RF_accuracy={};

ENS_Boosting_predict={};
ENS_Boosting_accuracy={};

ENS_Bagging_predict={};
ENS_Bagging_accuracy={};

ENS_RS_predict={};
ENS_RS_accuracy={};

BPNet_predict={};
BPNet_accuracy={};

% tic
vvv=size(TrainT,2);
parfor v=1:vvv
           %% 1.���������������discriminant analysis classifier��
           LDA_Model = ClassificationDiscriminant.fit(TrD_T{v},TrL_T{v});
           LDA_predict{v}  = predict(LDA_Model, TeD_V{v});
           LDA_accuracy{v} = length(find(LDA_predict{v} == TeL_V{v}))/length(TeL_V{v});
                           
           %% 2.K���ڷ����� ��KNN��
           KNN_Model = ClassificationKNN.fit(TrD_T{v},TrL_T{v},'NumNeighbors',1);
           KNN_predict{v}  = predict(KNN_Model, TeD_V{v});
           KNN_accuracy{v} = length(find(KNN_predict{v} == TeL_V{v}))/length(TeL_V{v});
                     
           %% 3.���ر�Ҷ˹ ��Naive Bayes��
           NB_Model = fitcnb(TrD_T{v},TrL_T{v});
           NB_predict{v} = predict(NB_Model, TeD_V{v});
           NB_accuracy{v} = length(find(NB_predict{v} == TeL_V{v}))/length(TeL_V{v});
            
          %% 4.ʹ��C4_5��������3thParty: C4_5_targets��
           C4_5_predict{v} = C4_5_targets(TrD_T{v}',TrL_T{v}', TeD_V{v}', 5, 10);%����Ϊ������������Ϊ������.
           C4_5_accuracy{v} = length(find(C4_5_predict{v}==TeL_V{v}'))/length(TeL_V{v}');
            
          %% 5.ʹ��CART������ 
           CART_Model = fitctree(TrD_T{v}, TrL_T{v});%����Ϊ������������Ϊ��������
           CART_predict{v}=predict(CART_Model,TeD_V{v});      
           CART_accuracy{v}=length(find(CART_predict{v}==TeL_V{v}))/length(TeL_V{v});
           
          %% 6.ʹ��SVM��������3thParty: LibSVM��%�����һ��%
           [AA,ps] = mapminmax(TrD_T{v}',0,1); %ѵ������׼��
           train_AA = AA';
           test_AA = (mapminmax('apply', TeD_V{v}', ps))'; %���Լ�����ѵ������ͬ�����׼��
           TR_Std=train_AA;
           TE_Std=test_AA;          
           [bestacc,bestc,bestg] = SVMcgForClass(TrL_T{v},TR_Std);
           SVM_cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
           SVM_Model = svmtrain(TrL_T{v},TR_Std,SVM_cmdo);
           [SVM_predict{v}, accuracy, decision_values] = svmpredict(TeL_V{v}, TE_Std, SVM_Model);
           SVM_accuracy{v}=length(find(SVM_predict{v}==TeL_V{v}))/length(TeL_V{v});
                                    
           %% 7.���ɭ�ַ�������Random Forest��
           RF_nTree=500;
           RF_Model = TreeBagger(RF_nTree,TrD_T{v}, TrL_T{v});
           RF_predict{v} = str2num(char(predict(RF_Model,TeD_V{v})));
           RF_accuracy{v}=length(find(RF_predict{v}==TeL_V{v}))/length(TeL_V{v});

          %% 8.Boosting����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
           ENS_Boosting_Model = fitensemble(TrD_T{v},TrL_T{v},'AdaBoostM2' ,100,'Tree','type','classification');
           ENS_Boosting_predict{v}  = predict(ENS_Boosting_Model, TeD_V{v});
           ENS_Boosting_accuracy{v}=length(find(ENS_Boosting_predict{v}==TeL_V{v}))/length(TeL_V{v});
           
           %% 9.Bagging����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
           ENS_Bagging_Model = fitensemble(TrD_T{v},TrL_T{v},'Bag' ,100,'Tree','type','classification');
           ENS_Bagging_predict{v}  = predict(ENS_Bagging_Model, TeD_V{v});
           ENS_Bagging_accuracy{v}=length(find(ENS_Bagging_predict{v}==TeL_V{v}))/length(TeL_V{v});
            
           %% 10.Random Subspace����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
           ENS_RS_Model = fitensemble(TrD_T{v},TrL_T{v},'Subspace',100,'KNN','type','classification');
           ENS_RS_predict{v}  = predict(ENS_RS_Model, TeD_V{v});
           ENS_RS_accuracy{v}=length(find(ENS_RS_predict{v}==TeL_V{v}))/length(TeL_V{v});  

           %% 11.�������������BP�����磩
            BPNet_predict{v}=bpnet(TrD_T{v},TrL_T{v},TeD_V{v},TeL_V{v},7,1000);%��һ��7����
            BPNet_accuracy{v}=length(find(BPNet_predict{v}==TeL_V{v}))/length(TeL_V{v});
   end          
%  toc               
%% �رղ��м���
%% delete(gcp('nocreate'))

%% �����˳����������ȼ���
Vaccuracy=cell2mat([LDA_accuracy; KNN_accuracy; NB_accuracy; C4_5_accuracy; CART_accuracy; SVM_accuracy; RF_accuracy; ENS_Boosting_accuracy; ENS_Bagging_accuracy; ENS_RS_accuracy; BPNet_accuracy]);


 %% Step.2 ѡ�����ž�̬���ݷ�����        
 %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
          Cnum=11;%����������
          Vaccuracy(:,vvv+2)=mean(Vaccuracy(1:Cnum,1:vvv),2); %�������ֵ�ڵ�12����ʾ
          
          [C,I]=max(Vaccuracy);
          Vaccuracy(Cnum+2,:)=C;%���������ֵ�ڵ�13����ʾ
          % Vaccuracy(Cnum+3,:)=I;%���������ֵ�ı���ڵ�14����ʾ(����ȷ��)
          
          %% ���������ֵ�ı�ţ��ж���Ŀ��ܣ�
          Cindex=[];
          for vv=1:vvv
          Cindexii=find(Vaccuracy(1:Cnum,vv)==C(vv));
          Cindex=[Cindex; Cindexii];
          %CindexBag{vv}=Cindexii;
          end
          
          Cvote=tabulate(Cindex);
          [MaxCvote,S1stC]= max(Cvote(:,3));     %Select the first level classifier.
          
          CvoteMax_ID=find(Cvote(:,3)==MaxCvote);%�������ֵ����һ��
          
          if length(CvoteMax_ID)~=1
              CvoteMeanMax=[CvoteMax_ID,Vaccuracy(CvoteMax_ID,vvv+2)];
              [MaxCvote_value,S1stC_index]=max(CvoteMeanMax(:,2));
              S1stC=CvoteMeanMax(S1stC_index,1);
          end
              S1stC_Best=S1stC;

              
          % clearvars Vaccuracy

          
          
          
 %% Step.3 �������ŷ�����        
 %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[TR_label, TR_data,  TR_Label1st]=DS_Extraction(TrainData);   
[TE_label, TE_data,  TE_Label1st]=DS_Extraction(TestData);       
TR_FV1st=P5C_Cell(TR_data);
TE_FV1st=P5C_Cell(TE_data);
 TrL=TR_Label1st{1};                 
 TrD=TR_FV1st{1}; 
 TeL=TE_Label1st{1};                 
 TeD=TE_FV1st{1};      
 Testing_label=TE_label{1};
 Testing_Label1st=TE_Label1st{1};
             
            switch  S1stC_Best
              
                  case 1
                %% 1.���������������discriminant analysis classifier��
                   LDA_Model = ClassificationDiscriminant.fit(TrD,TrL);
                   LDA_predict  = predict(LDA_Model, TeD);
                   LDA_accuracy = length(find(LDA_predict == TeL))/length(TeL)
                   S1stC_Best_accuracy=LDA_accuracy;
                   S1stC_Best_predict=LDA_predict;
                   
                   case 2
                 %% 2.K���ڷ����� ��KNN��
                   KNN_Model = ClassificationKNN.fit(TrD,TrL,'NumNeighbors',1);
                   KNN_predict  = predict(KNN_Model, TeD);
                   KNN_accuracy = length(find(KNN_predict == TeL))/length(TeL)
                   S1stC_Best_accuracy=KNN_accuracy;
                   S1stC_Best_predict=KNN_predict;
           
                   case 3
                 %% 3.���ر�Ҷ˹ ��Naive Bayes��
                   NB_Model = fitcnb(TrD,TrL);
                   NB_predict = predict(NB_Model, TeD);
                   NB_accuracy = length(find(NB_predict == TeL))/length(TeL)
                   S1stC_Best_accuracy=NB_accuracy;
                   S1stC_Best_predict=NB_predict;
                   
                   case 4
                 %% 4.ʹ��C4_5������ 
                   C4_5_predict= C4_5_targets(TrD',TrL', TeD', 5, 10);%����Ϊ������������Ϊ������.
                   C4_5_accuracy = length(find(C4_5_predict==TeL'))/length(TeL')
                   S1stC_Best_accuracy=C4_5_accuracy;
                   S1stC_Best_predict=C4_5_predict;

                  case 5
                 %% 5.ʹ��CART������ 
                   CART_Model = fitctree(TrD, TrL);%����Ϊ������������Ϊ��������
                   CART_predict=predict(CART_Model,TeD);      
                   CART_accuracy=length(find(CART_predict==TeL))/length(TeL)
                   S1stC_Best_accuracy=CART_accuracy;
                   S1stC_Best_predict=CART_predict;
                   
                  case 6                    
                %% 6.ʹ��SVM������
                   [AA,ps] = mapminmax(TrD',0,1); %ѵ������׼��
                   train_AA = AA';
                   test_AA = (mapminmax('apply', TeD', ps))'; %���Լ�����ѵ������ͬ�����׼��
                   TR_Std=train_AA;
                   TE_Std=test_AA;          
                   [bestacc,bestc,bestg] = SVMcgForClass(TrL,TR_Std);
                   SVM_cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
                   SVM_Model = svmtrain(TrL,TR_Std,SVM_cmdo);
                   [SVM_predict, accuracy, decision_values] = svmpredict(TeL, TE_Std, SVM_Model);
                   SVM_accuracy=length(find(SVM_predict==TeL))/length(TeL)
                   S1stC_Best_accuracy=SVM_accuracy;
                   S1stC_Best_predict=SVM_predict;

                  case 7
                 %% 7.���ɭ�ַ�������Random Forest��
                   RF_nTree=500;
                   RF_Model = TreeBagger(RF_nTree,TrD, TrL);
                   RF_predict= str2num(char(predict(RF_Model,TeD)));
                   RF_accuracy=length(find(RF_predict==TeL))/length(TeL)
                   S1stC_Best_accuracy=RF_accuracy;
                   S1stC_Best_predict=RF_predict;
                   
                  case 8                   
                 %% 8.Boosting����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
                   ENS_Boosting_Model = fitensemble(TrD,TrL,'AdaBoostM2' ,100,'Tree','type','classification');
                   ENS_Boosting_predict = predict(ENS_Boosting_Model, TeD);
                   ENS_Boosting_accuracy=length(find(ENS_Boosting_predict==TeL))/length(TeL)
                   S1stC_Best_accuracy=ENS_Boosting_accuracy;
                   S1stC_Best_predict=ENS_Boosting_predict;
                    
                  case 9
                %% 9.Bagging����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
                   ENS_Bagging_Model = fitensemble(TrD,TrL,'Bag' ,100,'Tree','type','classification');
                   ENS_Bagging_predict  = predict(ENS_Bagging_Model, TeD);
                   ENS_Bagging_accuracy=length(find(ENS_Bagging_predict==TeL))/length(TeL)
                   S1stC_Best_accuracy=ENS_Bagging_accuracy;
                   S1stC_Best_predict=ENS_Bagging_predict;
         
                  case 10
                %% 10.Random Subspace����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
                   ENS_RS_Model = fitensemble(TrD,TrL,'Subspace',100,'KNN','type','classification');
                   ENS_RS_predict  = predict(ENS_RS_Model, TeD);
                   ENS_RS_accuracy=length(find(ENS_RS_predict==TeL))/length(TeL)  
                   S1stC_Best_accuracy=ENS_RS_accuracy;
                   S1stC_Best_predict=ENS_RS_predict;
           
                  case 11
               %% 11.�������������BP�����磩
                   BPNet_predict=bpnet(TrD,TrL,TeD,TeL,7,1000);%��һ��7����
                   BPNet_accuracy=length(find(BPNet_predict==TeL))/length(TeL)
                   S1stC_Best_accuracy=BPNet_accuracy;
                   S1stC_Best_predict=BPNet_predict;
           
                otherwise 
                      
                     fprintf('Error!  =_=͹  \n' );
                                           
            end       
        
           
            predict_Label=S1stC_Best_predict;
            predict_accuracy=S1stC_Best_accuracy;
            





 %% ��һ�����-����     
 
             end