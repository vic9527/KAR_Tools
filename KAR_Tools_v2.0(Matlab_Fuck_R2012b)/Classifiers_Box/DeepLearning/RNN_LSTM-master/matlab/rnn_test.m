clear;clc
load('All_Actions.mat')
%% Preparation for HMM
training_number = length(All_Actions);
all_labels = zeros(training_number, 1);

% get labels
for i = 1:training_number
    all_labels(i) = All_Actions(i).label;
end

labels = unique(all_labels);
label_number = size(labels, 1);

%% Training models
for i = 1:label_number
    % each element in cell array is a sequence with dimensionality of 
    % 60 * T (T is the length of sequence)
    Train_Data = cell(1, 1);    
    label = labels(i);
    
    %% get all the training data with the same label
    for j = 1 : training_number
        if All_Actions(j).label == label
            len = size(Train_Data, 2);
            if isempty(Train_Data{len})
%                     Train_Data{len} = TR_Actions(j).Observations;
%                 Train_Data{len} = TR_Actions(j).Observations(7:12,:);
                Train_Data{len} = All_Actions(j).Feature2nd(1:end,:);%修改区域
            else
%                 Train_Data{len + 1} = TR_Actions(j).Observations;
%                  Train_Data{len + 1} = TR_Actions(j).Observations(7:12,:);
                Train_Data{len + 1} = All_Actions(j).Feature2nd(1:end,:);%修改区域
            end            
        end
    end
    
    Train_Data_number=size(Train_Data,2);
    Train_Data_Mat=[];
    for j=1:Train_Data_number
        Train_Data_Mat=[Train_Data_Mat,Train_Data{j}];
    end
    
     Train_Data_MatLabel=i.* [ones(size(Train_Data_Mat,2), 1)]';
     
     Train_Data_Bag{i}=Train_Data_Mat;
     Train_Data_Label{i}=Train_Data_MatLabel;

end

All_Train_Data=[];
All_Train_Label=[];
    for j=1:label_number
        All_Train_Data=[All_Train_Data,Train_Data_Bag{j}];
        All_Train_Label=[All_Train_Label,Train_Data_Label{j}];
    end

I = eye(max(All_Train_Label));
yData = I(:,All_Train_Label);
xData0 = All_Train_Data(1,:);

yyy1=1;
xData=zeros(20,size(yData,2));
for jjj=1:20

    yyy2=size(find(yData(jjj,:)==1),2);
    xData(jjj,yyy1:yyy1+yyy2-1)=xData0(1,yyy1:yyy1+yyy2-1);
    yyy1=yyy1+yyy2;
    
end


