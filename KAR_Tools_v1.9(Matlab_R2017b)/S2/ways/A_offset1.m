function Initial_frame_offset = A_offset1(A)

        %% �����岿��������ʱ�������ʼ֡�ľ���
        for jj = 1:size(A,1)
            offset(jj,:)=A(jj,:)-A(1,:);
        end
        Initial_frame_offset=offset;
end