function FV2ndStruct=FV_Cell2Struct(FV2ndCell,label,Label1st)

% FV2ndCell=TR_FV2nd;
% label=TrainT_label;
% Label1st=TrainT_Label1st;

FV2ndStruct={};
for i=1:size(FV2ndCell,2)
 FV2ndStruct{i}=struct('Feature',FV2ndCell{i},'label',0,'Label1st',0);
 for j=1:size(FV2ndStruct{i},1)
 FV2ndStruct{i}(j).label=label{i}(j,1);
 FV2ndStruct{i}(j).Label1st=Label1st{i}(j,1);
 end
end

end