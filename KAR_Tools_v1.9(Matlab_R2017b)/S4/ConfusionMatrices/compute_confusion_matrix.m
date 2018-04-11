function [confusion_matrix]=compute_confusion_matrix(predict_label,num_in_class,name_class)%Ԥ���ǩ��ÿһ�����Ŀ�������Ŀ  
%predict_labelΪһά������  
%num_in_class����ÿһ��ĸ���  
%name_class��������  
num_class=length(num_in_class);  
num_in_class=[0 num_in_class];  
confusion_matrix=size(num_class,num_class);  
  
for ci=1:num_class  
    for cj=1:num_class  
        summer=0;%ͳ�ƶ�Ӧ��ǩ����  
        c_start=sum(num_in_class(1:ci))+1;  
        c_end=sum(num_in_class(1:ci+1));  
        summer=size(find(predict_label(c_start:c_end)==cj),2);  
        confusion_matrix(ci,cj)=summer/num_in_class(ci+1);  
    end  
end  
  
draw_cm(confusion_matrix,name_class,num_class);  
  
end  