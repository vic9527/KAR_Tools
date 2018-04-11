function DataForSVM()
	load('list_test_data.mat');
	load('list_train_data.mat');
	load('aver.mat');
	% the length of trajectory(2*t + 1)
	t = 7;
	Data_set = 1;

	%Get the train data
	[train_data, train_index] = Get_data(list_train_data, t, Data_set, aver);
	[test_data, test_index] = Get_data(list_test_data, t, Data_set, aver);

	% 选取出共享的动作帧
	[cw, w] = Kmeans_weighting(train_data, 120);
	% 加上一列用来存放 1 / sum
	train_data = [train_data, w];
	% 创建新的share frame类型
	% 和论文的min(min(w + 0.2), 0.3)有点差别
	train_data(w < 0.2, 1) = 21;

	[cw, w] = Kmeans_weighting(test_data, 120);
	test_data = [test_data, w];
	test_data(w < 0.2, 1) = 21;

	train_label = train_data(:, 1);
	train_data = train_data(:, 2:end-1);
	save('data/train_label', 'train_label');
	save('data/train_data', 'train_data');

	test_label = test_data(:, 1);
	test_data = test_data(:, 2:end-1);
	save('data/test_label', 'test_label');
	save('data/test_data', 'test_data');
end