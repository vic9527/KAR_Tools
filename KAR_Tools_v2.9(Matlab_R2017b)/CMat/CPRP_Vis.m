function CPRP_Vis(CPRP)
Temp=[];
for i=1:size(CPRP,2)
    
    Temp=[Temp;CPRP{i}(:,[1 4])];
    
%     CPRP_i_accuracy(i) = length(find(CPRP{i}(:,4) == CPRP{i}(:,1)))/length(CPRP{i}(:,1));
%     Temp_accuracy(i) = length(find(Temp(:,2) == Temp(:,1)))/length(Temp(:,1));
    
end
% [C,order]=confusionmat(Temp(:,1),Temp(:,2));%��һ���ǲ��Ա�ǩ���ڶ�����Ԥ���ǩ��

KAR_CMat(Temp(:,1),Temp(:,2))%��һ���ǲ��Ա�ǩ���ڶ�����Ԥ���ǩ��

% CPRP_accuracy = length(find(Temp(:,2) == Temp(:,1)))/length(Temp(:,1))
% mean(CPRP2nd_accuracy)
end