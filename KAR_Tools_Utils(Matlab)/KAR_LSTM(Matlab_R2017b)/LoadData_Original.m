
clear;clc;

%% load all data
data_dir=['..\\..\\KAR_DataSets\\MSRAction3DSkeletonReal3D\\MSRAction3D_547\\'];
data_info = dir(data_dir);
isfile = [data_info(:).isdir] ~= 1;
files_name = {data_info(isfile).name}';

DataSet = struct;

for i=1:length(files_name)

    fprintf([files_name{i},'...OK!\n']);

    file_name = files_name{i}; 
    file = [data_dir, files_name{i}];
 
%% Import initial data and organize
    file_data=load(file);   
    file_data(:,4)=[];
    [mm,nn]=size(file_data);
    file_data=reshape(file_data',nn*20,mm/20)'; 
    
%% DataSet name information
    file_label = str2double(file_name(2:3));
    file_subject = str2double(file_name(6:7));
    file_time = str2double(file_name(10:11));

%% save data
    DataSet(i).name = file_name;
    DataSet(i).data = file_data';
    DataSet(i).label = file_label;
    DataSet(i).subject = file_subject;
    DataSet(i).time = file_time;

end
    
  fprintf('Congratulations! data import completed ~@^_^@~  \n');  
  
  clearvars -except DataSet
  save MSRAction3DSkeletonReal3D_547
  
  
  