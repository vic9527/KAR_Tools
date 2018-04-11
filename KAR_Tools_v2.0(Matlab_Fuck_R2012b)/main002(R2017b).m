%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vic Woo (vic.woo@qq.com)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Step.0 -- Preparing for running
%% clear variables
clear all; close all; clc;
warning off 
tic            
%% add to path
this_dir = pwd;
addpath(genpath(this_dir));
verbose = 1;  
All_data_dir = ['MSRAction3DSkeletonReal3D_547\'];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.1.0 -- Load all data
fprintf('Loading all data:\n');
All_Actions = loadData(All_data_dir,verbose);
fprintf('All data have been loaded.\n\n')
clearvars Kaccuracy predictAA verbose All_data_dir

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.2.0 -- Set the first level label
 for jj=1:size(All_Actions,2)
            All_Actions(jj).Label1st=All_Actions(jj).label;
            All_Actions(jj).Label1st(All_Actions(jj).Label1st==1|All_Actions(jj).Label1st==2|All_Actions(jj).Label1st==3|All_Actions(jj).Label1st==4|All_Actions(jj).Label1st==5|All_Actions(jj).Label1st==6|All_Actions(jj).Label1st==7|All_Actions(jj).Label1st==8|All_Actions(jj).Label1st==9|All_Actions(jj).Label1st==17|All_Actions(jj).Label1st==12)=101;
            All_Actions(jj).Label1st(All_Actions(jj).Label1st==10|All_Actions(jj).Label1st==11|All_Actions(jj).Label1st==18)=102;
            All_Actions(jj).Label1st(All_Actions(jj).Label1st==14|All_Actions(jj).Label1st==15)=103;      
 end  
       %%  special case:
            All_Actions(313).Label1st=102;  
             All_Actions(314).Label1st=102;  
              All_Actions(315).Label1st=102;  
               All_Actions(322).Label1st=102;  
                All_Actions(323).Label1st=102;  
                 All_Actions(324).Label1st=102;  
                  All_Actions(328).Label1st=102;  
                   All_Actions(329).Label1st=102;  
                    All_Actions(330).Label1st=102;  
                     All_Actions(334).Label1st=102;  
                      All_Actions(335).Label1st=102;  
                       All_Actions(336).Label1st=102;  
                       
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.3.0 -- Ten times ten fold cross validation                     
TT=1;%���ü���
for T=1:TT
%T

kk=5;%���ü���
A=[1:size(All_Actions,2)]';
[M,N]=size(A);%�������ά��
indices = crossvalind('Kfold',A(1:M,N),kk); 
clearvars -except All_Actions indices kk T TT TTCaccuracy TTCbag TTCPRPbag
        for k=1:kk    %������֤k=10��10����������Ϊ���Լ�
            test = (indices == k); %���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
            test_ID=find(test==1);
            train_ID=find(test==0);
            TE_Actions= All_Actions(test_ID);%������Լ�
            TR_Actions= All_Actions(train_ID);%����ѵ����
            
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

          
          
 %% ��һ�����-��ʼ   
 
          vv=5;%���ü���
          A=[1:size(TR_Actions,2)]';
          [M,N]=size(A);%�������ά��
          vvindices = crossvalind('Kfold',A(1:M,N),vv); 
%           clearvars -except All_Actions indices kk k T TT Cbag CaccuracyBag CPRPbag MeanCaccuracy Finaccuracy StdFA TTCaccuracy TTCbag TTCPRPbag TR_Actions vv vvindices TE_Actions
          for v=1:vv    %������֤k=10��10����������Ϊ���Լ�
              validation = (vvindices == v); %���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
              train_v_ID=find(validation==1);
              train_t_ID=find(validation==0);
              TR_V_Actions= TR_Actions(train_v_ID);%������֤��
              TR_T_Actions= TR_Actions(train_t_ID);%����ѵ����
              
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Step.3.1 --1st Level
             for jj=1:size(TR_T_Actions,2)
               %% ��ȡ��ֵ�ͷ���-��ʼ
                 TP_Mean(jj,:)=mean([TR_T_Actions(jj).Feature1st(:,2:end)]');
                 TP_Var(jj,:)=var([TR_T_Actions(jj).Feature1st(:,2:end)]'); 
             end
                 TR_TP=[TP_Mean,TP_Var];     
                 clearvars TP_Mean TP_Var

             for jj=1:size(TR_V_Actions,2)
                 TP_Mean(jj,:)=  mean([TR_V_Actions(jj).Feature1st(:,2:end)]');
                 TP_Var(jj,:)=  var([TR_V_Actions(jj).Feature1st(:,2:end)]'); 
             end   
                 TE_TP=[TP_Mean,TP_Var];     
                 clearvars TP_Mean TP_Var
             %% ��ȡ��ֵ�ͷ���-����
             
             
             
%             [AA,ps] = mapminmax(TR_TP',0,1); %%ѵ������׼��
%             train_AA = AA';
%             test_AA = (mapminmax('apply', TE_TP', ps))'; %%���Լ���׼��
%             clearvars TR_TP TE_TP
%             TR_TP=train_AA;
%             TE_TP=test_AA;
            
%             TR_LL=[TR_T_Actions.Label1st]';
%             TE_LL=[TR_V_Actions.Label1st]';
%             % clearvars -except TR_TP TE_TP TR_LL TE_LL
%             % save BP.mat
            
            T
            k
            v
            
           %% 1.���������������discriminant analysis classifier��
           LDA_training = ClassificationDiscriminant.fit(TR_TP,[TR_T_Actions.Label1st]');
           LDA_predict  = predict(LDA_training, TE_TP);
           LDA_accuracyC=[LDA_predict,[TR_V_Actions.Label1st]'];
           LDA_accuracy = length(find(LDA_predict == [TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
           Vaccuracy(1,v)=LDA_accuracy(1);           
            
           %% 2.K���ڷ����� ��KNN��
           KNN_training = ClassificationKNN.fit(TR_TP,[TR_T_Actions.Label1st]','NumNeighbors',1);
           KNN_predict  = predict(KNN_training, TE_TP);
           KNN_accuracyC=[KNN_predict,[TR_V_Actions.Label1st]'];
           KNN_accuracy = length(find(KNN_predict == [TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
           Vaccuracy(2,v)=KNN_accuracy(1);
                     
           %% 3.���ر�Ҷ˹ ��Naive Bayes��
           % NB = NaiveBayes.fit(TR_TP, [TR_T_Actions.Label1st]');
           NB = fitcnb(TR_TP, [TR_T_Actions.Label1st]');
           NB_predict =    predict(NB, TE_TP);
           NB_accuracyC=[NB_predict,[TR_V_Actions.Label1st]'];
           NB_accuracy =   length(find(NB_predict == [TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
           Vaccuracy(3,v)=NB_accuracy(1);
            
          %% 4.ʹ��C4_5��������3thParty: C4_5_targets��
           C4_5_predict = C4_5_targets(TR_TP', [TR_T_Actions.Label1st], TE_TP', 5, 10);%%%%%%����Ϊ������������Ϊ��������y������Ϊ��������1�б����ࣻ
           C4_5_accuracyC=[C4_5_predict;TR_V_Actions.Label1st]';%ת�ú�2��չʾ
           C4_5_accuracy=length(find(C4_5_predict==[TR_V_Actions.Label1st]))/length([TR_V_Actions.Label1st])*100
           Vaccuracy(4,v)=C4_5_accuracy(1);
            
          %% 5.ʹ��CART������ 
           % CART_training = classregtree(TR_TP, [TR_T_Actions.Label1st]');%����Ϊ������������Ϊ��������y������Ϊ��������1�б����ࣻ
           % CART_predict= eval(CART_training,TE_TP);
           CART_training = fitctree(TR_TP, [TR_T_Actions.Label1st]');%����Ϊ������������Ϊ��������y������Ϊ��������1�б����ࣻ
           CART_predict=predict(CART_training,TE_TP); %CART_predict= CART_training.predict(TE_TP);        
           CART_accuracyC=[CART_predict,[TR_V_Actions.Label1st]'];
           CART_accuracy=length(find(CART_predict==[TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
           Vaccuracy(5,v)=CART_accuracy(1);
           
            %% 6.ʹ��SVM��������3thParty: LibSVM��%�����һ��%
            [AA,ps] = mapminmax(TR_TP',0,1); %%ѵ������׼��
            train_AA = AA';
            test_AA = (mapminmax('apply', TE_TP', ps))'; %%���Լ���׼��
            TR_TP_Std=train_AA;
            TE_TP_Std=test_AA;
            
            [bestacc,bestc,bestg] = SVMcgForClass([TR_T_Actions.Label1st]',TR_TP_Std);
            SVM_cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
            SVM_model = svmtrain([TR_T_Actions.Label1st]',TR_TP_Std,SVM_cmdo);
            [SVM_predict, accuracy, decision_values] = svmpredict([TR_V_Actions.Label1st]', TE_TP_Std, SVM_model);
            SVM_accuracyC=[SVM_predict,[TR_V_Actions.Label1st]'];
            SVM_accuracy=length(find(SVM_predict==[TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
            Vaccuracy(6,v)=SVM_accuracy(1);
                        
            
%% ʹ��Matlab2015�Դ�SVM������-��ʼ
% %            SVM = fitcecoc(TR_TP, [TR_T_Actions.Label1st]');
% %            SVM_predict =    predict(SVM, TE_TP);
% %            SVM_accuracyC=[SVM_predict,[TR_V_Actions.Label1st]'];
% %            SVM_accuracy =   length(find(SVM_predict == [TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
% %  
% %            SVM = fitcecoc(train_AA, train_AA_labels);
% %            SVM_predict =    predict(SVM, test_AA);
% %            SVM_accuracyC=[SVM_predict,test_AA_labels];
% %            SVM_accuracy =   length(find(SVM_predict ==test_AA_labels))/length(test_AA_labels)*100
%% ʹ��Matlab2015�Դ�SVM������-����
            
           %% 7.���ɭ�ַ�������Random Forest��
           RF_nTree=500;
           RF_training = TreeBagger(RF_nTree,TR_TP, [TR_T_Actions.Label1st]');
           RF_predict = predict(RF_training,TE_TP);
           RF_predict = str2num(char(RF_predict));  
           RF_accuracyC=[RF_predict,[TR_V_Actions.Label1st]'];
           RF_accuracy=length(find(RF_predict==[TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
           Vaccuracy(7,v)=RF_accuracy(1);
            
          %% 8.Boosting����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
           ENS_Boosting_training = fitensemble(TR_TP,[TR_T_Actions.Label1st]','AdaBoostM2' ,100,'Tree','type','classification');
           ENS_Boosting_predict  = predict(ENS_Boosting_training, TE_TP);
           ENS_Boosting_accuracyC=[ENS_Boosting_predict,[TR_V_Actions.Label1st]'];
           ENS_Boosting_accuracy=length(find(ENS_Boosting_predict==[TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
           Vaccuracy(8,v)=ENS_Boosting_accuracy(1);
           
           %% 9.Bagging����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
           ENS_Bagging_training = fitensemble(TR_TP,[TR_T_Actions.Label1st]','Bag' ,100,'Tree','type','classification');
           ENS_Bagging_predict  = predict(ENS_Bagging_training, TE_TP);
           ENS_Bagging_accuracyC=[ENS_Bagging_predict,[TR_V_Actions.Label1st]'];
           ENS_Bagging_accuracy=length(find(ENS_Bagging_predict==[TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
           Vaccuracy(9,v)=ENS_Bagging_accuracy(1);
            
           %% 10.Random Subspace����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
           ENS_RS_training = fitensemble(TR_TP,[TR_T_Actions.Label1st]','Subspace',100,'KNN','type','classification');
           ENS_RS_predict  = predict(ENS_RS_training, TE_TP);
           ENS_RS_accuracyC=[ENS_RS_predict,[TR_V_Actions.Label1st]'];
           ENS_RS_accuracy=length(find(ENS_RS_predict==[TR_V_Actions.Label1st]'))/length([TR_V_Actions.Label1st]')*100
           Vaccuracy(10,v)=ENS_RS_accuracy(1);     
           
           %% 11.�������������BP�����磩
            TR_LL=[TR_T_Actions.Label1st]';
            TE_LL=[TR_V_Actions.Label1st]';
           %����ֵ��һ��
            [input,minI,maxI] = premnmx(TR_TP');
            %һ�������в���ͬ��������������Ұ���ԭ����˳�����
            [c,i]=unique(TR_LL,'first');
            j=sort(i);
            u=TR_LL(j);
            n = numel(u);
            TR_LL_Trans=TR_LL;
            for Trans_cc=1:n
                    TR_LL_Trans(find(TR_LL_Trans==u(Trans_cc)))=Trans_cc;
            end
            %�����������
            s = length(TR_LL) ;
            output = zeros( s , n) ;
            for i = 1 : s 
               output( i , TR_LL_Trans( i )  ) = 1 ;
            end
            %һ�������в���ͬ��������������Ұ���ԭ����˳�����
            [c,i]=unique(TE_LL,'first');
            j=sort(i);
            u=TE_LL(j);
            n = numel(u);
            TE_LL_Trans=TE_LL;
            for Trans_cc=1:n
                    TE_LL_Trans(find(TE_LL_Trans==u(Trans_cc)))=Trans_cc;
            end
            %�������ݹ�һ��
            testInput = tramnmx( TE_TP' , minI, maxI ) ;
            %����������
            net = newff( minmax(input) , [30 7] , { 'logsig' 'purelin' 'tansig' } , 'traingdx' ) ; 
            %����ѵ������
            net.trainparam.show = 100 ;
            net.trainparam.epochs = 1000;
            net.trainparam.goal = 0.01 ;
            net.trainParam.lr = 0.01 ;
            %% ������ʾ����
            net.trainParam.showWindow=false;
            %��ʼѵ��
            net = train( net, input , output' ) ;
            %����
            net_Y = sim( net , testInput );
            %ͳ��ʶ����ȷ��
            [net_Max , net_Index] = max( net_Y);
            %ת����ԭ��ǩ
            [c,i]=unique(TE_LL,'first');
            j=sort(i);
            u=TE_LL(j);
            n = numel(u);
            for Trans_cc=1:n
                    net_Index(find(net_Index==Trans_cc))=u(Trans_cc);
            end
            BPNet_predict=net_Index';
            BPNet_accuracyC=[BPNet_predict,TE_LL];
            BPNet_accuracy=length(find(BPNet_predict==TE_LL))/length(TE_LL)*100
            Vaccuracy(11,v)=BPNet_accuracy(1);  
           
           
           
           
            clearvars TR_TP TE_TP
            %CPRP=[test_Real_labels,PredictAA,predict_Label1st];%���˵���CPRP����˼��������ô�á�        
          end
          
          
          Cnum=11;%����������
          Vaccuracy(:,v+2)=mean(Vaccuracy(1:Cnum,1:v),2);
          [C,I]=max(Vaccuracy)
          Vaccuracy(Cnum+2,:)=C;
          Vaccuracy(Cnum+3,:)=I;
          Cvote=tabulate(Vaccuracy(Cnum+3,1:v));
          [MaxCvote,S1stC]= max(Cvote(:,3));     %Select the first level classifier.
          
          CvoteMax_ID=find(Cvote(:,3)==MaxCvote);
          if length(CvoteMax_ID)~=1
              CvoteMeanMax=[CvoteMax_ID,Vaccuracy(CvoteMax_ID,v+2)];
              [MaxCvote_value,S1stC_index]=max(CvoteMeanMax(:,2));
              S1stC=CvoteMeanMax(S1stC_index,1);
          end
              S1stC_Mat(k)=S1stC;
              VaccuracyBag{k}=Vaccuracy;
              
          clearvars Vaccuracy
          
             %% ��ȡ��ֵ�ͷ���-��ʼ          
           for jj=1:size(TR_Actions,2)

                 TP_Mean(jj,:)=mean([TR_Actions(jj).Feature1st(:,2:end)]');
                 TP_Var(jj,:)=var([TR_Actions(jj).Feature1st(:,2:end)]'); 
            end
                 TR_TP=[TP_Mean,TP_Var];     
                 clearvars TP_Mean TP_Var

            for jj=1:size(TE_Actions,2)
                 TP_Mean(jj,:)=  mean([TE_Actions(jj).Feature1st(:,2:end)]');
                 TP_Var(jj,:)=  var([TE_Actions(jj).Feature1st(:,2:end)]'); 
            end   
                 TE_TP=[TP_Mean,TP_Var];     
                 clearvars TP_Mean TP_Var
             %% ��ȡ��ֵ�ͷ���-����
             
             
             
          switch  S1stC
              
                  case 1
                %% 1.���������������discriminant analysis classifier��
                   LDA_training = ClassificationDiscriminant.fit(TR_TP,[TR_Actions.Label1st]');
                   LDA_predict  = predict(LDA_training, TE_TP);
                   LDA_accuracyC=[LDA_predict,[TE_Actions.Label1st]'];
                   LDA_accuracy = length(find(LDA_predict == [TE_Actions.Label1st]'))/length([TE_Actions.Label1st]')*100
                   S1stC_accuracy=LDA_accuracy(1);
                   S1stC_predict=LDA_predict;
                   
                   case 2
                 %% 2.K���ڷ����� ��KNN��
                   KNN_training = ClassificationKNN.fit(TR_TP,[TR_Actions.Label1st]','NumNeighbors',1);
                   KNN_predict  = predict(KNN_training, TE_TP);
                   KNN_accuracyC=[KNN_predict,[TE_Actions.Label1st]'];
                   KNN_accuracy = length(find(KNN_predict == [TE_Actions.Label1st]'))/length([TE_Actions.Label1st]')*100
                   S1stC_accuracy=KNN_accuracy(1);
                   S1stC_predict=KNN_predict;   
                   
                   case 3
                 %% 3.���ر�Ҷ˹ ��Naive Bayes��
                   % NB = NaiveBayes.fit(TR_TP, [TR_Actions.Label1st]');
                   NB = fitcnb(TR_TP, [TR_Actions.Label1st]');
                   NB_predict =    predict(NB, TE_TP);
                   NB_accuracyC=[NB_predict,[TE_Actions.Label1st]'];
                   NB_accuracy =   length(find(NB_predict == [TE_Actions.Label1st]'))/length([TE_Actions.Label1st]')*100
                   S1stC_accuracy=NB_accuracy(1);
                   S1stC_predict=NB_predict;   
                       
                   case 4
                 %% 4.ʹ��C4_5������ 
                   C4_5_predict = C4_5_targets(TR_TP', [TR_Actions.Label1st], TE_TP', 5, 10);%%%%%%����Ϊ������������Ϊ��������y������Ϊ��������1�б����ࣻ
                   C4_5_accuracyC=[C4_5_predict;TE_Actions.Label1st]';%ת�ú�2��չʾ
                   C4_5_accuracy=length(find(C4_5_predict==[TE_Actions.Label1st]))/length([TE_Actions.Label1st])*100
                   S1stC_accuracy=C4_5_accuracy(1);
                   S1stC_predict=C4_5_predict;
           
                  case 5
                 %% 5.ʹ��CART������ 
                   % CART_training = classregtree(TR_TP, [TR_Actions.Label1st]');%����Ϊ������������Ϊ��������y������Ϊ��������1�б����ࣻ
                   % CART_predict= eval(CART_training,TE_TP);
                   CART_training = fitctree(TR_TP, [TR_Actions.Label1st]');%����Ϊ������������Ϊ��������y������Ϊ��������1�б����ࣻ   
                   CART_predict= CART_training.predict(TE_TP); 
                   CART_accuracyC=[CART_predict,[TE_Actions.Label1st]'];
                   CART_accuracy=length(find(CART_predict==[TE_Actions.Label1st]'))/length([TE_Actions.Label1st]')*100
                   S1stC_accuracy=CART_accuracy(1);
                   S1stC_predict=CART_predict;

                  case 6
                      
                %% 6.ʹ��SVM������
                    [AA,ps] = mapminmax(TR_TP',0,1); %%ѵ������׼��
                    train_AA = AA';
                    train_AA_labels=[TR_Actions.Label1st]';
                    test_AA = (mapminmax('apply', TE_TP', ps))'; %%���Լ���׼��
                    test_AA_labels=[TE_Actions.Label1st]';  
                    test_Real_labels=[TE_Actions.label]';  
                    [bestacc,bestc,bestg] = SVMcgForClass(train_AA_labels,train_AA);
                    cmdo = [ '-c ',num2str(bestc),' -g ',num2str(bestg)];
                    model = svmtrain(train_AA_labels,train_AA,cmdo);
                    [SVM_predict, accuracy, decision_values] = svmpredict(test_AA_labels, test_AA, model);
                    PredictAA=[test_AA_labels,SVM_predict];
                    S1stC_accuracy=accuracy(1);
                    S1stC_predict=SVM_predict;

                  case 7
                 %% 7.���ɭ�ַ�������Random Forest��
                   RF_nTree=500;
                   RF_training = TreeBagger(RF_nTree,TR_TP, [TR_Actions.Label1st]');
                   RF_predict = predict(RF_training,TE_TP);
                   RF_predict = str2num(char(RF_predict));  
                   RF_accuracyC=[RF_predict,[TE_Actions.Label1st]'];
                   RF_accuracy=length(find(RF_predict==[TE_Actions.Label1st]'))/length([TE_Actions.Label1st]')*100
                   S1stC_accuracy=RF_accuracy(1);
                   S1stC_predict=RF_predict;
           
                  case 8                   
                 %% 8.Boosting����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
                   ENS_Boosting_training = fitensemble(TR_TP,[TR_Actions.Label1st]','AdaBoostM2' ,100,'Tree','type','classification');
                   ENS_Boosting_predict  = predict(ENS_Boosting_training, TE_TP);
                   ENS_Boosting_accuracyC=[ENS_Boosting_predict,[TE_Actions.Label1st]'];
                   ENS_Boosting_accuracy=length(find(ENS_Boosting_predict==[TE_Actions.Label1st]'))/length([TE_Actions.Label1st]')*100
                   S1stC_accuracy=ENS_Boosting_accuracy(1);
                   S1stC_predict=ENS_Boosting_predict;

                  case 9
                %% 9.Bagging����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
                   ENS_Bagging_training = fitensemble(TR_TP,[TR_Actions.Label1st]','Bag' ,100,'Tree','type','classification');
                   ENS_Bagging_predict  = predict(ENS_Bagging_training, TE_TP);
                   ENS_Bagging_accuracyC=[ENS_Bagging_predict,[TE_Actions.Label1st]'];
                   ENS_Bagging_accuracy=length(find(ENS_Bagging_predict==[TE_Actions.Label1st]'))/length([TE_Actions.Label1st]')*100
                   S1stC_accuracy=ENS_Bagging_accuracy(1);
                   S1stC_predict=ENS_Bagging_predict;
         
                  case 10
                %% 10.Random Subspace����ѧϰ������Ensembles for Boosting, Bagging, or Random Subspace��
                   ENS_RS_training = fitensemble(TR_TP,[TR_Actions.Label1st]','Subspace',100,'KNN','type','classification');
                   ENS_RS_predict  = predict(ENS_RS_training, TE_TP);
                   ENS_RS_accuracyC=[ENS_RS_predict,[TE_Actions.Label1st]'];
                   ENS_RS_accuracy=length(find(ENS_RS_predict==[TE_Actions.Label1st]'))/length([TE_Actions.Label1st]')*100
                   S1stC_accuracy=ENS_RS_accuracy(1);    
                   S1stC_predict = ENS_RS_predict;
           
                  case 11
               %% 11.�������������BP�����磩
                TR_LL=[TR_Actions.Label1st]';
                TE_LL=[TE_Actions.Label1st]';
               %����ֵ��һ��
                [input,minI,maxI] = premnmx(TR_TP');
                %һ�������в���ͬ��������������Ұ���ԭ����˳�����
                [c,i]=unique(TR_LL,'first');
                j=sort(i);
                u=TR_LL(j);
                n = numel(u);
                TR_LL_Trans=TR_LL;
                for Trans_cc=1:n
                        TR_LL_Trans(find(TR_LL_Trans==u(Trans_cc)))=Trans_cc;
                end
                %�����������
                s = length(TR_LL) ;
                output = zeros( s , n) ;
                for i = 1 : s 
                   output( i , TR_LL_Trans( i )  ) = 1 ;
                end
                %һ�������в���ͬ��������������Ұ���ԭ����˳�����
                [c,i]=unique(TE_LL,'first');
                j=sort(i);
                u=TE_LL(j);
                n = numel(u);
                TE_LL_Trans=TE_LL;
                for Trans_cc=1:n
                        TE_LL_Trans(find(TE_LL_Trans==u(Trans_cc)))=Trans_cc;
                end
                %�������ݹ�һ��
                testInput = tramnmx( TE_TP' , minI, maxI ) ;
                %����������
                net = newff( minmax(input) , [30 7] , { 'logsig' 'purelin' 'tansig' } , 'traingdx' ) ; 
                %����ѵ������
                net.trainparam.show = 100 ;
                net.trainparam.epochs = 1000;
                net.trainparam.goal = 0.01 ;
                net.trainParam.lr = 0.01 ;
                %% ������ʾ����
                net.trainParam.showWindow=false;
                %��ʼѵ��
                net = train( net, input , output' ) ;
                %����
                net_Y = sim( net , testInput );
                %ͳ��ʶ����ȷ��
                [net_Max , net_Index] = max( net_Y);
                %ת����ԭ��ǩ
                [c,i]=unique(TE_LL,'first');
                j=sort(i);
                u=TE_LL(j);
                n = numel(u);
                for Trans_cc=1:n
                        net_Index(find(net_Index==Trans_cc))=u(Trans_cc);
                end
                BPNet_predict=net_Index';
                BPNet_accuracyC=[BPNet_predict,TE_LL];
                BPNet_accuracy=length(find(BPNet_predict==TE_LL))/length(TE_LL)*100
                S1stC_accuracy=BPNet_accuracy(1); 
                S1stC_predict=BPNet_predict;            
           
              otherwise  
                      break;
          end
           
            predict_Label1st=S1stC_predict;
            CPRP=[[TE_Actions.label]',[TE_Actions.Label1st]',predict_Label1st,predict_Label1st];%���˵���CPRP����˼��������ô�á�          
            CPRP1st_accuracy=length(find(CPRP(:,4)==CPRP(:,2)))/length(CPRP(:,2))*100

            %[C,order] = confusionmat(CPRP(:,2),CPRP(:,4));
          
 %% ��һ�����-����          
            
            
            
            
            
  %% �ڶ������-��ʼ          
            
             %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             %% Step.3.2.1 ��һ������ʹ��HMM
               TR_Actions1C=TR_Actions([TR_Actions.Label1st]'==101);
               TE_Actions1C=TE_Actions(predict_Label1st==101);
               if size(TE_Actions1C,2)~=0
                  param.O = 6;  % dimensionality of feature vector of each frame in an action sequence
                  param.Q = 6;   % number of states (default)
                  param.M = 6;    % number of mixtures
                  param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
                  param.max_iter = 10;    % number of iterations
                  param.verbose = 1;

                 % Training
                 fprintf('HMM training.\n');
                 param.Q = 9;   % number of states
                 HMM_Models = hmmTrain1C(TR_Actions1C, param);%tt

                 % Testing
                 fprintf('HMM testing.\n');
                 % prescale test data
                 [accuracy, predict_label1C, true_label] = hmmTest1C(TE_Actions1C, HMM_Models);%tt

                 predictAA1C=[true_label,predict_label1C];
                 fprintf('accuracy: %.4f\n', accuracy);
                 CPRP((CPRP(:,4)==101),4)=predict_label1C;
              end

            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Step.3.2.2 �ڶ�������ʹ��HMM
              TR_Actions2C=TR_Actions([TR_Actions.Label1st]'==102);
              TE_Actions2C=TE_Actions(predict_Label1st==102);

              if size(TE_Actions2C,2)~=0
                 param.O = 12;  % dimensionality of feature vector of each frame in an action sequence
                 param.Q = 6;   % number of states (default)
                 param.M = 6;    % number of mixtures
                 param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
                 param.max_iter = 10;    % number of iterations
                 param.verbose = 1;

                 % Training
                 fprintf('HMM training.\n');
                 param.Q = 9;   % number of states
                 HMM_Models = hmmTrain2C(TR_Actions2C, param);%tt

                 % Testing
                 fprintf('HMM testing.\n');
                 % prescale test data
                 [accuracy, predict_label2C, true_label] = hmmTest2C(TE_Actions2C, HMM_Models);%tt

                 predictAA2C=[true_label,predict_label2C];
                 fprintf('accuracy: %.4f\n', accuracy);
                 CPRP((CPRP(:,4)==102),4)=predict_label2C;
              end

            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Step.3.2.3 ����������ʹ��HMM
              TR_Actions3C=TR_Actions([TR_Actions.Label1st]'==103);
              TE_Actions3C=TE_Actions(predict_Label1st==103);

              if size(TE_Actions3C,2)~=0
                 param.O = 6;  % dimensionality of feature vector of each frame in an action sequence
                 param.Q = 6;   % number of states (default)
                 param.M = 6;    % number of mixtures
                 param.cov_type = 'diag'; % cov_type: 'full', 'diag', 'spherical'
                 param.max_iter = 10;    % number of iterations
                 param.verbose = 1;

                 % Training
                 fprintf('HMM training.\n');
                 param.Q = 9;   % number of states
                 HMM_Models = hmmTrain3C(TR_Actions3C, param);%tt

                 % Testing
                 fprintf('HMM testing.\n');
                 % prescale test data
                 [accuracy, predict_label3C, true_label] = hmmTest3C(TE_Actions3C, HMM_Models);%tt
  
                 predictAA3C=[true_label,predict_label3C];
                 fprintf('accuracy: %.4f\n', accuracy);
                 CPRP((CPRP(:,4)==103),4)=predict_label3C;
              end

              
 %% �ڶ������-����



          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% Step.3.X Final Result of ten fold cross validation
           [C,order] = confusionmat(CPRP(:,1),CPRP(:,4));
           Cbag{k}=C;
           CPRPbag{k}=CPRP;
           Caccuracy(k)=trace(C)/sum(sum(C));
%            clearvars -except All_Actions indices k kk Caccuracy Cbag CaccuracyBag CPRPbag T TT MeanCaccuracy Finaccuracy StdFA TTCaccuracy TTCbag TTCPRPbag CCCCC
        end
  
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.3.Z -- Final Result of ten times cross validation   
TTCaccuracy(:,T)=Caccuracy';%ÿ��Ϊһ��ʮ�۽�����֤���
TTCbag(:,T)=Cbag';
TTCPRPbag(:,T)=CPRPbag';

end
             
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Step.4.0 -- Final Result
MeanCaccuracy=mean(TTCaccuracy);
StdFA=std(TTCaccuracy);
Finaccuracy=sprintf('%2.8f%%\n', (MeanCaccuracy).*100)
FinStdFA=sprintf('%2.8f%%\n', (StdFA).*100)
TtimesMeanCaccuracy=mean(MeanCaccuracy)
TtimesStdFAsmean=mean(StdFA)

toc









