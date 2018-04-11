function Initial_frame_offset = IF_offset2(A)

        %% 计算五部分重心随时间流与初始帧的距离
        for jj = 2:size(A,1)
            offset(jj-1,:)=(A(jj,:)-A(1,:)).^2;
        end
        Initial_frame_offset=offset;
end