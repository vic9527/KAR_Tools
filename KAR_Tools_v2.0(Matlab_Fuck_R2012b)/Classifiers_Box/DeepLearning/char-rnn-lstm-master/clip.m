function Y = clip(X,a,b)
Y = X;
% clip

idx = Y < a;
Y(idx) = a;

idx = Y > b;
Y(idx) = b;