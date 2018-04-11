function data = Normalize(data)
	m = ones(size(data, 1), 1) * mean(data);
	v = ones(size(data, 1), 1) * std(data);
	data = (data - m) ./ v;
end