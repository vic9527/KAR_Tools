function [ label, data, Label1st]=DS_Extraction(DS)

for kk=1:size(DS,2)
for jj=1:size(DS{kk},2)
		 label{kk}(jj,1)=DS{kk}(jj).label; 
		 data{kk}{jj,1}=DS{kk}(jj).data;
		 Label1st{kk}(jj,1)=DS{kk}(jj).Label1st; 
end  
end

end