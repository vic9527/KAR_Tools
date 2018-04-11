A=load('a01_s01_e01_skeleton.txt');
B=load('a01_s01_e01_skeleton3D.txt');
C(:,1)=A(:,3);
C(:,2)=B(:,3);

ggt=load('ggt.txt');
ggt(:,4)=[];
gx=ggt(:,1);
gy=ggt(:,2);
gz=ggt(:,3);

scatter3(gx(1),gy(1),gz(1),'.')
hold on
scatter3(gx(20),gy(20),gz(20),'*')
hold on
scatter3(gx,gy,gz,'o')
% plot3(gx,gy,gz,'b.','MarkerSize',0.5) 