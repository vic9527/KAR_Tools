function DataMV=MeanVar_Cell(Data)

for i=1:size(Data,2)
    SD=Data{i}; %Single Data
    for j=1:size(SD,1)
        DM{i}(j,:)=mean([SD{j,1}]');
        DV{i}(j,:)=var([SD{j,1}]');
    end
    DataMV{i}=[DM{i},DV{i}];
end

 clearvars i j SD DM DV Data
 
end