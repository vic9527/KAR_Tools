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
%         E1=(k20-k7)/lenNorm;
%         E2=(k12-k1)/lenNorm;
%         E3=(k13-k2)/lenNorm;
%         E4=(k18-k5)/lenNorm;
%         E5=(k19-k6)/lenNorm;
        E1=(k20-k7);
        E2=(k12-k1);
        E3=(k13-k2);
        E4=(k18-k5);
        E5=(k19-k6);
        T1=A_offset1(k20);
        T2=A_offset1(k12);
        T3=A_offset1(k13);
        T4=A_offset1(k18);
        T5=A_offset1(k19);
      E=[T1';...
           T2';...
           T3';...
           T4';...
           T5']; %    
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
        E1V=[0 0 0;diff(E1,1,1)];
        E2V=[0 0 0;diff(E2,1,1)];
        E3V=[0 0 0;diff(E3,1,1)];a
        E5V=[0 0 0;diff(E5,1,1)];
        E1A=[0 0 0;0 0 0;diff(E1,2,1)];
        E2A=[0 0 0;0 0 0;diff(E2,2,1)];
        E3A=[0 0 0;0 0 0;diff(E3,2,1)];
        E4A=[0 0 0;0 0 0;diff(E4,2,1)];
        E5A=[0 0 0;0 0 0;diff(E5,2,1)];        
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
%       E=[E1';T1';...
%            E2';T2';...
%            E3';T3';...
%            E4';T4';...
%            E5';T5']; %       

 
		
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
	
        


 
        Ebag{j,1}=E;
   
 clearvars E

    end
    
    Features{i}=Ebag;
    clearvars Ebag
     
end


end