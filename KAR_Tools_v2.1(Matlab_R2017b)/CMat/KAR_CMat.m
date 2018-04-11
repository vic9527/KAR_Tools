% clear; close all; clc;
% Target=CPRP{1}(:,1);
% Output=CPRP{1}(:,4);
% C_TO=[Target,Output];
% K=[num2cell(order)]';
function KAR_CMat(Target,Output)

% [C,order]=confusionmat(Temp(:,1),Temp(:,2));
[C,order]=confusionmat(Output,Target);

name=cell(1,20);   
name{1}='high arm wave';
name{2}='horizontal arm wave';
name{3}='hammer';
name{4}='hand catch'; 
name{5}='forward punch'; 
name{6}='high throw';
name{7}='draw x';
name{8}='draw tick'; 
name{9}='draw circle';
name{10}='hand clap';
name{11}='two hand wave';
name{12}='side-boxing';
name{13}='bend';
name{14}='forward kick'; 
name{15}='side kick'; 
name{16}='jogging';
name{17}='tennis swing';
name{18}='tennis serve'; 
name{19}='golf swing';
name{20}='pick up & throw';

plotConfMat(C, name(order));

end

% confmat = magic(3); % sample data
% % plotting
% plotConfMat(confmat, {'Dog', 'Cat', 'Horse'});
