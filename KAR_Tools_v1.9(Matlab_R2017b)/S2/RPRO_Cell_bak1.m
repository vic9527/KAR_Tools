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

% %         双间距离标准化
%         StdLen=k2-k1;
%         lenNorm=mean(sqrt(sum(StdLen.^2,2)));
% 	    Part1_1=(k20-k7)/lenNorm;
% 		Part1_2=(k3-k7)/lenNorm;
% 		Part1_3=(k4-k7)/lenNorm;
%         Part2_1=(k12-k1)/lenNorm;
% 		Part2_2=(k10-k1)/lenNorm;
% 		Part2_3=(k8-k1)/lenNorm;
%         Part3_1=(k13-k2)/lenNorm;
% 		Part3_2=(k11-k2)/lenNorm;
% 		Part3_3=(k9-k2)/lenNorm;
%         Part4_1=(k18-k5)/lenNorm;
% 		Part4_2=(k16-k5)/lenNorm;
% 		Part4_3=(k14-k5)/lenNorm;
%         Part5_1=(k19-k6)/lenNorm;
% 		Part5_2=(k17-k6)/lenNorm;
% 		Part5_3=(k15-k6)/lenNorm;	

%         % 五终端相对坐标
% %         E1=(k20-k7)/lenNorm;
% %         E2=(k12-k1)/lenNorm;
% %         E3=(k13-k2)/lenNorm;
% %         E4=(k18-k5)/lenNorm;
% %         E5=(k19-k6)/lenNorm;
        
        E1_1=(k20-k7);
        E2_1=(k12-k1);
        E3_1=(k13-k2);
        E4_1=(k18-k5);
        E5_1=(k19-k6); 
        
% % %         E1_2=(k4-k7);
% % %         E2_2=(k8-k1);
% % %         E3_2=(k9-k2);
% % %         E4_2=(k14-k5);
% % %         E5_2=(k15-k6);        
        E1_3=(k20-k7);
        E2_3=(k12-k7);
        E3_3=(k13-k7);
        E4_3=(k18-k7);
        E5_3=(k19-k7);       
%         AE1=A_AngXYZ(E1);
%         AE2=A_AngXYZ(E2);
%         AE3=A_AngXYZ(E3);
%         AE4=A_AngXYZ(E4);
%         AE5=A_AngXYZ(E5);
%         T1O=A_offset1(E1);
%         T2O=A_offset1(E2);
%         T3O=A_offset1(E3);
%         T4O=A_offset1(E4);
%         T5O=A_offset1(E5);
        T1_1=[0 0 0;diff(E1_1)];
        T2_1=[0 0 0;diff(E2_1)];
        T3_1=[0 0 0;diff(E3_1)];
        T4_1=[0 0 0;diff(E4_1)];
        T5_1=[0 0 0;diff(E5_1)];
        
% % %         T1_2=[0 0 0;diff(E1_2)];
% % %         T2_2=[0 0 0;diff(E2_2)];
% % %         T3_2=[0 0 0;diff(E3_2)];
% % %         T4_2=[0 0 0;diff(E4_2)];
% % %         T5_2=[0 0 0;diff(E5_2)];

        T1_3=[0 0 0;diff(E1_3)];
        T2_3=[0 0 0;diff(E2_3)];
        T3_3=[0 0 0;diff(E3_3)];
        T4_3=[0 0 0;diff(E4_3)];
        T5_3=[0 0 0;diff(E5_3)];
%         AT1=[0 0 0;A_AngXYZ(diff(E1))];
%         AT2=[0 0 0;A_AngXYZ(diff(E2))];
%         AT3=[0 0 0;A_AngXYZ(diff(E3))];
%         AT4=[0 0 0;A_AngXYZ(diff(E4))];
%         AT5=[0 0 0;A_AngXYZ(diff(E5))];
%         AT1 = mapminmax(AT1',0,1)';
%         AT2 = mapminmax(AT2',0,1)';
%         AT3 = mapminmax(AT3',0,1)';
%         AT4 = mapminmax(AT4',0,1)';
%         AT5 = mapminmax(AT5',0,1)';
%         AE1 = mapminmax(AE1',0,1)';
%         AE2 = mapminmax(AE2',0,1)';
%         AE3 = mapminmax(AE3',0,1)';
%         AE4 = mapminmax(AE4',0,1)';
%         AE5 = mapminmax(AE5',0,1)';
%         E1 = mapminmax(E1',-1,1)';
%         E2 = mapminmax(E2',-1,1)';
%         E3 = mapminmax(E3',-1,1)';
%         E4 = mapminmax(E4',-1,1)';
%         E5 = mapminmax(E5',-1,1)';
     k4k7=k4-k7;
     k5k7=k5-k7;
     A1_1 = AB_Ang(k4k7,k5k7); 
%      D1_1=[0 ;diff(A1_1)];
     k7k4=k7-k4;
     k3k4=k3-k4;
     A1_2 = AB_Ang(k7k4,k3k4);   
     A1_3 = CrossAB_Ang(k7k4,k3k4);
%      D1_2=[0 ;diff(A1_2)];
%      D1_3=[0 ;diff(A1_3)];
k20k3=k20-k3;
k4k3=k4-k3;
A1_4 = AB_Ang(k20k3,k4k3); 

     k8k1=k8-k1;
     k7k1=k7-k1;
     A2_1 = AB_Ang(k8k1,k7k1); 
%      D2_1=[0 ;diff(A2_1)];
     k10k8=k10-k8;
     k1k8=k1-k8;
     A2_2 = AB_Ang(k10k8,k1k8); 
     A2_3 = CrossAB_Ang(k10k8,k1k8);
%      D2_2=[0 ;diff(A2_2)];
%      D2_3=[0 ;diff(A2_3)];
k12k10=k12-k10;
k8k10=k8-k10;
A2_4 = AB_Ang(k12k10,k8k10);

     k9k2=k9-k2;
     k7k2=k7-k2;     
     A3_1 = AB_Ang(k9k2,k7k2);  
%      D3_1=[0 ;diff(A3_1)];
     k11k9=k11-k9;
     k2k9=k2-k9;     
     A3_2 = AB_Ang(k11k9,k2k9);
     A3_3 = CrossAB_Ang(k11k9,k2k9); 
%      D3_2=[0 ;diff(A3_2)];
%      D3_3=[0 ;diff(A3_3)];
k13k11=k13-k11;
k9k11=k9-k11;
A3_4 = AB_Ang(k13k11,k9k11);

     k7k5=k7-k5;
     k14k5=k14-k5;
     A4_1 = AB_Ang(k7k5,k14k5);  
%      D4_1=[0 ;diff(A4_1)];
     k5k14=k5-k14;
     k16k14=k16-k14;
     A4_2 = AB_Ang(k5k14,k16k14);  
     A4_3 = CrossAB_Ang(k5k14,k16k14); 
%      D4_2=[0 ;diff(A4_2)];
%      D4_3=[0 ;diff(A4_3)];
k14k16=k14-k16;
k18k16=k18-k16;
A4_4 = AB_Ang(k14k16,k18k16);

     k7k6=k7-k6;
     k15k6=k15-k6;
     A5_1 = AB_Ang(k7k6,k15k6); 
%      D5_1=[0 ;diff(A5_1)];
     k6k15=k6-k15;
     k17k15=k17-k15;
     A5_2 = AB_Ang(k6k15,k17k15); 
     A5_3 = CrossAB_Ang(k6k15,k17k15);
%      D5_2=[0 ;diff(A5_2)];
%      D5_3=[0 ;diff(A5_3)];
k15k17=k15-k17;
k19k17=k19-k17;
A5_4 = AB_Ang(k15k17,k19k17);

%         E1 = mapminmax(E1',0,1)'; %%-1 1标准化
%         E2 = mapminmax(E2',0,1)'; %%-1 1标准化
%         E3 = mapminmax(E3',0,1)'; %%-1 1标准化
%         E4 = mapminmax(E4',0,1)'; %%-1 1标准化
%         E5 = mapminmax(E5',0,1)'; %%-1 1标准化 不能用，太差！     
     A1_1 = mapminmax(A1_1',0,1)';A1_2 = mapminmax(A1_2',0,1)';A1_3 = mapminmax(A1_3',0,1)';A1_4 = mapminmax(A1_4',0,1)';
     A2_1 = mapminmax(A2_1',0,1)';A2_2 = mapminmax(A2_2',0,1)';A2_3 = mapminmax(A2_3',0,1)';A2_4 = mapminmax(A2_4',0,1)';
     A3_1 = mapminmax(A3_1',0,1)';A3_2 = mapminmax(A3_2',0,1)';A3_3 = mapminmax(A3_3',0,1)';A3_4 = mapminmax(A3_4',0,1)';
     A4_1 = mapminmax(A4_1',0,1)';A4_2 = mapminmax(A4_2',0,1)';A4_3 = mapminmax(A4_3',0,1)';A4_4 = mapminmax(A4_4',0,1)';
     A5_1 = mapminmax(A5_1',0,1)';A5_2 = mapminmax(A5_2',0,1)';A5_3 = mapminmax(A5_3',0,1)';A5_4 = mapminmax(A5_4',0,1)';
%      D1_1 = mapminmax(D1_1',0,1)';D1_2 = mapminmax(D1_2',0,1)';D1_3 = mapminmax(D1_3',0,1)';
%      D2_1 = mapminmax(D2_1',0,1)';D2_2 = mapminmax(D2_2',0,1)';D2_3 = mapminmax(D2_3',0,1)';
%      D3_1 = mapminmax(D3_1',0,1)';D3_2 = mapminmax(D3_2',0,1)';D3_3 = mapminmax(D3_3',0,1)';
%      D4_1 = mapminmax(D4_1',0,1)';D4_2 = mapminmax(D4_2',0,1)';D4_3 = mapminmax(D4_3',0,1)';
%      D5_1 = mapminmax(D5_1',0,1)';D5_2 = mapminmax(D5_2',0,1)';D5_3 = mapminmax(D5_3',0,1)';
%      A1_1 = zscore(A1_1);A1_2 = zscore(A1_2);A1_3 = zscore(A1_3);
%      A2_1 = zscore(A2_1);A2_2 = zscore(A2_2);A2_3 = zscore(A2_3);
%      A3_1 = zscore(A3_1);A3_2 = zscore(A3_2);A3_3 = zscore(A3_3);
%      A4_1 = zscore(A4_1);A4_2 = zscore(A4_2);A4_3 = zscore(A4_3);
%      A5_1 = zscore(A5_1);A5_2 = zscore(A5_2);A5_3 = zscore(A5_3); 
%    A1_1 = mapstd(A1_1')';一样的。
%         E=[E1';T1';A1_1';A1_2';A1_3';...
%            E2';T2';A2_1';A2_2';A2_3';...
%            E3';T3';A3_1';A3_2';A3_3';...
%            E4';T4';A4_1';A4_2';A4_3';...
%            E5';T5';A5_1';A5_2';A5_3']; % 82%

%         E=[E1';T1';A1_1';A1_2';A1_3';T1_1';T1_2';T1_3';...
%            E2';T2';A2_1';A2_2';A2_3';T2_1';T2_2';T2_3';...
%            E3';T3';A3_1';A3_2';A3_3';T3_1';T3_2';T3_3';...
%            E4';T4';A4_1';A4_2';A4_3';T4_1';T4_2';T4_3';...
%            E5';T5';A5_1';A5_2';A5_3';T5_1';T5_2';T5_3']; % 82%

%         E=[E1_1';T1_1';E1_2';T1_2';A1_1';A1_2';A1_3';...
%            E2_1';T2_1';E2_2';T2_2';A2_1';A2_2';A2_3';...
%            E3_1';T3_1';E3_2';T3_2';A3_1';A3_2';A3_3';...
%            E4_1';T4_1';E4_2';T4_2';A4_1';A4_2';A4_3';...
%            E5_1';T5_1';E5_2';T5_2';A5_1';A5_2';A5_3']; % 82%
%         E=[E1_1';T1_1';A1_1';A1_2';A1_3';...
%            E2_1';T2_1';A2_1';A2_2';A2_3';...
%            E3_1';T3_1';A3_1';A3_2';A3_3';...
%            E4_1';T4_1';A4_1';A4_2';A4_3';...
%            E5_1';T5_1';A5_1';A5_2';A5_3']; % 82%
%         E=[k20';E1_1';T1_1';E1_3';T1_3';A1_1';A1_2';A1_3';...
%            k12';E2_1';T2_1';E2_3';T2_3';A2_1';A2_2';A2_3';...
%            k13';E3_1';T3_1';E3_3';T3_3';A3_1';A3_2';A3_3';...
%            k18';E4_1';T4_1';E4_3';T4_3';A4_1';A4_2';A4_3';...
%            k19';E5_1';T5_1';E5_3';T5_3';A5_1';A5_2';A5_3']; % 82%






%         E=[E1_1';T1_1';E1_3';T1_3';A1_1';A1_2';A1_3';A1_4';...
%            E2_1';T2_1';E2_3';T2_3';A2_1';A2_2';A2_3';A2_4';...
%            E3_1';T3_1';E3_3';T3_3';A3_1';A3_2';A3_3';A3_4';...
%            E4_1';T4_1';E4_3';T4_3';A4_1';A4_2';A4_3';A4_4';...
%            E5_1';T5_1';E5_3';T5_3';A5_1';A5_2';A5_3';A5_4']; % 82%
       
        E=[E1_1';T1_1';E1_3';T1_3';A1_1';A1_2';A1_3';...
           E2_1';T2_1';E2_3';T2_3';A2_1';A2_2';A2_3';...
           E3_1';T3_1';E3_3';T3_3';A3_1';A3_2';A3_3';...
           E4_1';T4_1';E4_3';T4_3';A4_1';A4_2';A4_3';...
           E5_1';T5_1';E5_3';T5_3';A5_1';A5_2';A5_3']; % 82%   

%         E=[E1_1';T1_1';E1_3';T1_3';A1_1';A1_2';...
%            E2_1';T2_1';E2_3';T2_3';A2_1';A2_2';...
%            E3_1';T3_1';E3_3';T3_3';A3_1';A3_2';...
%            E4_1';T4_1';E4_3';T4_3';A4_1';A4_2';...
%            E5_1';T5_1';E5_3';T5_3';A5_1';A5_2']; % 82% good 
%         E=[E1_1';T1_1';E1_3';T1_3';A1_2';...
%            E2_1';T2_1';E2_3';T2_3';A2_2';...
%            E3_1';T3_1';E3_3';T3_3';A3_2';...
%            E4_1';T4_1';E4_3';T4_3';A4_2';...
%            E5_1';T5_1';E5_3';T5_3';A5_2']; % 82%          
%         E=[E1_1';T1_1';E1_3';T1_3';...
%            E2_1';T2_1';E2_3';T2_3';...
%            E3_1';T3_1';E3_3';T3_3';...
%            E4_1';T4_1';E4_3';T4_3';...
%            E5_1';T5_1';E5_3';T5_3']; % 82%  NaN error          
%         E=[E1_1';T1_1';E1_3';T1_3';A1_1';A1_2';A1_4';...
%            E2_1';T2_1';E2_3';T2_3';A2_1';A2_2';A2_4';...
%            E3_1';T3_1';E3_3';T3_3';A3_1';A3_2';A3_4';...
%            E4_1';T4_1';E4_3';T4_3';A4_1';A4_2';A4_4';...
%            E5_1';T5_1';E5_3';T5_3';A5_1';A5_2';A5_4']; % 82%       
%         E=[E1_1';T1_1';E1_3';T1_3';A1_1';A1_2';D1_1';D1_2';...
%            E2_1';T2_1';E2_3';T2_3';A2_1';A2_2';D2_1';D2_2';...
%            E3_1';T3_1';E3_3';T3_3';A3_1';A3_2';D3_1';D3_2';...
%            E4_1';T4_1';E4_3';T4_3';A4_1';A4_2';D4_1';D4_2';...
%            E5_1';T5_1';E5_3';T5_3';A5_1';A5_2';D5_1';D5_2']; %     
%        
       
       
%         E=[E1';A1_1';A1_2';A1_3';...
%            E2';A2_1';A2_2';A2_3';...
%            E3';A3_1';A3_2';A3_3';...
%            E4';A4_1';A4_2';A4_3';...
%            E5';A5_1';A5_2';A5_3']; % 79%      
       
       
       
%         E=[AT1';A1_1';A1_2';A1_3';...
%            AT2';A2_1';A2_2';A2_3';...
%            AT3';A3_1';A3_2';A3_3';...
%            AT4';A4_1';A4_2';A4_3';...
%            AT5';A5_1';A5_2';A5_3']; % 78%
%         E=[AT1';...
%            AT2';...
%            AT3';...
%            AT4';...
%            AT5']; % 78%
%         E=[A1_1';A1_2';A1_3';...
%            A2_1';A2_2';A2_3';...
%            A3_1';A3_2';A3_3';...
%            A4_1';A4_2';A4_3';...
%            A5_1';A5_2';A5_3']; % 
%         E=[A1_1';A1_2';...
%            A2_1';A2_2';...
%            A3_1';A3_2';...
%            A4_1';A4_2';...
%            A5_1';A5_2']; % 
%         E=[A1_2';A1_3';...
%            A2_2';A2_3';...
%            A3_2';A3_3';...
%            A4_2';A4_3';...
%            A5_2';A5_3']; %        
%         E=[A1_2';A1_3';E1';...
%            A2_2';A2_3';E2';...
%            A3_2';A3_3';E3';...
%            A4_2';A4_3';E4';...
%            A5_2';A5_3';E5']; %   
       
%         E=[AE1';E1';...
%            AE2';E2';...
%            AE3';E3';...
%            AE4';E4';...
%            AE5';E5']; %        
       
       
%         E=[E1';T1';Ay_Gradient(E1)';Ay_Gradient(T1)';...
%            E2';T2';Ay_Gradient(E2)';Ay_Gradient(T2)';...
%            E3';T3';Ay_Gradient(E3)';Ay_Gradient(T3)';...
%            E4';T4';Ay_Gradient(E4)';Ay_Gradient(T4)';...
%            E5';T5';Ay_Gradient(E5)';Ay_Gradient(T5)']; %   
%         E=[E1';T1';...
%            E2';T2';...
%            E3';T3';...
%            E4';T4';...
%            E5';T5']; % 
% 		E1=(k3+k4+k20)/3-k7;
%         E2=(k8+k10+k12)/3-k1;
%         E3=(k9+k11+k13)/3-k2; 
%         E4=(k14+k16+k18)/3-k5;
%         E5=(k15+k17+k19)/3-k6;
%         E=[E1';E2';E3';E4';E5']; %0.70
%         E1=(k20-k7);
%         E2=(k12-k1);
%         E3=(k13-k2);
%         E4=(k18-k5);
%         E5=(k19-k6);
%         Z1=(k20-k7);
%         Z2=(k12-k7);
%         Z3=(k13-k7);
%         Z4=(k18-k7);
%         Z5=(k19-k7);
        
%         E=[E1';Z1';E2';Z2';E3';Z3';E4';Z4';E5';Z5']; %0.70
        
%         T1=A_offset1(k20);
%         T2=A_offset1(k12);
%         T3=A_offset1(k13);
%         T4=A_offset1(k18);
%         T5=A_offset1(k19);
%         E1 = mapminmax(E1',-1,1)'; %%-1 1标准化
%         E2 = mapminmax(E2',-1,1)'; %%-1 1标准化
%         E3 = mapminmax(E3',-1,1)'; %%-1 1标准化
%         E4 = mapminmax(E4',-1,1)'; %%-1 1标准化
%         E5 = mapminmax(E5',-1,1)'; %%-1 1标准化 不能用，太差！
%         E1Len = sum((E1.^2),2);
%         E2Len = sum((E2.^2),2);
%         E3Len = sum((E3.^2),2);
%         E4Len = sum((E4.^2),2);
%         E5Len = sum((E5.^2),2);
				
%         E1V=[0 0 0;diff(E1,1,1)];
%         E2V=[0 0 0;diff(E2,1,1)];
%         E3V=[0 0 0;diff(E3,1,1)];
%         E4V=[0 0 0;diff(E4,1,1)];
%         E5V=[0 0 0;diff(E5,1,1)];
%         E1A=[0 0 0;0 0 0;diff(E1,2,1)];
%         E2A=[0 0 0;0 0 0;diff(E2,2,1)];
%         E3A=[0 0 0;0 0 0;diff(E3,2,1)];
%         E4A=[0 0 0;0 0 0;diff(E4,2,1)];
%         E5A=[0 0 0;0 0 0;diff(E5,2,1)];        
% E=[E1';E2';E3';E4';E5']; %0.70
%  E=[E1';E1V';E2';E2V';E3';E3V';E4';E4V';E5';E5V']; %0.76
%         E=[E1';E1V';E1A';E2';E2V';E2A';E3';E3V';E3A';E4';E4V';E4A';E5';E5V';E5A']; %0.76
%          E=[E1';E1Len';E2';E2Len';E3';E3Len';E4';E4Len';E5';E5Len'];%0.74
% E=[E1';Ay_Gradient(E1)';E2';Ay_Gradient(E2)';E3';Ay_Gradient(E3)';E4';Ay_Gradient(E4)';E5';Ay_Gradient(E5)']; %0.72
%  E=[E1';E1V';E1A';Ay_Gradient(E1)';...
%       E2';E2V';E2A';Ay_Gradient(E2)';...
%       E3';E3V';E3A';Ay_Gradient(E3)';...
%       E4';E4V';E4A';Ay_Gradient(E4)';...
%       E5';E5V';E5A';Ay_Gradient(E5)']; %       
%   E=[E1';E1V';Ay_Gradient(E1)';...
%       E2';E2V';Ay_Gradient(E2)';...
%       E3';E3V';Ay_Gradient(E3)';...
%       E4';E4V';Ay_Gradient(E4)';...
%       E5';E5V';Ay_Gradient(E5)']; %     

 
		
% 		Part1_1=k20-k7;
% 		Part1_2=k3-k7;
% 		Part1_3=k4-k7;
%         Part2_1=k12-k1;
% 		Part2_2=k10-k1;
% 		Part2_3=k8-k1;
%         Part3_1=k13-k2;
% 		Part3_2=k11-k2;
% 		Part3_3=k9-k2;
%         Part4_1=k18-k5;
% 		Part4_2=k16-k5;
% 		Part4_3=k14-k5;
%         Part5_1=k19-k6;
% 		Part5_2=k17-k6;
% 		Part5_3=k15-k6;        
% 		Part1_1V=[0 0 0;diff(Part1_1)];
% 		Part1_2V=[0 0 0;diff(Part1_2)];
% 		Part1_3V=[0 0 0;diff(Part1_3)];
%         Part2_1V=[0 0 0;diff(Part2_1)];
% 		Part2_2V=[0 0 0;diff(Part2_2)];
% 		Part2_3V=[0 0 0;diff(Part2_3)];
%         Part3_1V=[0 0 0;diff(Part3_1)];
% 		Part3_2V=[0 0 0;diff(Part3_2)];
% 		Part3_3V=[0 0 0;diff(Part3_3)];
%         Part4_1V=[0 0 0;diff(Part4_1)];
% 		Part4_2V=[0 0 0;diff(Part4_2)];
% 		Part4_3V=[0 0 0;diff(Part4_3)];
%         Part5_1V=[0 0 0;diff(Part5_1)];
% 		Part5_2V=[0 0 0;diff(Part5_2)];
% 		Part5_3V=[0 0 0;diff(Part5_3)];		
%         
%         
%         E=[Part1_1';Part1_2';Part1_3';Part1_1V';Part1_2V';Part1_3V';A_AngXYZ(Part1_1)';A_AngXYZ(Part1_2)';A_AngXYZ(Part1_3)';...
%            Part2_1';Part2_2';Part2_3';Part2_1V';Part2_2V';Part2_3V';A_AngXYZ(Part2_1)';A_AngXYZ(Part2_2)';A_AngXYZ(Part2_3)';...
%            Part3_1';Part3_2';Part3_3';Part3_1V';Part3_2V';Part3_3V';A_AngXYZ(Part3_1)';A_AngXYZ(Part3_2)';A_AngXYZ(Part3_3)';...
%            Part4_1';Part4_2';Part4_3';Part4_1V';Part4_2V';Part4_3V';A_AngXYZ(Part4_1)';A_AngXYZ(Part4_2)';A_AngXYZ(Part4_3)';...
%            Part5_1';Part5_2';Part5_3';Part5_1V';Part5_2V';Part5_3V';A_AngXYZ(Part5_1)';A_AngXYZ(Part5_2)';A_AngXYZ(Part5_3)']; % 
%          E=[Part1_1';Part1_2';Part1_3';...
% 		   Part2_1';Part2_2';Part2_3';...
% 		   Part3_1';Part3_2';Part3_3';...
% 		   Part4_1';Part4_2';Part4_3';...
% 		   Part5_1';Part5_2';Part5_3'];	%0.72	       
%         E=[Part1_1';Part1_2';Part1_3';Part1_1V';Part1_2V';Part1_3V';...
% 		   Part2_1';Part2_2';Part2_3';Part2_1V';Part2_2V';Part2_3V';...
% 		   Part3_1';Part3_2';Part3_3';Part3_1V';Part3_2V';Part3_3V';...
% 		   Part4_1';Part4_2';Part4_3';Part4_1V';Part4_2V';Part4_3V';...
% 		   Part5_1';Part5_2';Part5_3';Part5_1V';Part5_2V';Part5_3V']; %0.76		
		
%       E=[Part1_1';Part1_2';Part1_3';Ay_Gradient(Part1_1)';Ay_Gradient(Part1_2)';Ay_Gradient(Part1_3)';...
% 		   Part2_1';Part2_2';Part2_3';Ay_Gradient(Part2_1)';Ay_Gradient(Part2_2)';Ay_Gradient(Part2_3)';...
% 		   Part3_1';Part3_2';Part3_3';Ay_Gradient(Part3_1)';Ay_Gradient(Part3_2)';Ay_Gradient(Part3_3)';...
% 		   Part4_1';Part4_2';Part4_3';Ay_Gradient(Part4_1)';Ay_Gradient(Part4_2)';Ay_Gradient(Part4_3)';...
% 		   Part5_1';Part5_2';Part5_3';Ay_Gradient(Part5_1)';Ay_Gradient(Part5_2)';Ay_Gradient(Part5_3)']; %0.77			
% 		
% 	      E=[Part1_1';Part1_2';Part1_3';Ay_Gradient(Part1_1)';Ay_Gradient(Part1_2)';Ay_Gradient(Part1_3)';...
%               Part1_1V';Part1_2V';Part1_3V';...
% 		   Part2_1';Part2_2';Part2_3';Ay_Gradient(Part2_1)';Ay_Gradient(Part2_2)';Ay_Gradient(Part2_3)';...
%            Part2_1V';Part2_2V';Part2_3V';...
% 		   Part3_1';Part3_2';Part3_3';Ay_Gradient(Part3_1)';Ay_Gradient(Part3_2)';Ay_Gradient(Part3_3)';...
%            Part3_1V';Part3_2V';Part3_3V';...
% 		   Part4_1';Part4_2';Part4_3';Ay_Gradient(Part4_1)';Ay_Gradient(Part4_2)';Ay_Gradient(Part4_3)';...
%            Part4_1V';Part4_2V';Part4_3V';...
% 		   Part5_1';Part5_2';Part5_3';Ay_Gradient(Part5_1)';Ay_Gradient(Part5_2)';Ay_Gradient(Part5_3)';...
%            Part5_1V';Part5_2V';Part5_3V']; 	%0.77
	
 		
% 		Part1_1=k20-k7;
% 		Part1_2=k3-k7;
% 		Part1_3=k4-k7;
%         Part2_1=k12-k7;
% 		Part2_2=k10-k7;
% 		Part2_3=k8-k7;
%         Part3_1=k13-k7;
% 		Part3_2=k11-k7;
% 		Part3_3=k9-k7;
%         Part4_1=k18-k7;
% 		Part4_2=k16-k7;
% 		Part4_3=k14-k7;
%         Part5_1=k19-k7;
% 		Part5_2=k17-k7;
% 		Part5_3=k15-k7;        
% 		Part1_1V=[0 0 0;diff(Part1_1)];
% 		Part1_2V=[0 0 0;diff(Part1_2)];
% 		Part1_3V=[0 0 0;diff(Part1_3)];
%         Part2_1V=[0 0 0;diff(Part2_1)];
% 		Part2_2V=[0 0 0;diff(Part2_2)];
% 		Part2_3V=[0 0 0;diff(Part2_3)];
%         Part3_1V=[0 0 0;diff(Part3_1)];
% 		Part3_2V=[0 0 0;diff(Part3_2)];
% 		Part3_3V=[0 0 0;diff(Part3_3)];
%         Part4_1V=[0 0 0;diff(Part4_1)];
% 		Part4_2V=[0 0 0;diff(Part4_2)];
% 		Part4_3V=[0 0 0;diff(Part4_3)];
%         Part5_1V=[0 0 0;diff(Part5_1)];
% 		Part5_2V=[0 0 0;diff(Part5_2)];
% 		Part5_3V=[0 0 0;diff(Part5_3)];		       
%         E=[Part1_1';Part1_2';Part1_3';Part1_1V';Part1_2V';Part1_3V';...
% 		   Part2_1';Part2_2';Part2_3';Part2_1V';Part2_2V';Part2_3V';...
% 		   Part3_1';Part3_2';Part3_3';Part3_1V';Part3_2V';Part3_3V';...
% 		   Part4_1';Part4_2';Part4_3';Part4_1V';Part4_2V';Part4_3V';...
% 		   Part5_1';Part5_2';Part5_3';Part5_1V';Part5_2V';Part5_3V']; %0.76	
       
       
       
E(isinf(E))=0;
E(isnan(E))=0;
 
        Ebag{j,1}=E;
   
 clearvars E

    end
    
    Features{i}=Ebag;
    clearvars Ebag
     
end


end