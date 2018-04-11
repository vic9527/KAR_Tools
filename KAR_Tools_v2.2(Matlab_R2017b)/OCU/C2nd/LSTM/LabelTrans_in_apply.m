function L_Apply=LabelTrans_in_apply(LL,c)
% clear;clc
% L=[1;2;3;100;50;10;6;66;666;8888;1;2;3;100;50;10;6;66;666;8888;1;2;3;100;50;10;6;66;666;8888]
% LL=[1;2;3;100;50;10;6;66;8888]

%将新的标签应用成原自然数顺序标签
 
     L_Apply=LL;
     for Trans_cc=1:numel(c)
        L_Apply_id=find(LL==c(Trans_cc));
        L_Apply(L_Apply_id)=Trans_cc;
     end
     
clearvars c L_Apply_id Trans_cc LL

end