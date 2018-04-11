function Features = RPRO_Cell(Data)
%clearvars -except Data
% Data=TR_data;

for i=1:size(Data,2)
    SD=Data{i}; %Single Data
    for j=1:size(SD,1)
        A=[SD{j,1}]';
        for ii=1:20
            eval(['k',num2str(ii),'=','A(:,ii*3-2:ii*3)',';']);
        end
        

        %% 双间距离标准化
        StdLen=k2-k1;
        lenNorm=mean(sqrt(sum(StdLen.^2,2)));

        %% 五终端相对坐标
        E1=(k20-k7)/lenNorm;
        E2=(k12-k1)/lenNorm;
        E3=(k13-k2)/lenNorm;
        E4=(k18-k5)/lenNorm;
        E5=(k19-k6)/lenNorm;

        %% 计算五终端随时间流与前一帧的距离
        E1V=[0 0 0;diff(E1)];
        E2V=[0 0 0;diff(E2)];
        E3V=[0 0 0;diff(E3)];
        E4V=[0 0 0;diff(E4)];
        E5V=[0 0 0;diff(E5)];
        
        E=[E1';E1V';E2';E2V';E3';E3V';E4';E4V';E5';E5V'];

clearvars A StdLen lenNorm ii E1 E2 E3 E4 E5 E1V E2V E3V E4V E5V  k1 k2 k3 k4 k5 k6 k7 k8 k9 k10 k11 k12 k13 k14 k15 k16 k17 k18 k19 k20  
 
        Ebag{j,1}=E;
   
 clearvars E

    end
    
    Features{i}=Ebag;
    clearvars Ebag
     
end


end