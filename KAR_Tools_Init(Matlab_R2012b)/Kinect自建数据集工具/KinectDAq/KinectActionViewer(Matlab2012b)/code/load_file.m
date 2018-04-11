function [X,Y,tagset]=load_file(file_basename, discard_zero_frames);
%LOAD_FILE -- Load gesture recognition sequence
%
% Input
%    file_basename: sequence name such as 'P1_1_1A_01'.
%    discard_zero_frames: (optional), if >0, no-skeleton frames at the
%       beginning of the sequence are discarded.  Default: 1.
%
% Output
%    X: (T,80) skeletal frames.
%    Y: (T,GN) 0/1 encoding of gesture presence.
%    tagset: (1,GN) cellarray of gesture names.
%
% Author: Sebastian Nowozin <Sebastian.Nowozin@microsoft.com>

if nargin < 2
	discard_zero_frames = 1;
end

tagset = { 'G1  lift outstretched arms', 'G2  Duck', ...
	'G3  Push right', 'G4  Goggles', 'G5  Wind it up', ...
	'G6  Shoot', 'G7  Bow', 'G8  Throw', 'G9  Had enough', ...
	'G10 Change weapon', 'G11 Beat both', 'G12 Kick' };

X=load(sprintf('../data/%s.csv', file_basename));
tags=load_tagstream(sprintf('../data/%s.tagstream', file_basename), tagset);
Y=tagstream_to_y(X, tags, tagset);

X=X(:,2:end);

K=find(sum(abs(X),2)<=1.0e-10);
RI=[];
for ki=1:numel(K)
	if K(ki) ~= ki
		break;
	end
	RI=[RI, ki];
end
X(RI,:)=[];
Y(RI,:)=[];
%disp(['Removed ', num2str(numel(RI)), ...
%	' frames from beginning of sequence "', file_basename, '".']);

