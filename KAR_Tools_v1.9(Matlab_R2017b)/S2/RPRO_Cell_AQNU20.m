function Features = RPRO_Cell_AQNU20(Data)
%clearvars -except Data
% Data=TR_data;
iii=size(Data,2);
for i=1:iii
    fprintf('本次特征提取已达：%5.2f%%\n', i/iii*100);
    SD=Data{i}; %Single Data
    for j=1:size(SD,1)
        A=[SD{j,1}]';
        for ii=1:20
            eval(['k',num2str(ii),'=','A(:,ii*3-2:ii*3)',';']);
        end
        

        
        E1_1=(k4-k1);
        E2_1=(k8-k5);
        E3_1=(k12-k9);
        E4_1=(k16-k13);
        E5_1=(k20-k17); 

        E1_3=(k4-k1);
        E2_3=(k8-k1);
        E3_3=(k12-k1);
        E4_3=(k16-k1);
        E5_3=(k20-k1); 

        T1_1=[0 0 0;diff(E1_1)];
        T2_1=[0 0 0;diff(E2_1)];
        T3_1=[0 0 0;diff(E3_1)];
        T4_1=[0 0 0;diff(E4_1)];
        T5_1=[0 0 0;diff(E5_1)];

        T1_3=[0 0 0;diff(E1_3)];
        T2_3=[0 0 0;diff(E2_3)];
        T3_3=[0 0 0;diff(E3_3)];
        T4_3=[0 0 0;diff(E4_3)];
        T5_3=[0 0 0;diff(E5_3)];

		E=[E1_1';T1_1';E1_3';T1_3';...
           E2_1';T2_1';E2_3';T2_3';...
           E3_1';T3_1';E3_3';T3_3';...
           E4_1';T4_1';E4_3';T4_3';...
           E5_1';T5_1';E5_3';T5_3']; % 82%   66666666666666666666666666   
       
       
       
E(isinf(E))=0;
E(isnan(E))=0;
 
        Ebag{j,1}=E;
   
 clearvars E

    end
    
    Features{i}=Ebag;
    clearvars Ebag
     
end


end