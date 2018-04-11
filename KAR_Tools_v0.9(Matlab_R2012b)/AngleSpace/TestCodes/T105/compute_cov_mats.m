function covMats = compute_cov_mats(X, Y, Z, T, nl, ol)
% Computes a hierarchy of covariance matrices for the given sequence
% The function computes a hierarchy of covariance matrices for a sequence
% of joint locations (X, Y, and Z), their time stamps (T), the requested 
% number of hierarchy levels, and whether time overlap is allowed or not.
% Before computing the matrices, the function normalizes each coordinate 
% individually and the time stamps for all frames to be in the range 
% from 0 to 1. Only the lower triangle and main diagonal of each covariance
% matrix is stored in the output cell array because covariance matrices are
% symmetric. The returned part is stored as a 1-d array including the first
% column, the the part of the second column starting from the main
% diagonal, and so on.
%
% Inputs:
%   X: [nFrames, nJoints] x-coord of joints in all frames
%   Y: [nFrames, nJoints] y-coord of joints in all frames
%   Z: [nFrames, nJoints] z-coord of joints in all frames
%   T: [nFrames, 1] time stamps for all frames
%   nl: number of levels in hierarchy
%   ol: (true/false) whether matrices should overlap in time or not
%
% Outputs:
%   covMats: cell(nl, 1) a cell array, each element of which is itself a
%       cell array of covariance matrices of the corresponding level of the
%       hierarchy.
%
% Author: Mohamed E. Hussein (mehussein@alexu.edu.eg)
% Date: Nov 6, 2012

%% Make sure sizes of input matrices match
nFrames = size(X, 1);
nJoints = size(X, 2);
assert(size(Y, 1) == nFrames);
assert(size(Z, 1) == nFrames);
assert(size(T, 1) == nFrames);
assert(size(Y, 2) == nJoints);
assert(size(Z, 2) == nJoints);
assert(size(T, 2) == 1);

%% Normalize data
minX = min(X(:));
maxX = max(X(:));
normX = (X - minX) / (maxX - minX);
minY = min(Y(:));
maxY = max(Y(:));
normY = (Y - minY) / (maxY - minY);
minZ = min(Z(:));
maxZ = max(Z(:));
normZ = (Z - minZ) / (maxZ - minZ);
minT = min(T(:));
maxT = max(T(:));
normT = (T - minT) / (maxT - minT + 1e-5);

%% Construct covariance matrices
nVars = nJoints * 3 + 1; % x, y, z for each joint plus time
matTriLength = nVars * (nVars + 1) / 2; % number of elements in the upper 
                                      % or lower triangle of the cov matrix
% create list of indices for the lower triangle part of the covariance
% matrix, including the main diagonal
matTriInds = zeros(1, matTriLength);
prefix = 1;
k1 = 1;
for i = 1:nVars
    delta = nVars - i;
    k2 = k1 + delta; 
    matTriInds(k1:k2) = prefix:(prefix + delta);
    k1 = k2 + 1;
    prefix = prefix + nVars + 1;
end

% now, create covariance matrices
covMats = cell(nl, 1);
sliceVars = [normX normY normZ];

% cMat = cov(sliceVars);
% covMats{1}{1} = cMat(matTriInds);


for l = 1:nl
    nMats = 2 ^ (l - 1);
    timeFracPerMat = 1 / nMats;
    step = timeFracPerMat;
    if ol
        step = step / 2;
        nMats = nMats * 2 - 1;
    end
    startFrameTimes = step * (0:(nMats-1));
    covMats{l} = cell(1, nMats);
    for i = 1:length(startFrameTimes)
        startTime = startFrameTimes(i);
        endTime = startFrameTimes(i) + timeFracPerMat + 2 * eps;
        sliceInds = find(normT >= startTime & normT < endTime);
        sliceX = normX(sliceInds, :);
        sliceY = normY(sliceInds, :);
        sliceZ = normZ(sliceInds, :);
        sliceT = normT(sliceInds, :);
        sliceVars = [sliceX sliceY sliceZ sliceT];
        cMat = cov(sliceVars);
        covMats{l}{i} = cMat(matTriInds);
    end
end
