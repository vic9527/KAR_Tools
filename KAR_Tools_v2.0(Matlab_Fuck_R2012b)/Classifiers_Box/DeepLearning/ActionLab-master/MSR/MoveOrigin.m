%% MoveOrigin: move the coordinate origin to the 7th joint
function [data] = MoveOrigin(data)
% input: size(data) = [60, numOfFrames]

	offset = [1:3] + 3 * (7 - 1);
	key = data(offset, :);
	key = repmat(key, size(data, 1) / 3, 1);
	data = data - key;
end