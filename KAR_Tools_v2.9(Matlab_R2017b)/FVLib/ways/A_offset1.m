function Initial_frame_offset = A_offset1(A)

        %% 计算五部分重心随时间流与初始帧的距离
        for jj = 1:size(A,1)
            offset(jj,:)=A(jj,:)-A(1,:);
        end
        Initial_frame_offset=offset;
end