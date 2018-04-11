A=load('sample.csv');%载入数据

for i=0:3:60;
A(:,i+1) = [];
end

for i=1:20;
eval(['k',num2str(i),'=','A(:,i*3-2:i*3)',';']);
end

spv5=k5-k6;
spv6=k7-k6;

% % % 
% % % 任意 p 范数：
% % % sum(abs(X).^p,2).^(1/p)
% % % 
% % % 把p换成2，就是你要的模

norm_spv5=sum(abs(spv5).^2,2).^(1/2);
norm_spv6=sum(abs(spv6).^2,2).^(1/2);

D_acp4=acosd((dot(spv5,spv6,2))./(norm_spv5.*norm_spv6));
X=(1:97)';

scatter(X,D_acp4);
plot(X,D_acp4);
cftool

sp1=spap2(50,3,X,D_acp4);
plot(X,D_acp4);
hold on;
fnplt(sp1,'r');

s_diff=fnder(sp1,2); 
hold on;
fnplt(s_diff,'c');
