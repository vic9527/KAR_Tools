clc;clear;
addpath('./ConfusionMatrices')
A1(1,[1:3])=1;
A2(1,[1:6])=2;
A3(1,[1:7])=3;
A4(1,[1:6])=4;
A5(1,[1:4])=5;
A6(1,[1:2])=6;
A7(1,[1:4])=7;
A8(1,[1:8])=8;
A9(1,[1:8])=9;
A10(1,[1:6])=10; 

A11(1,[1:7])=11;
A12(1,[1:6])=12;
A13(1,[1:3])=13;
A14(1,[1:6])=14;
A15(1,[1:3])=15;
A16(1,[1:5])=16;
A17(1,[1:7])=17;
A18(1,[1:4])=18;
A19(1,[1:7])=19;
A20(1,[1:1])=20; 



%%混淆矩阵20类的正确标签




A=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20]; %%输出一个标准向量


A(1,19)=7;A(1,22)=1;A(1,90)=19;A(1,97)=17; %%改变向量中的元素，使得向量变为实际输出的标签列


num=[3 6 7 6 4 2 4 8 8 6 7 6 3 6 3 5 7 4 7 1];

name=cell(1,20);   

name{1}='high arm wave';name{2}='horizontal arm wave';name{3}='hammer';name{4}='hand catch'; name{5}='forward punch'; 
name{6}='high throw';name{7}='draw x';name{8}='draw tick'; name{9}='draw circle';name{10}='hand clap';

name{11}='two hand wave';name{12}='side-boxing';name{13}='bend';name{14}='forward kick'; name{15}='side kick'; 
name{16}='jogging';name{17}='tennis swing';name{18}='tennis serve'; name{19}='golf swing';name{20}='pick up & throw';

compute_confusion_matrix(A,num,name)  






















