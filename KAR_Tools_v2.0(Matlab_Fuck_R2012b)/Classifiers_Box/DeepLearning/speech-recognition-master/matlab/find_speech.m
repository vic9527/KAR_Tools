function ccc = find_speech(sample,fs)
      
    clear FrameLen FrameInc amp1 amp2 zrc1 zrc2;
    FrameLen = 160;
    FrameInc = 80;
    
    amp1 = 2;  
    amp2 = 1;  
    zcr1 = 20;  
    zcr2 = 14;
        
    status  = 0;     %��ʼ״̬Ϊ����״̬  
    count   = 0;     %��ʼ�����γ���Ϊ0  
       
    %���������  
    %��֡�Ӵ�
    tmp1  = enframe(sample(1:end-1),hamming(FrameLen), FrameInc); 
    tmp2  = enframe(sample(2:end)  ,hamming(FrameLen), FrameInc);  
    signs = (tmp1.*tmp2)<0; 
    zcr   = sum(signs, 2); 
    zcr3 =  max(zcr)*0.4;
    zcr4 =  max(zcr)*0.2;
    zcr5 =  max(zcr)*0.5;
    
    
    %�����ʱ����  
    amp = sum(abs(enframe(sample, hanning(FrameLen), FrameInc)).^2, 2);  
   
    %������������  
    amp1 = min(amp1, max(amp)/16);  
    amp2 = min(amp2, max(amp)/32);  
    %fprintf('%.10g',length(zcr));

    %����amp���ж˵���  
    x1 = 0;  
    x2 = 0;
    gap = 0;
    flag = 0;
    time = 0;
    for n=1:length(zcr)         
        switch status  
        case {0,1}                   % 0 = ����, 1 = ���ܿ�ʼ  
            if amp(n) > amp1          % ȷ�Ž���������  
                x1 = max(n-count-1,1);  
                status  = 2;                    
                count   = count + 1;  
            
            elseif amp(n) > amp2    % ���ܽ�Ҫ����������  
                status = 1;  
                count  = count + 1;  
            else                       % ����״̬  
                status  = 0;  
                count   = 0;  
            end
            
        case 2,                       %  ������
            if amp(n) > amp2                                
                count = count + 1;   
            else                    % ��������  
                status  = 3;
                gap = gap + 1;
                
            end
           
        %����������֮����ܳ��־�����gap    
        case 3
            
            if amp(n)>amp2
                time = time + 1;
                if time > 2
                    count = count + gap;
                    gap = 0;
                    count = count + 1;
                    flag = 2;
                    status = 2;
                else
                    
                    gap = gap + 1;
                end
            else
                gap = gap + 1;
                time = 0;
            end
        end  
    end
        
    x2 = x1 + count + flag; 
    %fprintf('%.10g %10.g',amp(x2),amp2);
       
    limit = x1 ;
    %����zrc����ȷ������յ�
    for n = 1:min(20,limit -11)
        m = limit - n;
        if  zcr(m)  > 50
            x1 = m - 2;
        end
        if  zcr(m) - zcr(m-8) > zcr3 
            x1 = m - 8;
            break;
        elseif zcr(m) - zcr(m-5) > zcr3
            x1 = m - 5;                
            break;
        elseif(zcr(m) - zcr(m-2)>zcr3 || zcr(m) - zcr(m-1) > zcr3 )            
            x1 = m - 2;                
            %break;
        
        end
    end
    
    for n = x2:min(x2 + 30,length(zcr)-9)
        if  zcr(n)  > 50
            x2 = n + 2;
        end
        if  zcr(n) - zcr(n+8) > zcr5 
            x2 = n + 8;
            break;
        elseif  zcr(n) - zcr(n+5) > zcr3 
            x2 = n + 5;
            break;
        elseif((zcr(n) - zcr(n+1) > zcr3 && zcr(n+1) < zcr3 ) || (zcr(n) - zcr(n+2)>zcr3 && zcr(n+2) < zcr3))                         
            x2 = n+2; 
            break;
        end
    end
    
    if x1 < 1
        x1 = 1;
    end
    
    if x2 > length(zcr);
        x2 = length(zcr);
    end
    
    %count = count-silence/2;  
    %x2 = x1 + count -1; 
    %fprintf('%.0g, %.0g',temp,count);
    %temp = temp-silence/2;  
    %x2 = x1 + temp -1; 
%     subplot(311)    %subplot(3,1,1)��ʾ��ͼ�ų�3��1�У�����һ��1��ʾ����Ҫ����1��ͼ  
%     plot(sample)  
%     axis([1 length(sample) -1 1])    %�����е��ĸ������ֱ��ʾxmin,xmax,ymin,ymax������ķ�Χ  
%     ylabel('Speech');  
%     line([x1*FrameInc+maxsilence x1*FrameInc+maxsilence], [-1 1], 'Color', 'red');    
%     line([x2*FrameInc x2*FrameInc], [-1 1], 'Color', 'red');  
%     subplot(312)     
%     plot(amp);  
%     %axis([1 length(amp) 0 max(amp)])  
%     ylabel('Energy');  
%     line([x1 x1], [min(amp),max(amp)], 'Color', 'red');  
%     line([x2 x2], [min(amp),max(amp)], 'Color', 'red');  
%     subplot(313)  
%     plot(zcr);  
%     %axis([1 length(zcr) 0 max(zcr)])  
%     ylabel('ZCR');  
%     line([x1 x1], [min(zcr),max(zcr)], 'Color', 'red');  
%     line([x2 x2], [min(zcr),max(zcr)], 'Color', 'red');  
      ccc = sample(x1*FrameInc:x2*FrameInc);
%     sound(ccc,fs);
% %     
end