function AngXYZ = A_AngXYZ(A)

A_norm=sum(A.^2,2).^(1/2);

for i=1:size(A,2)
AngXYZ(:,i)=acosd(A(:,i)./A_norm);
end


end