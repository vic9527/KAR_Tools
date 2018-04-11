function Features = P5C_eachMeanVar_Cell(Data)
%clearvars -except Data
iii=size(Data,2);
for i=1:iii
fprintf('本次特征提取已达：%5.2f%%\n', i/iii*100);
    SD=Data{i}; %Single Data
    for j=1:size(SD,1)
        A=[SD{j,1}]';
        for ii=1:20
            eval(['k',num2str(ii),'=','A(:,ii*3-2:ii*3)',';']);
        end
        
% 		k1o=IF_offset(k1); 
% 		k2o=IF_offset(k2); 
% 		k3o=IF_offset(k3); 
% 		k4o=IF_offset(k4); 
% 		k5o=IF_offset(k5); 
% 		k6o=IF_offset(k6); 
% 		k7o=IF_offset(k7); 
% 		k8o=IF_offset(k8); 
% 		k9o=IF_offset(k9); 
% 		k10o=IF_offset(k10); 
% 		k11o=IF_offset(k11); 
% 		k12o=IF_offset(k12); 
% 		k13o=IF_offset(k13); 
% 		k14o=IF_offset(k14); 
% 		k15o=IF_offset(k15); 
% 		k16o=IF_offset(k16); 
% 		k17o=IF_offset(k17); 
% 		k18o=IF_offset(k18); 
% 		k19o=IF_offset(k19); 
% 		k20o=IF_offset(k20);
% 		
% 		k1oMV=[mean(k1o),var(k1o)];
% 		k2oMV=[mean(k2o),var(k2o)];
% 		k3oMV=[mean(k3o),var(k3o)];
% 		k4oMV=[mean(k4o),var(k4o)];
% 		k5oMV=[mean(k5o),var(k5o)];
% 		k6oMV=[mean(k6o),var(k6o)];
% 		k7oMV=[mean(k7o),var(k7o)];
% 		k8oMV=[mean(k8o),var(k8o)];
% 		k9oMV=[mean(k9o),var(k9o)];
% 		k10oMV=[mean(k10o),var(k10o)];
% 		k11oMV=[mean(k11o),var(k11o)];
% 		k12oMV=[mean(k12o),var(k12o)];
% 		k13oMV=[mean(k13o),var(k13o)];
% 		k14oMV=[mean(k14o),var(k14o)];
% 		k15oMV=[mean(k15o),var(k15o)];
% 		k16oMV=[mean(k16o),var(k16o)];
% 		k17oMV=[mean(k17o),var(k17o)];
% 		k18oMV=[mean(k18o),var(k18o)];
% 		k19oMV=[mean(k19o),var(k19o)];
% 		k20oMV=[mean(k20o),var(k20o)];

		k3o=IF_offset(k3-k7); 
		k4o=IF_offset(k4-k7); 
		k8o=IF_offset(k8-k1); 
		k9o=IF_offset(k9-k2); 
		k10o=IF_offset(k10-k1); 
		k11o=IF_offset(k11-k2); 
		k12o=IF_offset(k12-k1); 
		k13o=IF_offset(k13-k2); 
		k14o=IF_offset(k14-k5); 
		k15o=IF_offset(k15-k6); 
		k16o=IF_offset(k16-k5); 
		k17o=IF_offset(k17-k6); 
		k18o=IF_offset(k18-k5); 
		k19o=IF_offset(k19-k6); 
		k20o=IF_offset(k20-k7);
		
		k3oMV=[mean(k3o),var(k3o)];
		k4oMV=[mean(k4o),var(k4o)];
		k8oMV=[mean(k8o),var(k8o)];
		k9oMV=[mean(k9o),var(k9o)];
		k10oMV=[mean(k10o),var(k10o)];
		k11oMV=[mean(k11o),var(k11o)];
		k12oMV=[mean(k12o),var(k12o)];
		k13oMV=[mean(k13o),var(k13o)];
		k14oMV=[mean(k14o),var(k14o)];
		k15oMV=[mean(k15o),var(k15o)];
		k16oMV=[mean(k16o),var(k16o)];
		k17oMV=[mean(k17o),var(k17o)];
		k18oMV=[mean(k18o),var(k18o)];
		k19oMV=[mean(k19o),var(k19o)];
		k20oMV=[mean(k20o),var(k20o)];        
        
        Part1{i}(j,:)=[k3oMV,k4oMV,k20oMV];
        Part2{i}(j,:)=[k8oMV,k10oMV,k12oMV];
        Part3{i}(j,:)=[k9oMV,k11oMV,k13oMV];
        Part4{i}(j,:)=[k14oMV,k16oMV,k18oMV];
        Part5{i}(j,:)=[k15oMV,k17oMV,k19oMV];

   

    end
    
    DataMV{i}=[Part1{i},Part2{i},Part3{i},Part4{i},Part5{i}];
    
end
            Features=DataMV;

end