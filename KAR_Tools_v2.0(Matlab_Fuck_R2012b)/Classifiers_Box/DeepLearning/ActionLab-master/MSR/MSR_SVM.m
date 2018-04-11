function MSR_SVM()
	load('data/train_label');
	load('data/train_data');
	load('data/test_label');
	load('data/test_data');

	model = svmtrain(train_label, train_data, '-b 1');
	[p_label, accuracy, decision] = svmpredict(test_label, test_data, model, '-b 1');
end

% Accuracy = 58.4688% (1726/2952) (classification) [LIBSVM without KNN, MSR]
% Accuracy = 53.1504% (1569/2952) (classification) [LIBSVM with KNN, MSR]