function L=LabelTrans_out(c,L_Trans)
%ת����ԭ��ǩ
  
     L=L_Trans;
     for cc=1:numel(c)
        L_id=find(L_Trans==cc);
        L(L_id)=c(cc);
     end
clearvars L_Trans L_id cc c

end