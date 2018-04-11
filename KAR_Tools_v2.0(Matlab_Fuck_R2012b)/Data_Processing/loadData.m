function Actions = loadData(data_dir, verbose)

%% load all data
d = dir(data_dir);
isfile = [d(:).isdir] ~= 1;
files = {d(isfile).name}';

Actions = struct;

for i=1:length(files)
    if verbose
        fprintf([files{i},'...']);
    end
    
    file = [data_dir, files{i}];
    
%% feature extraction
Features = extractFeatures(file);  
    
    
%% additional information
file_name = files{i};
ActionLabel = str2double(file_name(2:3));
ActionUser = str2double(file_name(6:7));
ActionNumber = str2double(file_name(10:11));
    
%% save data
Actions(i).name = file_name;
Actions(i).label = ActionLabel;
Actions(i).user = ActionUser;
Actions(i).number = ActionNumber;
    %% Defining hierarchical features
    Actions(i).Feature1st = Features(1:15,:);
    Actions(i).Feature2nd = Features(16:end,:);

    if verbose
        fprintf('done.\n');        
    end
end
