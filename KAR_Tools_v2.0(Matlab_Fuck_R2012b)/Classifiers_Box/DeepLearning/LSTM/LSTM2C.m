function YPred=LSTM(X,Y,XTest,YTest)

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

miniBatchSize = 20;
miniBatchLocations = miniBatchSize+1:miniBatchSize:numObservations;
XLocations = repmat(miniBatchLocations,[2 1]);
YLocations = repmat([0;30],[1 9]);

inputSize = 30;%输入维数
outputSize = 10;
outputMode = 'last';
numClasses = 20;%输出类别

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(outputSize,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]
maxEpochs = 1000;
miniBatchSize = 20;
shuffle = 'never';

options = trainingOptions('sgdm', ...
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

miniBatchSize = 20;
YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize);

acc = sum(YPred == YTest)./numel(YTest)

YPred=double(YPred);
YPred(idx)=YPred;%变回原顺序
end %非必须的