%include voicebox
addpath(genpath(pwd));

%������ǩ��Ӧmap
global labelmap;
containers.Map('KeyType','char', 'ValueType','any');
labelmap = containers.Map({'����','����','�ź�','����','ʶ��','����','����','�Ϻ�','����','����',...
'speech','voice','sound','happy','lucky','file','open','close','start','stop',...
},{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20});

global translabel;
containers.Map('KeyType','char', 'ValueType','any');
translabel = containers.Map({1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20},...
    {'����','����','�ź�','����','ʶ��','����','����','�Ϻ�','����','����',...
'speech','voice','sound','happy','lucky','file','open','close','start','stop',...
});

global avg_time;
avg_time = load('/Users/mac/Desktop/pj/coefficient/female_avg_time.mat');
avg_time = avg_time.female_avg_time;

% global encode;
% encode1 = (1.2:-0.1:0.1)';
% encode = [encode1;encode1];
%��ȡ��������mat
%get_character('/Users/mac/Desktop/pj/more_data/');

%��ȡһ��wav��mfcc
% file = '/Users/mac/Desktop/13307130230/13307130230_�Ϻ�_19.wav';
% % file = '/Users/mac/Desktop/pj/all/.wav'; 
% [sample,fs] = audioread(file);
% after_find = find_speech(sample,fs);
% after_mfcc = mfcc(after_find,fs);
% sizedata = size(after_mfcc);
% if sizedata(1) > 90
%     percent = sizedata(1) / 90 ;
%     after_mfcc = after_mfcc(1:percent:end,:);
% else
%     after_mfcc(90,24) = 0;
% end

%kmeans����
%[center] = kmeans(1, 20, 100);
% [sample,fs] = audioread('/Users/mac/Desktop/pj/test/14307130345/14307130345_Speech_07.wav');
% after_find = find_speech(sample,fs);
% after_mfcc = mfcc(after_find,fs);
% sp2 = after_mfcc;
% sp1 = load_data('/Users/mac/Desktop/pj/trainmat/13300160096_Speech_16.mat');
%sp2 = load_data('/Users/mac/Desktop/pj/trainmat/13307130251_����_19.mat');

%dist = dtw(sp1,sp2);

%knn ���� ǰ20��Լ50%������ȷ,Ч���ȽϺõĴﵽ80%������ȷ
% tic;
% [sample,fs] = audioread('/Users/mac/Desktop/pj/test/14307130092/14307130092_Sound_18.wav');
% after_find = find_speech(sample,fs);
%  after_mfcc = mfcc(after_find,fs);
%   [label,distance] = knn(after_mfcc,20);
%   fprintf('%s \n',label);
%  toc;
 

%kmeans ����
% global center;
% center = load('/Users/mac/Desktop/pj/coefficient/acc_0.1_center.mat');
% center = center.center;
% [origin,predict] = test_kmeans();
% accuracy = zeros(1,20);
% accuracy(1,:) = predict(1,:)./origin(1,:);