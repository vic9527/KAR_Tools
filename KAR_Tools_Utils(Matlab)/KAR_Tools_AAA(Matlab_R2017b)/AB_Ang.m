function AngAB = AB_Ang(A,B)
%     A= k4k7;
%     B= k5k7;

% AngAB=real(acosd(dot(A,B,2)./(A_norm(A).*A_norm(B))));%��Ƕ�
AngAB=real(acos(dot(A,B,2)./(A_norm(A).*A_norm(B))));%�󻡶�
% AngAB=real(dot(A,B,2)./(A_norm(A).*A_norm(B)));%������
% AngAB=real(dot(A,B,2));%��������

end

