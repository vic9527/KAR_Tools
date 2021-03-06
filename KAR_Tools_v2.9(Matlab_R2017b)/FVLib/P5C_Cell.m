function Features = P5C_Cell(Data)
% Data=TR_data;
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

		Part1_C=(k3+k4+k20)/3-k7;
        Part2_C=(k8+k10+k12)/3-k1;
        Part3_C=(k9+k11+k13)/3-k2; 
        Part4_C=(k14+k16+k18)/3-k5;
        Part5_C=(k15+k17+k19)/3-k6;

        Part1_T=A_offset1(Part1_C);
        Part2_T=A_offset1(Part2_C);
        Part3_T=A_offset1(Part3_C);
        Part4_T=A_offset1(Part4_C);
        Part5_T=A_offset1(Part5_C);
        
        Part1{i}(j,:)=[mean(Part1_T),var(Part1_T),...
             range(Part1_T),skewness(Part1_T)];
        Part2{i}(j,:)=[mean(Part2_T),var(Part2_T),...
             range(Part2_T),skewness(Part2_T)];
        Part3{i}(j,:)=[mean(Part3_T),var(Part3_T),...
             range(Part3_T),skewness(Part3_T)];
        Part4{i}(j,:)=[mean(Part4_T),var(Part4_T),...
             range(Part4_T),skewness(Part4_T)];
        Part5{i}(j,:)=[mean(Part5_T),var(Part5_T),...
             range(Part5_T),skewness(Part5_T)];  





        
    end
    
    DataMV{i}=[Part1{i},Part2{i},Part3{i},Part4{i},Part5{i}];
    
end
            Features=DataMV;

end