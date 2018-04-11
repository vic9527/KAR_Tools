function [YPred, YAcc]=KAR_LSTM(X,Y,XTest,YTest,FVdim,Hunit,Nclass,drops,batchs,iters)

%% 调试

% X=TR_Actions_data{1};
% Y=TR_Actions_label{1};
% XTest=TE_Actions_data{1};
% YTest=TE_Actions_label{1}
% FVdim=60;
% Hunit=100;
% Nclass=20;
% drops=5;
% batchs=5;
% iters=1;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%转化为分类格式
Y = categorical(Y);
YTest = categorical(YTest);

%训练集按序列长短排序
numObservations = numel(X);
for i=1:numObservations
    sequence = X{i};
    sequenceLengths(i) = size(sequence,2);
end
[sequenceLengths,idx] = sort(sequenceLengths);
X = X(idx);
Y = Y(idx);

%% 设置超参数
inputSize = FVdim;%输入维数
outputSize = Hunit;%隐层输出单元数
outputMode = 'last';
numClasses = Nclass;%输出类别
maxEpochs = iters;
miniBatchSize = batchs;
shuffle = 'never';
LRDrop=drops;

%% LSTM设置
layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(outputSize,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

options = trainingOptions('sgdm', ...
    'LearnRateDropPeriod', LRDrop, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle', shuffle);

net = trainNetwork(X,Y,layers,options);


%测试集按序列长短排序
numObservationsTest = numel(XTest);
for i=1:numObservationsTest
    sequence = XTest{i};
    sequenceLengthsTest(i) = size(sequence,2);
end
[sequenceLengthsTest,idx] = sort(sequenceLengthsTest);
XTest = XTest(idx);
YTest = YTest(idx);
% YTest(idx) = YTest;

miniBatchSize = batchs;
YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize);

YAcc = sum(YPred == YTest)./numel(YTest)

YPred(idx)=YPred; %变回原顺序

YPred=double(YPred);%转化为原始格式

end %非必须的