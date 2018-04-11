function A_norm_Mat = A_norm(A)
% A_norm=sum(A.^2,2).^(1/2);

for i=1:size(A,1)
A_norm_Mat(i,:)=norm(A(i,:));
end

end