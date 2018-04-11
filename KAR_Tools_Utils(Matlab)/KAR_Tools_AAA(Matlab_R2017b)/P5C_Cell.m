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
%             k1=mapminmax(k1',-1,1)';
%             k2=mapminmax(k2',-1,1)';
%             k3=mapminmax(k3',-1,1)';
%             k4=mapminmax(k4',-1,1)';
%             k5=mapminmax(k5',-1,1)';
%             k6=mapminmax(k6',-1,1)';
%             k7=mapminmax(k7',-1,1)';
%             k8=mapminmax(k8',-1,1)';
%             k9=mapminmax(k9',-1,1)';
%             k10=mapminmax(k10',-1,1)';
%             k11=mapminmax(k11',-1,1)';
%             k12=mapminmax(k12',-1,1)';
%             k13=mapminmax(k13',-1,1)';
%             k14=mapminmax(k14',-1,1)';
%             k15=mapminmax(k15',-1,1)';
%             k16=mapminmax(k16',-1,1)';
%             k17=mapminmax(k17',-1,1)';
%             k18=mapminmax(k18',-1,1)'; 
%             k19=mapminmax(k19',-1,1)';
%             k20=mapminmax(k20',-1,1)';
            %% 对象：五部分重心（后三点最重要）
        % Part1_C=(k3+k4+k7)/3-k7;
        %Part2_C=(k8+k10+k1)/3-k1;
        % Part3_C=(k9+k11+k2)/3-k2; 
        %Part4_C=(k14+k16+k5)/3-k5;
        % Part5_C=(k15+k17+k6)/3-k6;
        %Part1_C=(k3+k4+k7+k20)/4-k7;
        %Part2_C=(k1+k8+k10+k12)/4-k1;
        %Part3_C=(k2+k9+k11+k13)/4-k2; 
        %Part4_C=(k5+k14+k16+k18)/4-k5;
        %Part5_C=(k6+k15+k17+k19)/4-k6;
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
%         Part1_T=A_norm(A_offset1(Part1_C));
%         Part2_T=A_norm(A_offset1(Part2_C));
%         Part3_T=A_norm(A_offset1(Part3_C));
%         Part4_T=A_norm(A_offset1(Part4_C));
%         Part5_T=A_norm(A_offset1(Part5_C));
        Part1_T_FFT=abs(fft(Part1_T));
        Part2_T_FFT=abs(fft(Part2_T));
        Part3_T_FFT=abs(fft(Part3_T));
        Part4_T_FFT=abs(fft(Part4_T));
        Part5_T_FFT=abs(fft(Part5_T));
               Part1_T_DC=Part1_T_FFT(1,:);
               Part2_T_DC=Part2_T_FFT(1,:);
               Part3_T_DC=Part3_T_FFT(1,:);
               Part4_T_DC=Part4_T_FFT(1,:);
               Part5_T_DC=Part5_T_FFT(1,:);
               Part1_T_energy=mean(Part1_T_FFT(2:end,:).^2);
               Part2_T_energy=mean(Part2_T_FFT(2:end,:).^2);
               Part3_T_energy=mean(Part3_T_FFT(2:end,:).^2);
               Part4_T_energy=mean(Part4_T_FFT(2:end,:).^2);
               Part5_T_energy=mean(Part5_T_FFT(2:end,:).^2);
               
        Part1{i}(j,:)=[mean(Part1_T),var(Part1_T),skewness(Part1_T),kurtosis(Part1_T)...
            ];
        Part2{i}(j,:)=[mean(Part2_T),var(Part2_T),skewness(Part2_T),kurtosis(Part2_T)...
            ];
        Part3{i}(j,:)=[mean(Part3_T),var(Part3_T),skewness(Part3_T),kurtosis(Part3_T)...
            ];
        Part4{i}(j,:)=[mean(Part4_T),var(Part4_T),skewness(Part4_T),kurtosis(Part4_T)...
            ];
        Part5{i}(j,:)=[mean(Part5_T),var(Part5_T),skewness(Part5_T),kurtosis(Part5_T)...
            ];
               
               
%         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C),skewness(Part1_C),kurtosis(Part1_C),...
%                        mean(Part1_T),var(Part1_T),skewness(Part1_T),kurtosis(Part1_T)];
%         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C),skewness(Part2_C),kurtosis(Part2_C),...
%                        mean(Part2_T),var(Part2_T),skewness(Part2_T),kurtosis(Part2_T)];
%         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C),skewness(Part3_C),kurtosis(Part3_C),...
%                        mean(Part3_T),var(Part3_T),skewness(Part3_T),kurtosis(Part3_T)];
%         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C),skewness(Part4_C),kurtosis(Part4_C),...
%                        mean(Part4_T),var(Part4_T),skewness(Part4_T),kurtosis(Part4_T)];
%         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C),skewness(Part5_C),kurtosis(Part5_C),...
%                        mean(Part5_T),var(Part5_T),skewness(Part5_T),kurtosis(Part5_T)];

% % %         Part1{i}(j,:)=[mean(Part1_T),var(Part1_T),Part1_T_DC,Part1_T_energy,skewness(Part1_T),kurtosis(Part1_T)...
% % %             ];
% % %         Part2{i}(j,:)=[mean(Part2_T),var(Part2_T),Part2_T_DC,Part2_T_energy,skewness(Part2_T),kurtosis(Part2_T)...
% % %             ];
% % %         Part3{i}(j,:)=[mean(Part3_T),var(Part3_T),Part3_T_DC,Part3_T_energy,skewness(Part3_T),kurtosis(Part3_T)...
% % %             ];
% % %         Part4{i}(j,:)=[mean(Part4_T),var(Part4_T),Part4_T_DC,Part4_T_energy,skewness(Part4_T),kurtosis(Part4_T)...
% % %             ];
% % %         Part5{i}(j,:)=[mean(Part5_T),var(Part5_T),Part5_T_DC,Part5_T_energy,skewness(Part5_T),kurtosis(Part5_T)...
% % %             ];
        
%         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C),max(Part1_C),min(Part1_C)];
%         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C),max(Part2_C),min(Part2_C)];
%         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C),max(Part3_C),min(Part3_C)];
%         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C),max(Part4_C),min(Part4_C)];
%         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C),max(Part5_C),min(Part5_C)];        

%         %mode:众数;Range=max-min; range(Part1_C)
%         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C),max(Part1_C),min(Part1_C), ...
%             max(Part1_C)-min(Part1_C),mode(Part1_C)];
%         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C),max(Part2_C),min(Part2_C), ...
%             max(Part2_C)-min(Part2_C),mode(Part2_C)];
%         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C),max(Part3_C),min(Part3_C), ...
%             max(Part3_C)-min(Part3_C),mode(Part3_C)];
%         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C),max(Part4_C),min(Part4_C), ...
%             max(Part4_C)-min(Part4_C),mode(Part4_C)];
%         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C),max(Part5_C),min(Part5_C), ...
%             max(Part5_C)-min(Part5_C),mode(Part5_C)];

%         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C), ...
%             max(Part1_C)-min(Part1_C),mode(Part1_C)];
%         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C), ...
%             max(Part2_C)-min(Part2_C),mode(Part2_C)];
%         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C), ...
%             max(Part3_C)-min(Part3_C),mode(Part3_C)];
%         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C), ...
%             max(Part4_C)-min(Part4_C),mode(Part4_C)];
%         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C), ...
%             max(Part5_C)-min(Part5_C),mode(Part5_C)];

%         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C), ...
%             max(Part1_C)-min(Part1_C)];
%         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C), ...
%             max(Part2_C)-min(Part2_C)];
%         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C), ...
%             max(Part3_C)-min(Part3_C)];
%         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C), ...
%             max(Part4_C)-min(Part4_C)];
%         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C), ...
%             max(Part5_C)-min(Part5_C)];

%         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C), ...
%             mode(Part1_C)];
%         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C), ...
%             mode(Part2_C)];
%         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C), ...
%             mode(Part3_C)];
%         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C), ...
%             mode(Part4_C)];
%         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C), ...
%             mode(Part5_C)];

%         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C), ...
%             A_MeanCrossingRate(Part1_C)];
%         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C), ...
%             A_MeanCrossingRate(Part2_C)];
%         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C), ...
%             A_MeanCrossingRate(Part3_C)];
%         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C), ...
%             A_MeanCrossingRate(Part4_C)];
%         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C), ...
%             A_MeanCrossingRate(Part5_C)];
        
% %         Part1_C_FFT=abs(fft(Part1_C));
% %         Part2_C_FFT=abs(fft(Part2_C));
% %         Part3_C_FFT=abs(fft(Part3_C));
% %         Part4_C_FFT=abs(fft(Part4_C));
% %         Part5_C_FFT=abs(fft(Part5_C));
% %                %   DC component
% %                Part1_C_DC=Part1_C_FFT(1,:);
% %                Part2_C_DC=Part2_C_FFT(1,:);
% %                Part3_C_DC=Part3_C_FFT(1,:);
% %                Part4_C_DC=Part4_C_FFT(1,:);
% %                Part5_C_DC=Part5_C_FFT(1,:);
% %                Part1_C_energy=mean(Part1_C_FFT(2:end,:).^2);
% %                Part2_C_energy=mean(Part2_C_FFT(2:end,:).^2);
% %                Part3_C_energy=mean(Part3_C_FFT(2:end,:).^2);
% %                Part4_C_energy=mean(Part4_C_FFT(2:end,:).^2);
% %                Part5_C_energy=mean(Part5_C_FFT(2:end,:).^2);
% %         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C), ...
% %             Part1_C_DC,Part1_C_energy,skewness(Part1_C),kurtosis(Part1_C),...
% %              A_MeanCrossingRate(Part1_C),mode(Part1_C),max(Part1_C)-min(Part1_C)];
% %         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C), ...
% %             Part2_C_DC,Part2_C_energy,skewness(Part2_C),kurtosis(Part2_C),...
% %              A_MeanCrossingRate(Part2_C),mode(Part2_C),max(Part2_C)-min(Part2_C)];
% %         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C), ...
% %             Part3_C_DC,Part3_C_energy,skewness(Part3_C),kurtosis(Part3_C),...
% %              A_MeanCrossingRate(Part3_C),mode(Part3_C),max(Part3_C)-min(Part3_C)];
% %         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C), ...
% %             Part4_C_DC,Part4_C_energy,skewness(Part4_C),kurtosis(Part4_C),...
% %              A_MeanCrossingRate(Part4_C),mode(Part4_C),max(Part4_C)-min(Part4_C)];
% %         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C), ...
% %             Part5_C_DC,Part5_C_energy,skewness(Part5_C),kurtosis(Part5_C),...
% %              A_MeanCrossingRate(Part5_C),mode(Part5_C),max(Part5_C)-min(Part5_C)];    
         
%         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C), ...
%             Part1_C_energy];
%         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C), ...
%             Part2_C_energy];
%         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C), ...
%             Part3_C_energy];
%         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C), ...
%             Part4_C_energy];
%         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C), ...
%             Part5_C_energy];      

% 求峰度用kurtosis;求偏度用skewness
%         Part1{i}(j,:)=[mean(Part1_C),var(Part1_C),skewness(Part1_C),kurtosis(Part1_C)];
%         Part2{i}(j,:)=[mean(Part2_C),var(Part2_C),skewness(Part2_C),kurtosis(Part2_C)];
%         Part3{i}(j,:)=[mean(Part3_C),var(Part3_C),skewness(Part3_C),kurtosis(Part3_C)];
%         Part4{i}(j,:)=[mean(Part4_C),var(Part4_C),skewness(Part4_C),kurtosis(Part4_C)];
%         Part5{i}(j,:)=[mean(Part5_C),var(Part5_C),skewness(Part5_C),kurtosis(Part5_C)];







        
    end
    
    DataMV{i}=[Part1{i},Part2{i},Part3{i},Part4{i},Part5{i}];
    
end
            Features=DataMV;

end