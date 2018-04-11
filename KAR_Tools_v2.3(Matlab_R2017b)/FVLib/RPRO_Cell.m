function Features = RPRO_Cell(Data)
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
        
        
        E1_1=(k20-k7);
        E2_1=(k12-k1);
        E3_1=(k13-k2);
        E4_1=(k18-k5);
        E5_1=(k19-k6); 
 
        E1_3=(k20-k7);
        E2_3=(k12-k7);
        E3_3=(k13-k7);
        E4_3=(k18-k7);
        E5_3=(k19-k7); 

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





     k4k7=k4-k7;
     k5k7=k5-k7;
     A1_1 = AB_Ang(k4k7,k5k7); 

     k7k4=k7-k4;
     k3k4=k3-k4;
     A1_2 = AB_Ang(k7k4,k3k4);   
     A1_3 = CrossAB_Ang(k7k4,k3k4);
   
k20k3=k20-k3;
k4k3=k4-k3;
A1_4 = AB_Ang(k20k3,k4k3); 

     k8k1=k8-k1;
     k7k1=k7-k1;
     A2_1 = AB_Ang(k8k1,k7k1); 

     k10k8=k10-k8;
     k1k8=k1-k8;
     A2_2 = AB_Ang(k10k8,k1k8); 
     A2_3 = CrossAB_Ang(k10k8,k1k8);

k12k10=k12-k10;
k8k10=k8-k10;
A2_4 = AB_Ang(k12k10,k8k10);

     k9k2=k9-k2;
     k7k2=k7-k2;     
     A3_1 = AB_Ang(k9k2,k7k2);  

     k11k9=k11-k9;
     k2k9=k2-k9;     
     A3_2 = AB_Ang(k11k9,k2k9);
     A3_3 = CrossAB_Ang(k11k9,k2k9); 

k13k11=k13-k11;
k9k11=k9-k11;
A3_4 = AB_Ang(k13k11,k9k11);

     k7k5=k7-k5;
     k14k5=k14-k5;
     A4_1 = AB_Ang(k7k5,k14k5);  

     k5k14=k5-k14;
     k16k14=k16-k14;
     A4_2 = AB_Ang(k5k14,k16k14);  
     A4_3 = CrossAB_Ang(k5k14,k16k14); 

k14k16=k14-k16;
k18k16=k18-k16;
A4_4 = AB_Ang(k14k16,k18k16);

     k7k6=k7-k6;
     k15k6=k15-k6;
     A5_1 = AB_Ang(k7k6,k15k6); 

     k6k15=k6-k15;
     k17k15=k17-k15;
     A5_2 = AB_Ang(k6k15,k17k15); 
     A5_3 = CrossAB_Ang(k6k15,k17k15);

k15k17=k15-k17;
k19k17=k19-k17;
A5_4 = AB_Ang(k15k17,k19k17);

 
     A1_1 = mapminmax(A1_1',0,1)';A1_2 = mapminmax(A1_2',0,1)';A1_3 = mapminmax(A1_3',0,1)';
     A1_4 = mapminmax(A1_4',0,1)';
     A2_1 = mapminmax(A2_1',0,1)';A2_2 = mapminmax(A2_2',0,1)';A2_3 = mapminmax(A2_3',0,1)';
     A2_4 = mapminmax(A2_4',0,1)';
     A3_1 = mapminmax(A3_1',0,1)';A3_2 = mapminmax(A3_2',0,1)';A3_3 = mapminmax(A3_3',0,1)';
     A3_4 = mapminmax(A3_4',0,1)';
     A4_1 = mapminmax(A4_1',0,1)';A4_2 = mapminmax(A4_2',0,1)';A4_3 = mapminmax(A4_3',0,1)';
     A4_4 = mapminmax(A4_4',0,1)';
     A5_1 = mapminmax(A5_1',0,1)';A5_2 = mapminmax(A5_2',0,1)';A5_3 = mapminmax(A5_3',0,1)';
     A5_4 = mapminmax(A5_4',0,1)';
     

        E=[E1_1';T1_1';E1_3';T1_3';A1_1';A1_2';A1_3';...
           E2_1';T2_1';E2_3';T2_3';A2_1';A2_2';A2_3';...
           E3_1';T3_1';E3_3';T3_3';A3_1';A3_2';A3_3';...
           E4_1';T4_1';E4_3';T4_3';A4_1';A4_2';A4_3';...
           E5_1';T5_1';E5_3';T5_3';A5_1';A5_2';A5_3']; % 82%   66666666666666666666666666   


       
       
       
E(isinf(E))=0;
E(isnan(E))=0;
 
        Ebag{j,1}=E;
   
 clearvars E

    end
    
    Features{i}=Ebag;
    clearvars Ebag
     
end


end