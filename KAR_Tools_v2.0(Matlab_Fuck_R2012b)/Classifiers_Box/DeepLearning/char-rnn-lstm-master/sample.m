function ixes = sample(h, seed_ix, n)
%   """
%   sample a sequence of integers from the model
%   h is memory state, seed_ix is seed letter for first time step
%   """

global vocab_size Wxh Whh Why bh by;

x = zeros(vocab_size, 1);
x(seed_ix) = 1;
ixes = [];
for t = 1:n
%     t
    h = tanh(Wxh*x + Whh*h + bh);
    y = Why*h + by;
    p = exp(y) / sum(exp(y));
%     ix = np.random.choice(range(vocab_size), p)
    ix = randsrc(1,1,[1:vocab_size;p']);
    x = zeros(vocab_size, 1);
    x(ix) = 1;
    ixes = [ixes ix];
end
% return ixes
