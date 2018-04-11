function [TR_DS, TE_DS]=UIVboost(DataSet,n,k)
%nΪ������������kΪ���Լ�����.

% clear;clc
% A=combnk(1:10,5)
% 
% B=nchoosek(1:10,5)
% C=combntns(1:10,5)%The COMBNTNS function will be removed in a future release.


% n=10;
% k=1;%ѡ����Ϊ���Լ�.
CombNum=nchoosek(1:n,k);

clearvars n k

SubjectMat=[cell2mat({DataSet.subject})]';% {S.name} :convert to cell

%ԭ��ǩת������Ȼ��˳���ǩ
[YtransIdx,Ytrans]=LabelTrans_in(SubjectMat);
SubjectMat=LabelTrans_out(YtransIdx,Ytrans);

CombID_All={};   
for i=1:size(CombNum,1)
     CombID=[];
for j=1:size(CombNum,2)  
CombID=[CombID;find(Ytrans==CombNum(i,j))];
end
     CombID_All{i}=CombID;
end

clearvars i j CombID CombNum


for kk=1:size(CombID_All,2)
test_id = ismember(SubjectMat,SubjectMat(CombID_All{kk}));
train_id=~test_id;
TE_DS{kk}=DataSet(test_id);
TR_DS{kk}=DataSet(train_id);
	 
clearvars test_id train_id

fprintf('���ڴ����%d�����......\n', kk);

end

fprintf('OK! ȫ��%d���������ɣ�����\n', kk);

clearvars kk CombID_All SubjectMat


	 