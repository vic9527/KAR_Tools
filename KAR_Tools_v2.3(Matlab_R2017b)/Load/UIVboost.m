function [TR_DS, TE_DS]=UIVboost(DataSet,n,k)
%n为受试者人数，k为测试集人数.

% clear;clc
% A=combnk(1:10,5)
% 
% B=nchoosek(1:10,5)
% C=combntns(1:10,5)%The COMBNTNS function will be removed in a future release.


% n=10;
% k=1;%选多少为测试集.
CombNum=nchoosek(1:n,k);

clearvars n k

SubjectMat=[cell2mat({DataSet.subject})]';% {S.name} :convert to cell

%原标签转换成自然数顺序标签
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

fprintf('正在处理第%d种组合......\n', kk);

end

fprintf('OK! 全部%d种组合已完成！！！\n', kk);

clearvars kk CombID_All SubjectMat


	 