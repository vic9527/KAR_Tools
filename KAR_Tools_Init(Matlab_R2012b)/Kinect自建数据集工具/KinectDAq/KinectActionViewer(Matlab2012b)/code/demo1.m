
% Demo 1: Visualize a sequence.
%
% Author: Sebastian Nowozin <Sebastian.Nowozin@microsoft.com>

disp(['Visualizing sequence data']);

[X,Y,tagset]=load_file('data');
T=size(X,1);	% Length of sequence in frames

% Animate sequence
h=axes;
for ti=1:T
	skel_vis(X,ti,h);
	drawnow;
	pause(1/30);
	cla;
end

