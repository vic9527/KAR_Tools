function Features = extractFeatures(file)

%% extract features from input file
A=load(file);
     
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Asize=size(A,1);

%% 双间距离标准化
StdLen=k2-k1;
lenNorm=mean(sqrt(sum(StdLen.^2,2)));

%% 五部分重心相对坐标
Part1_CV=(k3+k4+k7)/3-k7;
Part2_CV=(k1+k8+k10)/3-k1;
Part3_CV=(k2+k9+k11)/3-k2;
Part4_CV=(k5+k14+k16)/3-k5;
Part5_CV=(k6+k15+k17)/3-k6;
Part1_C=Part1_CV./lenNorm;
Part2_C=Part2_CV./lenNorm;
Part3_C=Part3_CV./lenNorm;
Part4_C=Part4_CV./lenNorm;
Part5_C=Part5_CV./lenNorm;



%% 计算五部分重心随时间流与初始帧的距离
for i = 2:Asize
    C1(i-1,:)=(Part1_C(i,:)-Part1_C(1,:)).^2;

    C2(i-1,:)=(Part2_C(i,:)-Part2_C(1,:)).^2;

    C3(i-1,:)=(Part3_C(i,:)-Part3_C(1,:)).^2;

    C4(i-1,:)=(Part4_C(i,:)-Part4_C(1,:)).^2;

    C5(i-1,:)=(Part5_C(i,:)-Part5_C(1,:)).^2;
end

C1=[0 0 0;C1];
C2=[0 0 0;C2];
C3=[0 0 0;C3];
C4=[0 0 0;C4];
C5=[0 0 0;C5];

C=[C1,C2,C3,C4,C5];



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



Features=[C';E1';E1V';E2';E2V';E3';E3V';E4';E4V';E5';E5V'];







