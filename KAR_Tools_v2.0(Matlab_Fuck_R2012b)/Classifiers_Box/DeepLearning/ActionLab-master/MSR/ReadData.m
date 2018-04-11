function [label, data] = ReadData(list_data)
% Read skeleton data according the key parameters in file name
% The format of file name is like: a01_s01_e02_skeleton3D.txt
% Return the label vector and the data matrix
% By Jacket, 08/11/2015

	skeletonJoints = 20;
	lengthPerFrame = skeletonJoints * 3;
	cnt = size(list_data, 1);
	% label = zeros(cnt, 1);
	% data = zeros(cnt, lengthPerFrame);
	label = [];
	data = [];
	for i = 1 : cnt
		fileName = sprintf('skeleton_data/MSR_ske/a%02d_s%02d_e%02d_skeleton3D.txt', list_data(i, :));
		fid = fopen(fileName);
		if fid == 0
			error(sprintf('Can not open the file: %s\n', fileName));
		end
		tmp_data = fscanf(fid, '%f');			% a column vector
		numOfPoints = int32(length(tmp_data) / 4);
		numOfFrames = numOfPoints / skeletonJoints;
		tmp_data = reshape(tmp_data, 4,  numOfPoints);
		tmp_data = reshape(tmp_data(1:3, :), lengthPerFrame, numOfFrames);
		tmp_data = MoveOrigin(tmp_data);
		data = [data; tmp_data'];
		label = [label; ones(numOfFrames, 1) * list_data(i, 1)];
        fclose(fid);
	end
end