function Features = P5C_MeanVar_Cell(Data)
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
        

        %% 双间距离标准化
        StdLen=k2-k1;
        lenNorm=mean(sqrt(sum(StdLen.^2,2)));

        %% 五部分重心相对坐标
        %Part1_CV=(k3+k4+k7)/3-k7;
        %Part2_CV=(k1+k8+k10)/3-k1;
        %Part3_CV=(k2+k9+k11)/3-k2;
        %Part4_CV=(k5+k14+k16)/3-k5;
        %Part5_CV=(k6+k15+k17)/3-k6;
		%Part1_CV=(k3+k4+k7+k20)/4-k7;
        %Part2_CV=(k1+k8+k10+k12)/4-k1;
        %Part3_CV=(k2+k9+k11+k13)/4-k2; 
        %Part4_CV=(k5+k14+k16+k18)/4-k5;
        %Part5_CV=(k6+k15+k17+k19)/4-k6;
		Part1_CV=(k3+k4+k7+k20)/4;
        Part2_CV=(k1+k8+k10+k12)/4;
        Part3_CV=(k2+k9+k11+k13)/4; 
        Part4_CV=(k5+k14+k16+k18)/4;
        Part5_CV=(k6+k15+k17+k19)/4;
        Part1_C=Part1_CV./lenNorm;
        Part2_C=Part2_CV./lenNorm;
        Part3_C=Part3_CV./lenNorm;
        Part4_C=Part4_CV./lenNorm;
        Part5_C=Part5_CV./lenNorm;

clearvars StdLen lenNorm Part5_CV  Part4_CV Part3_CV Part2_CV Part1_CV k1 k2 k3 k4 k5 k6 k7 k8 k9 k10 k11 k12 k13 k14 k15 k16 k17 k18 k19 k20  

        %% 计算五部分重心随时间流与初始帧的距离
        for jj = 2:size(A,1)
            C1(jj-1,:)=(Part1_C(jj,:)-Part1_C(1,:)).^2;

            C2(jj-1,:)=(Part2_C(jj,:)-Part2_C(1,:)).^2;

            C3(jj-1,:)=(Part3_C(jj,:)-Part3_C(1,:)).^2;

            C4(jj-1,:)=(Part4_C(jj,:)-Part4_C(1,:)).^2;

            C5(jj-1,:)=(Part5_C(jj,:)-Part5_C(1,:)).^2;
        end


        C=[C1,C2,C3,C4,C5];

clearvars Part1_C Part2_C Part3_C Part4_C Part5_C ii jj C1 C2 C3 C4 C5 A



        
        
        DM{i}(j,:)=mean(C);
        DV{i}(j,:)=var(C);
   
clearvars C

    end
    
    DataMV{i}=[DM{i},DV{i}];
    
end
            Features=DataMV;

end