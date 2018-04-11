function BPNet_predict=bpnet(TrD,TrL,TeD,TeL,input_dim,Maxiters)

% TrD=TrD_T{1};
% TrL=TrL_T{1};
% TeD=TeD_V{1};
% TeL=TeL_V{1};
% input_dim=30;
% Maxiters=1000;


TR_LL=TrL;
TE_LL=TeL;
%����ֵ��һ��
% % % [input,minI,maxI] = premnmx(TrD');
[input,PS] = mapminmax(TrD');
%һ�������в���ͬ��������������Ұ���ԭ����˳�����
[c,i]=unique(TR_LL,'first');
j=sort(i);
u=TR_LL(j);
n = numel(u);
TR_LL_Trans=TR_LL;
for Trans_cc=1:n
        TR_LL_Trans(find(TR_LL_Trans==u(Trans_cc)))=Trans_cc;
end
%�����������
s = length(TR_LL) ;
output = zeros( s , n) ;
for i = 1 : s 
   output( i , TR_LL_Trans( i )  ) = 1 ;
end
%һ�������в���ͬ��������������Ұ���ԭ����˳�����
[c,i]=unique(TE_LL,'first');
j=sort(i);
u=TE_LL(j);
n = numel(u);
TE_LL_Trans=TE_LL;
for Trans_cc=1:n
        TE_LL_Trans(find(TE_LL_Trans==u(Trans_cc)))=Trans_cc;
end
%�������ݹ�һ��
% % % testInput = tramnmx(TeD' , minI, maxI ) ;
testInput = mapminmax('apply',TeD',PS);
%����������
% % % net = newff( minmax(input) , [30 input_dim] , { 'logsig' 'purelin' 'tansig' } , 'traingdx' ) ; 
net = newff( input, output', input_dim, { 'logsig' 'purelin' 'tansig' } , 'traingdx' ) ; 
%����ѵ������
net.trainparam.show = 100 ;
net.trainparam.epochs = Maxiters;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;
%  ��������¾ɰ汾֮��Ĳ��죬��Ҫ���net2.divideFcn��������ѵ������������ȥ��Զ����Զ��ֹһ����������
net.divideFcn = '';  
%% ������ʾ����
net.trainParam.showWindow=false;
%��ʼѵ��
net = train( net, input , output' ) ;
%����
net_Y = sim( net , testInput );
%ͳ��ʶ����ȷ��
[net_Max , net_Index] = max( net_Y);
%ת����ԭ��ǩ
[c,i]=unique(TE_LL,'first');
j=sort(i);
u=TE_LL(j);
n = numel(u);
for Trans_cc=1:n
        net_Index(find(net_Index==Trans_cc))=u(Trans_cc);
end
BPNet_predict=net_Index';
%  BPNet_accuracy=length(find(BPNet_predict==TeL))/length(TeL)
end