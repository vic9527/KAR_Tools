
% ����ƽ̨��Mac OSX��MATLAB R2014b
% ¼��¼2����
Time = 2;

% �������ѧ��
Id = '14307130345';

% ������¼�ĵ�����
Word = '����_2';

FS = 8000;
nBits = 16;
recObj = audiorecorder(FS, nBits, 1);
disp('Start speaking.')
recordblocking(recObj, Time);
disp('End of Recording.');

myRecording = getaudiodata(recObj);

filename = strcat(Id, '_');
filename = strcat(filename, Word);
filename = strcat(filename, '_');
filename = strcat(filename, datestr(now, 30));
filename = strcat(filename, '.wav');
filename = strcat('more_data/',filename);
audiowrite(filename, myRecording, FS)
