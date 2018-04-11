% """
% Minimal character-level Vanilla RNN model. Written by Andrej Karpathy (@karpathy)
% BSD License
% """
% changed by YXS for Matlab
% 2015-08-23
clc;
clear all;

global vocab_size Wxh Whh Why bh by;

% # data I/O
% # should be simple plain text file
data = readFileToStrs('input.txt');
chars = unique(data);
data_size = length(data);
vocab_size = length(chars);
fprintf('data has %d characters, %d unique.', ...
    data_size, vocab_size);
char_to_ix = containers.Map('KeyType', 'char', 'ValueType', 'double');
for i = 1:vocab_size
    char_to_ix(chars(i)) = i;
end
ix_to_char = containers.Map('KeyType', 'double', 'ValueType', 'char');
for i = 1:vocab_size
    ix_to_char(i) = chars(i);
end
% char_to_ix = { ch:i for i,ch in enumerate(chars) }
% ix_to_char = { i:ch for i,ch in enumerate(chars) }

% # hyperparameters
hidden_size = 100; %# size of hidden layer of neurons
seq_length = 25; %# number of steps to unroll the RNN for
learning_rate = 1e-1;

% # model parameters
Wxh = randn(hidden_size, vocab_size)*0.01; %# input to hidden
Whh = randn(hidden_size, hidden_size)*0.01; %# hidden to hidden
Why = randn(vocab_size, hidden_size)*0.01; %# hidden to output
bh = zeros(hidden_size, 1); %# hidden bias
by = zeros(vocab_size, 1); %# output bias




n = 1;
p = 1;
mWxh = zeros(size(Wxh));
mWhh = zeros(size(Whh));
mWhy = zeros(size(Why));
mbh = zeros(size(bh));% # memory variables for Adagrad
mby = zeros(size(by)); % # memory variables for Adagrad
smooth_loss = -log(1.0/vocab_size)*seq_length; % # loss at iteration 0
while 1
    %   # prepare inputs (we're sweeping from left to right in steps seq_length long)
    if p+seq_length+1 >= length(data) || n == 1
        hprev = zeros(hidden_size,1); %# reset RNN memory
        p = 1; %# go from start of data
    end
    inputs=zeros(1,seq_length);
    for ch = 1:seq_length
        inputs(ch) = char_to_ix(data(p+ch-1));
    end
    %     inputs = [char_to_ix[ch] for ch in data[p:p+seq_length]]
    %         targets = [char_to_ix[ch] for ch in data[p+1:p+seq_length+1]]
    targets=zeros(1,seq_length);
    for ch = 1:seq_length
        targets(ch) = char_to_ix(data(p+ch));
    end
    
    %   # sample from the model now and then
    if mod(n,100) == 0
        sample_ix = sample(hprev, inputs(1), 200);
        %         txt = ''.join(ix_to_char[ix] for ix in sample_ix)
        txt = [];
        for ixi = 1:length(sample_ix)
            ix = sample_ix(ixi);
            txt = [txt ix_to_char(ix)];
        end
        fprintf('----\n %s \n----',txt);
    end
    
    %   # forward seq_length characters through the net and fetch gradient
    [loss, dWxh, dWhh, dWhy, ...
        dbh, dby, hprev] = ...
        lossFun(inputs, targets, hprev);
    smooth_loss = smooth_loss * 0.999 +...
        loss * 0.001;
    
    if mod(n,100) == 0 % # print progress
        fprintf('iter %d, loss: %f',...
            n, smooth_loss);
    end
    
    
    %Wxh
    mWxh = mWxh + dWxh .* dWxh;
    Wxh = Wxh - ...
        learning_rate * dWxh ./...
        sqrt(mWxh + 1e-8); %# adagrad update
    %Whh
    mWhh = mWhh + dWhh .* dWhh;
    Whh = Whh - ...
        learning_rate * dWhh ./...
        sqrt(mWhh + 1e-8); %# adagrad update
    %Why
    mWhy = mWhy + dWhy .* dWhy;
    Why = Why - ...
        learning_rate * dWhy ./...
        sqrt(mWhy + 1e-8); %# adagrad update
    % bh
    mbh = mbh + dbh .* dbh;
    bh = bh - ...
        learning_rate * dbh ./...
        sqrt(mbh + 1e-8); %# adagrad update
    % by
    mby = mby + dby .* dby;
    by = by - ...
        learning_rate * dby ./...
        sqrt(mby + 1e-8); %# adagrad update
    
    p = p + seq_length; %# move data pointer
    n = n + 1; %# iteration counter
end
