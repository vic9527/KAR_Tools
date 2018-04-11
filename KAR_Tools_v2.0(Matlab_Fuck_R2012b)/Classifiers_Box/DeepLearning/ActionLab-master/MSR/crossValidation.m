function [max, maxPara] = crossValidation(train_label, train_data, test_label, test_data)
	c = [-5:1:5]
	g = [-4:1:4]
	max = 0;
	maxPara = [0, 0];
	for i = 1 : size(c, 2)
		for j = 1 : size(g, 2)
			option = sprintf('-c %f -g %f -b 1', power(2, c(i)), power(2, g(j)));
			model = svmtrain(train_label, train_data, '-b 1');
			[p_label, accuracy, decision] = svmpredict(test_label, test_data, model, '-b 1');

			if accuracy > max
				info = sprintf('Time: i = %d, j = %d, max = %f', i, j, accuracy);
				disp(info);
				max = accuracy;
				maxPara(1) = c(i);
				maxPara(2) = g(j);
			end
		end
	end
end