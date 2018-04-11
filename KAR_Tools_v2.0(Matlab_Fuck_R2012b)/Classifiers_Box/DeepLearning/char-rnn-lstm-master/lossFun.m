function [loss, dWxh, dWhh, dWhy, ...
    dbh, dby, hs_last] =...
    lossFun(inputs, targets, hprev)
%   """
%   inputs,targets are both list of integers.
%   hprev is Hx1 array of initial hidden state
%   returns the loss, gradients on model parameters, and last hidden state
%   """

global vocab_size Wxh Whh Why bh by;

xs = {};
hs = {};
ys = {};
ps = {};

hs_pre = hprev;
loss = 0;
%   # forward pass
for t  = 1:length(inputs)
%     t
    xs{t} = zeros(vocab_size,1); % # encode in 1-of-k representation
    xs{t}(inputs(t)) = 1;
    if t > 1
        hs{t} = tanh(Wxh*xs{t} + Whh*hs{t-1} + bh); % # hidden state
    else
        hs{t} = tanh(Wxh*xs{t} + Whh*hs_pre + bh);
    end
    ys{t} = Why*hs{t} + by; % # unnormalized log probabilities for next chars
    ps{t} = exp(ys{t}) / sum(exp(ys{t})); % # probabilities for next chars
    loss = loss - log(ps{t}(targets(t))); % # softmax (cross-entropy loss)
end
%   # backward pass: compute gradients going backwards
dWxh = zeros(size(Wxh));
dWhh = zeros(size(Whh));
dWhy = zeros(size(Why));
dbh = zeros(size(bh));
dby = zeros(size(by));
dhnext = zeros(size(hs{1}));
for t = length(inputs):-1:1
%     t
    dy = ps{t};
    dy(targets(t)) = dy(targets(t))-1; %# backprop into y
    dWhy = dWhy + dy*hs{t}';
    dby = dby + dy;
    dh = Why'*dy + dhnext; % # backprop into h
    dhraw = (1 - hs{t}.*hs{t}) .* dh; % # backprop through tanh nonlinearity
    dbh = dbh + dhraw;
    dWxh = dWxh + dhraw*xs{t}';
    if t > 1
        dWhh = dWhh + dhraw*hs{t-1}';
    else
        dWhh = dWhh + dhraw*hs_pre';
    end
    dhnext = Whh'*dhraw;
end
% for dparam in [dWxh, dWhh, dWhy, dbh, dby]:
%     np.clip(dparam, -5, 5, out=dparam)% # clip to mitigate exploding gradients
% end
% # clip to mitigate exploding gradients
dWxh = clip(dWxh, -5, 5);
dWhh = clip(dWhh, -5, 5);
dWhy = clip(dWhy, -5, 5);
dbh = clip(dbh, -5, 5);
dby = clip(dby, -5, 5);

% return loss, dWxh, dWhh, dWhy, dbh, dby, hs[len(inputs)-1]
hs_last = hs{length(hs)};