function Initial_frame_offset = IF_offset2(A)

        %% �����岿��������ʱ�������ʼ֡�ľ���
        for jj = 2:size(A,1)
            offset(jj-1,:)=(A(jj,:)-A(1,:)).^2;
        end
        Initial_frame_offset=offset;
end