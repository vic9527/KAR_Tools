function [YPred, YAcc]=KAR_LSTM(X,Y,XTest,YTest,FVdim,Hunit,Nclass,drops,batchs,iters)

%% ����

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

%ת��Ϊ�����ʽ
Y = categorical(Y);
YTest = categorical(YTest);

%ѵ���������г�������
numObservations = numel(X);
for i=1:numObservations
    sequence = X{i};
    sequenceLengths(i) = size(sequence,2);
end
[sequenceLengths,idx] = sort(sequenceLengths);
X = X(idx);
Y = Y(idx);

%% ���ó�����
inputSize = FVdim;%����ά��
outputSize = Hunit;%���������Ԫ��
outputMode = 'last';
numClasses = Nclass;%������
maxEpochs = iters;
miniBatchSize = batchs;
shuffle = 'never';
LRDrop=drops;

%% LSTM����
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


%���Լ������г�������
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

YPred(idx)=YPred; %���ԭ˳��

YPred=double(YPred);%ת��Ϊԭʼ��ʽ

end %�Ǳ����