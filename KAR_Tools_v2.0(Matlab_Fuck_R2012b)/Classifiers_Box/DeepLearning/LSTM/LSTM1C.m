function YPred=LSTM1C(X,Y,XTest,YTest)

Y = categorical(Y);
YTest = categorical(YTest);

numObservations = numel(X);
for i=1:numObservations
    sequence = X{i};
    sequenceLengths(i) = size(sequence,2);
end

[sequenceLengths,idx] = sort(sequenceLengths);
X = X(idx);
Y = Y(idx);

inputSize = 6;%输入维数
outputSize = 50;
outputMode = 'last';
numClasses = 11;%输出类别

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(outputSize,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]
maxEpochs = 300;
miniBatchSize = 1;%2/3
shuffle = 'never';

options = trainingOptions('sgdm', ...
    'LearnRateDropPeriod', 3, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle', shuffle);

net = trainNetwork(X,Y,layers,options);

% load JapaneseVowelsTest

numObservationsTest = numel(XTest);
for i=1:numObservationsTest
    sequence = XTest{i};
    sequenceLengthsTest(i) = size(sequence,2);
end
[sequenceLengthsTest,idx] = sort(sequenceLengthsTest);
XTest = XTest(idx);
YTest = YTest(idx);

miniBatchSize = 1;%3/3
YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize);

acc = sum(YPred == YTest)./numel(YTest)

YPred(idx)=YPred; %变回原顺序

YPred=double(YPred);

end %非必须的