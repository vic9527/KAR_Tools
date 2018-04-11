function [c,L_Trans]=LabelTrans_in(L)
% clear;clc
% L=[1;2;3;100;50;10;6;66;666;8888;1;2;3;100;50;10;6;66;666;8888;1;2;3;100;50;10;6;66;666;8888]

%原标签转换成自然数顺序标签

     [c,i]=unique(L,'first');    
     L_Trans=L;
     for Trans_cc=1:numel(c)
        L_Trans_id=find(L==c(Trans_cc));
        L_Trans(L_Trans_id)=Trans_cc;
     end
     
clearvars i L_Trans_id Trans_cc L

end