function Features = extractFeatures2(file)
% extract features from input file

% % % %% Reshape data 
% % % fp = fopen(file);
% % % if fp > 0
% % %     items = fscanf(fp, '%f');
% % %     fclose(fp);
% % % end

% % % % % % % % % % len = size(items, 1) / 4;   % number of the total joint points
% % % % % % % % % % Joint_Matrix = reshape(items, [4 len]);
% % % % % % % % % % Joint_Matrix = Joint_Matrix(1:3,:); % 1st row: X, 2nd row: Z, 3rd row: Y
% % % % % % % % % % 
% % % % % % % % % % % adjust the coordinates
% % % % % % % % % % Joint_Matrix(2,:) = 400 - Joint_Matrix(2,:);
% % % % % % % % % % Joint_Matrix(3,:) = Joint_Matrix(3,:) / 4;
% % % % % % % % % % 
% % % % % % % % % % frame_number = size(Joint_Matrix, 2) / 20;
% % % % % % % % % % Frames = reshape(Joint_Matrix, [3 20 frame_number]);
% % % % % % % % % % 
% % % % % % % % % % %% Feature extraction
% % % % % % % % % % Features = zeros(60, frame_number);
% % % % % % % % % % for i = 1:frame_number
% % % % % % % % % %     Single_Frame = Frames(:, :, i);
% % % % % % % % % %     Single_Frame = Single_Frame';
% % % % % % % % % %     
% % % % % % % % % %     % treat hip center coordiante as the relative coordinate
% % % % % % % % % %     relative_coordinate = Single_Frame(7,:);    
% % % % % % % % % %     Single_Frame_Tmp = Single_Frame;
% % % % % % % % % %     Single_Frame_Tmp(:, 1) = Single_Frame(:, 1) - relative_coordinate(1);
% % % % % % % % % %     Single_Frame_Tmp(:, 2) = Single_Frame(:, 2) - relative_coordinate(2);
% % % % % % % % % %     Single_Frame_Tmp(:, 3) = Single_Frame(:, 3) - relative_coordinate(3);
% % % % % % % % % %     
% % % % % % % % % %     feature = reshape(Single_Frame_Tmp, [60 1]);
% % % % % % % % % %     Features(:, i) = feature;
% % % % % % % % % % end
  
 A=load(file);
     
A(:,4)=[];
[mm,nn]=size(A);
A=reshape(A',nn*20,mm/20)'; 

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

Asize=size(A,1);



% Part1_CV=(k3+k4+k7)/3-k7;
% Part2_CV=(k1+k8+k10)/3-k1;
% Part3_CV=(k2+k9+k11)/3-k2;
% Part4_CV=(k5+k14+k16)/3-k5;
% Part5_CV=(k6+k15+k17)/3-k6;
% 
% Part1_C=Part1_CV./[sqrt(sum(Part1_CV.^2,2)),sqrt(sum(Part1_CV.^2,2)),sqrt(sum(Part1_CV.^2,2))];
% Part2_C=Part2_CV./[sqrt(sum(Part2_CV.^2,2)),sqrt(sum(Part2_CV.^2,2)),sqrt(sum(Part2_CV.^2,2))];
% Part3_C=Part3_CV./[sqrt(sum(Part3_CV.^2,2)),sqrt(sum(Part3_CV.^2,2)),sqrt(sum(Part3_CV.^2,2))];
% Part4_C=Part4_CV./[sqrt(sum(Part4_CV.^2,2)),sqrt(sum(Part4_CV.^2,2)),sqrt(sum(Part4_CV.^2,2))];
% Part5_C=Part5_CV./[sqrt(sum(Part5_CV.^2,2)),sqrt(sum(Part5_CV.^2,2)),sqrt(sum(Part5_CV.^2,2))];
% 
% TP1=Part1_C;
% TP2=Part2_C;
% TP3=Part3_C;
% TP4=Part4_C;
% TP5=Part5_C;



%五终端相对坐标
TP_len=k2-k1;
TP_lenNorm=mean(sqrt(sum(TP_len.^2,2)));

TP1=(k20-k7)/TP_lenNorm;
TP2=(k12-k1)/TP_lenNorm;
TP3=(k13-k2)/TP_lenNorm;
TP4=(k18-k5)/TP_lenNorm;
TP5=(k19-k6)/TP_lenNorm;


Part1_CV=(k3+k4+k7)/3-k7;
Part2_CV=(k1+k8+k10)/3-k1;
Part3_CV=(k2+k9+k11)/3-k2;
Part4_CV=(k5+k14+k16)/3-k5;
Part5_CV=(k6+k15+k17)/3-k6;
Part1_C=Part1_CV./TP_lenNorm;
Part2_C=Part2_CV./TP_lenNorm;
Part3_C=Part3_CV./TP_lenNorm;
Part4_C=Part4_CV./TP_lenNorm;
Part5_C=Part5_CV./TP_lenNorm;

% 效果更差
% TP1=(k20-k7)/TP_lenNorm;
% TP2=(k10-k1)/TP_lenNorm;
% TP3=(k11-k2)/TP_lenNorm;
% TP4=(k16-k5)/TP_lenNorm;
% TP5=(k17-k6)/TP_lenNorm;

% for i = 2:Asize
%     TP1_V(i-1,:)=(TP1(i,:)-TP1(1,:)).^2;
% 
%     TP2_V(i-1,:)=(TP2(i,:)-TP2(1,:)).^2;
% 
%     TP3_V(i-1,:)=(TP3(i,:)-TP3(1,:)).^2;
% 
%     TP4_V(i-1,:)=(TP4(i,:)-TP4(1,:)).^2;
% 
%     TP5_V(i-1,:)=(TP5(i,:)-TP5(1,:)).^2;
% end

for i = 2:Asize
    TP1_V(i-1,:)=(Part1_C(i,:)-Part1_C(1,:)).^2;

    TP2_V(i-1,:)=(Part2_C(i,:)-Part2_C(1,:)).^2;

    TP3_V(i-1,:)=(Part3_C(i,:)-Part3_C(1,:)).^2;

    TP4_V(i-1,:)=(Part4_C(i,:)-Part4_C(1,:)).^2;

    TP5_V(i-1,:)=(Part5_C(i,:)-Part5_C(1,:)).^2;
end


TP1_V=[0 0 0;TP1_V];
TP2_V=[0 0 0;TP2_V];
TP3_V=[0 0 0;TP3_V];
TP4_V=[0 0 0;TP4_V];
TP5_V=[0 0 0;TP5_V];

TP_V=[TP1_V,TP2_V,TP3_V,TP4_V,TP5_V];



TP1_D=[0 0 0;diff(TP1)];
TP2_D=[0 0 0;diff(TP2)];
TP3_D=[0 0 0;diff(TP3)];
TP4_D=[0 0 0;diff(TP4)];
TP5_D=[0 0 0;diff(TP5)];



% EWP1=(k11-k2)/TP_lenNorm;
% EWP2=(k9-k2)/TP_lenNorm;


Features=[TP_V';TP1';TP1_D';TP2';TP2_D';TP3';TP3_D';TP4';TP4_D';TP5';TP5_D'];
% Features=[TP1';TP2';TP3';TP4';TP5'];
% Features=[TP1_D';TP2_D';TP3_D';TP4_D';TP5_D'];






