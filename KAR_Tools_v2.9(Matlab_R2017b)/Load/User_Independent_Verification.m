function [TR_data, TR_label, TR_Label1st, TE_data, TE_label, TE_Label1st]=User_Independent_Verification(DataSet,n,k)
%n为受试者人数，k为测试集人数.

% clear;clc
% A=combnk(1:10,5)
% 
% B=nchoosek(1:10,5)
% C=combntns(1:10,5)%The COMBNTNS function will be removed in a future release.


% n=10;
% k=5;%选多少为测试集.
CombNum=nchoosek(1:n,k);

clearvars n k

SubjectMat=[cell2mat({DataSet.subject})]';% {S.name} :convert to cell

CombID_All={};   
for i=1:size(CombNum,1)
     CombID=[];
for j=1:size(CombNum,2)  
CombID=[CombID;find(SubjectMat==CombNum(i,j))];
end
     CombID_All{i}=CombID;
end

clearvars i j CombID CombNum

TE_DS={};
TR_DS={};
for kk=1:size(CombID_All,2)
test_id = ismember(SubjectMat,SubjectMat(CombID_All{kk}));
train_id=~test_id;
TE_DS{kk}=DataSet(test_id);
TR_DS{kk}=DataSet(train_id);

	 for jj=1:size(TR_DS{kk},2)
		 TR_label{kk}(jj,1)=TR_DS{kk}(jj).label; 
		 TR_data{kk}{jj,1}=TR_DS{kk}(jj).data;
		 TR_Label1st{kk}(jj,1)=TR_DS{kk}(jj).Label1st; 
	 end  
	 for jj=1:size(TE_DS{kk},2)
		 TE_label{kk}(jj,1)=TE_DS{kk}(jj).label; 
		 TE_data{kk}{jj,1}=TE_DS{kk}(jj).data;
		 TE_Label1st{kk}(jj,1)=TE_DS{kk}(jj).Label1st; 
	 end  

clearvars test_id train_id

fprintf('');

end

clearvars kk CombID_All SubjectMat


	 