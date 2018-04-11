function AngAB = AB_Ang(A,B)
%     A= k4k7;
%     B= k5k7;

% AngAB=real(acosd(dot(A,B,2)./(A_norm(A).*A_norm(B))));%求角度
AngAB=real(acos(dot(A,B,2)./(A_norm(A).*A_norm(B))));%求弧度
% AngAB=real(dot(A,B,2)./(A_norm(A).*A_norm(B)));%求余弦
% AngAB=real(dot(A,B,2));%求数量积

end

