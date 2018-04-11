function BPNet_predict=bpnet(TrD,TrL,TeD,TeL,input_dim,Maxiters)

% TrD=TrD_T{1};
% TrL=TrL_T{1};
% TeD=TeD_V{1};
% TeL=TeL_V{1};
% input_dim=30;
% Maxiters=1000;


TR_LL=TrL;
TE_LL=TeL;
%特征值归一化
% % % [input,minI,maxI] = premnmx(TrD');
[input,PS] = mapminmax(TrD');
%一个数组中不相同的数据输出，并且按照原来的顺序输出
[c,i]=unique(TR_LL,'first');
j=sort(i);
u=TR_LL(j);
n = numel(u);
TR_LL_Trans=TR_LL;
for Trans_cc=1:n
        TR_LL_Trans(find(TR_LL_Trans==u(Trans_cc)))=Trans_cc;
end
%构造输出矩阵
s = length(TR_LL) ;
output = zeros( s , n) ;
for i = 1 : s 
   output( i , TR_LL_Trans( i )  ) = 1 ;
end
%一个数组中不相同的数据输出，并且按照原来的顺序输出
[c,i]=unique(TE_LL,'first');
j=sort(i);
u=TE_LL(j);
n = numel(u);
TE_LL_Trans=TE_LL;
for Trans_cc=1:n
        TE_LL_Trans(find(TE_LL_Trans==u(Trans_cc)))=Trans_cc;
end
%测试数据归一化
% % % testInput = tramnmx(TeD' , minI, maxI ) ;
testInput = mapminmax('apply',TeD',PS);
%创建神经网络
% % % net = newff( minmax(input) , [30 input_dim] , { 'logsig' 'purelin' 'tansig' } , 'traingdx' ) ; 
net = newff( input, output', input_dim, { 'logsig' 'purelin' 'tansig' } , 'traingdx' ) ; 
%设置训练参数
net.trainparam.show = 100 ;
net.trainparam.epochs = Maxiters;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;
%  若想减少新旧版本之间的差异，需要清除net2.divideFcn等属性再训练，否则结果相去甚远，且远不止一个数量级。
net.divideFcn = '';  
%% 不许显示弹窗
net.trainParam.showWindow=false;
%开始训练
net = train( net, input , output' ) ;
%仿真
net_Y = sim( net , testInput );
%统计识别正确率
[net_Max , net_Index] = max( net_Y);
%转换成原标签
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