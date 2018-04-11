function CrossAngAB = CrossAB_Ang(A,B)
%      A=k20-k3;
%      B=k4-k3;
CrossAB=cross(A,B);

% for i = 1:size(CrossAB,1)
%     CrossAngAB(i,:)=real(acosd(...
%         dot(CrossAB(1,:),CrossAB(i,:),2)./...
%         (norm(CrossAB(1,:)).*norm(CrossAB(i,:)))...
%         ));
% end 

for i = 1:size(CrossAB,1)
    CrossAngAB(i,:)=real(acos(...
        dot(CrossAB(1,:),CrossAB(i,:),2)./...
        (norm(CrossAB(1,:)).*norm(CrossAB(i,:)))...
        ));
end

% for i = 1:size(CrossAB,1)
%     CrossAngAB(i,:)=real(...
%         dot(CrossAB(1,:),CrossAB(i,:),2)./...
%         (norm(CrossAB(1,:)).*norm(CrossAB(i,:)))...
%         );
% end

% for i = 1:size(CrossAB,1)
%     CrossAngAB(i,:)=real(dot(CrossAB(1,:),CrossAB(i,:),2));
% end

end

