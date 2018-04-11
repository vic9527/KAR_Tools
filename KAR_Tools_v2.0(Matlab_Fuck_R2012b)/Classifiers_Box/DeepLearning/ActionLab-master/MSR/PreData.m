function PreData()
% To: prepare the list_train_data and list_test_data for the MSR.m to use
% In MSR Action3D Dataset, subject 1,3,5,7,9 is for training while 2,4,6,8,10 is for testing
% By Jacket, 08/11/2015
	
	fid = fopen('skeleton_data\MSR_ske\dataList.txt', 'r');
	if fid == 0
		error('Can not find the dataList.txt');
	end

	list_train_data = [];
	list_test_data = [];
	while true
		line = fgetl(fid);
		if ~ischar(line)
			break
		end
		% Filename format: a01_s01_e01
		line = [str2num(line(2:3)), str2num(line(6:7)), str2num(line(10:11))];
		if mod(line(2), 2) == 1
			list_train_data = [list_train_data; line];
		else
			list_test_data = [list_test_data; line];
		end
	end

	fclose(fid);
	save('data/list_train_data', 'list_train_data');
	save('data/list_test_data', 'list_test_data');
end