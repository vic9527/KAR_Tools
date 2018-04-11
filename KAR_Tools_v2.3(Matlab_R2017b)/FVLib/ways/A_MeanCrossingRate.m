function A_cross_time=A_MeanCrossingRate(A)
%	Acc feas Computation
%   INPUT:
%   data NO*1
%   OUTPUT:
%   cross_time: 1*1 mean crossing rate
 for j=1:size(A,2)
               
mean_series = A(:,j) - mean(A(:,j));
cross_time = 0;
for i = 2:length(A(:,j))
    if mean_series(i-1)*mean_series(i) < 0
        cross_time = cross_time + 1;
    end
end
    A_cross_time(j)=cross_time;
end