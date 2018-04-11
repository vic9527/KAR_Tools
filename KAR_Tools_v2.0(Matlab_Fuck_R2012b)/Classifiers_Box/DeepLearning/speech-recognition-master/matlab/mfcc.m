function ccc = mfcc(sample, fs)
    %fprintf('%s\n',path);
    %��̬������ȡ
    bank=melbankm(24,256,fs,0,0.4,'t');%Mel�˲����Ľ���Ϊ24��fft�任�ĳ���Ϊ256������Ƶ��Ϊ16000Hz

    %��һ��mel�˲�����ϵ�����������磩
    bank=full(bank);
    bank=bank/max(bank(:));
    for k=1:12
        n=0:23;
        dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));
    end
    
    w=1+6*sin(pi*[1:12] ./12);   
    w=w/max(w);
    
    %Ԥ���ش���
    x=double(sample);
    x=filter([1-0.9375],1,x);
    
    %��֡���Ӻ�����
    x=enframe(x,hamming(256),80);
    
    %����ÿ֡��MFCC����
    for i=1:size(x,1)
        y=x(i,:);
        %fft
        t=abs(fft(y'));
        %������
        t=t.^2;
        %Mel�˲����˲�,ȡ����
        %c1=log(bank*t(1:129));
        %dct ��ɢ���ұ任
%         c1 = dct(c1);
%         [c2,ind] = sort(abs(c1),'descend');
%         %idct ����ɢ���ұ任
%         ccc(i,:)=idct(c2(1:12,:));
        %ccc(i,:)=c2(1:12,:);
        c1=dctcoef*log(bank*t(1:129));
        c2=c1.*w';   
        m(i,:)=c2';  
       
        %��ֲ���   
        dtm=zeros(size(m));   
        for i=3:size(m,1)-2   
            dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);   

        end   
        dtm=dtm/3;   

        %�ϲ�mfcc������һ�ײ��mfcc����   

        ccc=[m dtm];  
        %ȥ����λ��֡����Ϊ����֡��һ�ײ�ֲ���Ϊ0   

        ccc=ccc(3:size(m,1)-2,:);
        
        %ccc=ccc(:,1);
    end

%  subplot(2,1,1) 
%  ccc_1=ccc(:,1);
%  plot(ccc_1);title('MFCC');ylabel('��ֵ');
%  [h,w]=size(ccc);
%  A=size(ccc);
%  subplot(212) 
%  plot([1,w],A);
%  xlabel('ά��');
%  ylabel('��ֵ');
%  title('ά�����ֵ�Ĺ�ϵ')
end