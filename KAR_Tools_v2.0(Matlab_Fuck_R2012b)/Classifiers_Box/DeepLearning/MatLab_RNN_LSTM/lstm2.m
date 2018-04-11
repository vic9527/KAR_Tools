% implementation of LSTM  
clc  
clear  
close all  
    
%% training dataset generation  
binary_dim     = 8;  
  
  
largest_number = 2^binary_dim - 1;  
binary         = cell(largest_number, 1);  
  
  
for i = 1:largest_number + 1  
    binary{i}      = dec2bin(i-1, binary_dim);  
    int2binary{i}  = binary{i};  
end  
  
  
%% input variables  
alpha      = 0.1;  
input_dim  = 2;  
hidden_dim = 32;  
output_dim = 1;  
allErr = [];  
%% initialize neural network weights  
% in_gate     = sigmoid(X(t) * X_i + H(t-1) * H_i)    ------- (1)  
X_i = 2 * rand(input_dim, hidden_dim) - 1;  
H_i = 2 * rand(hidden_dim, hidden_dim) - 1;  
X_i_update = zeros(size(X_i));  
H_i_update = zeros(size(H_i));  
bi = 2*rand(1,1) - 1;  
bi_update = 0;  
  
  
% forget_gate = sigmoid(X(t) * X_f + H(t-1) * H_f)    ------- (2)  
X_f = 2 * rand(input_dim, hidden_dim) - 1;  
H_f = 2 * rand(hidden_dim, hidden_dim) - 1;  
X_f_update = zeros(size(X_f));  
H_f_update = zeros(size(H_f));  
bf = 2*rand(1,1) - 1;  
bf_update = 0;  
% out_gate    = sigmoid(X(t) * X_o + H(t-1) * H_o)    ------- (3)  
X_o = 2 * rand(input_dim, hidden_dim) - 1;  
H_o = 2 * rand(hidden_dim, hidden_dim) - 1;  
X_o_update = zeros(size(X_o));  
H_o_update = zeros(size(H_o));  
bo = 2*rand(1,1) - 1;  
bo_update = 0;  
% g_gate      = tanh(X(t) * X_g + H(t-1) * H_g)       ------- (4)  
X_g = 2 * rand(input_dim, hidden_dim) - 1;  
H_g = 2 * rand(hidden_dim, hidden_dim) - 1;  
X_g_update = zeros(size(X_g));  
H_g_update = zeros(size(H_g));  
bg = 2*rand(1,1) - 1;  
bg_update = 0;  
  
  
out_para = 2 * rand(hidden_dim, output_dim) - 1;  
out_para_update = zeros(size(out_para));  
% C(t) = C(t-1) .* forget_gate + g_gate .* in_gate    ------- (5)  
% S(t) = tanh(C(t)) .* out_gate                       ------- (6)  
% Out  = sigmoid(S(t) * out_para)                     ------- (7)  
% Note: Equations (1)-(6) are cores of LSTM in forward, and equation (7) is  
% used to transfer hiddent layer to predicted output, i.e., the output layer.  
% (Sometimes you can use softmax for equation (7))  
  






  
%% train   
iter = 99999; % training iterations  
for j = 1:iter  
    % generate a simple addition problem (a + b = c)  
    a_int = randi(round(largest_number/2));   % int version  
    a     = int2binary{a_int+1};              % binary encoding  
      
    b_int = randi(floor(largest_number/2));   % int version  
    b     = int2binary{b_int+1};              % binary encoding  
      
    % true answer  
    c_int = a_int + b_int;                    % int version  
    c     = int2binary{c_int+1};              % binary encoding  
      
    % where we'll store our best guess (binary encoded)  
    d     = zeros(size(c));  
    if length(d)<8  
        pause;  
    end  
      
    % total error  
    overallError = 0;  
      
    % difference in output layer, i.e., (target - out)  
    output_deltas = [];  
      
    % values of hidden layer, i.e., S(t)  
    hidden_layer_values = [];  
    cell_gate_values    = [];  
    % initialize S(0) as a zero-vector  
    hidden_layer_values = [hidden_layer_values; zeros(1, hidden_dim)];  
    cell_gate_values    = [cell_gate_values; zeros(1, hidden_dim)];  
      
    % initialize memory gate  
    % hidden layer  
    H = [];  
    H = [H; zeros(1, hidden_dim)];  
    % cell gate  
    C = [];  
    C = [C; zeros(1, hidden_dim)];  
    % in gate  
    I = [];  
    % forget gate  
    F = [];  
    % out gate  
    O = [];  
    % g gate  
    G = [];  
      
    % start to process a sequence, i.e., a forward pass  
    % Note: the output of a LSTM cell is the hidden_layer, and you need to   
    % transfer it to predicted output  
    for position = 0:binary_dim-1  
        % X ------> input, size: 1 x input_dim  
        X = [a(binary_dim - position)-'0' b(binary_dim - position)-'0'];  
          
        % y ------> label, size: 1 x output_dim  
        y = [c(binary_dim - position)-'0']';  
          
        % use equations (1)-(7) in a forward pass. here we do not use bias  
        in_gate     = sigmoid(X * X_i + H(end, :) * H_i + bi);  % equation (1)  
        forget_gate = sigmoid(X * X_f + H(end, :) * H_f + bf);  % equation (2)  
        out_gate    = sigmoid(X * X_o + H(end, :) * H_o + bo);  % equation (3)  
        g_gate      = tan_h(X * X_g + H(end, :) * H_g + bg);    % equation (4)  
        C_t         = C(end, :) .* forget_gate + g_gate .* in_gate;    % equation (5)  
        H_t         = tan_h(C_t) .* out_gate;                          % equation (6)  
          
        % store these memory gates  
        I = [I; in_gate];  
        F = [F; forget_gate];  
        O = [O; out_gate];  
        G = [G; g_gate];  
        C = [C; C_t];  
        H = [H; H_t];  
          
        % compute predict output  
        pred_out = sigmoid(H_t * out_para);  
          
        % compute error in output layer  
        output_error = y - pred_out;  
          
        % compute difference in output layer using derivative  
        % output_diff = output_error * sigmoid_output_to_derivative(pred_out);  
        output_deltas = [output_deltas; output_error];%*sigmoid_output_to_derivative(pred_out)];  
%         output_deltas = [output_deltas; output_error*(pred_out)];  
        % compute total error  
        % note that if the size of pred_out or target is 1 x n or m x n,  
        % you should use other approach to compute error. here the dimension   
        % of pred_out is 1 x 1  
        overallError = overallError + abs(output_error(1));  
          
        % decode estimate so we can print it out  
        d(binary_dim - position) = round(pred_out);  
    end  
      
    % from the last LSTM cell, you need a initial hidden layer difference  
    future_H_diff = zeros(1, hidden_dim);  
      
    % stare back-propagation, i.e., a backward pass  
    % the goal is to compute differences and use them to update weights  
    % start from the last LSTM cell  
    for position = 0:binary_dim-1  
        X = [a(position+1)-'0' b(position+1)-'0'];  
          
        % hidden layer  
        H_t = H(end-position, :);         % H(t)  
        % previous hidden layer  
        H_t_1 = H(end-position-1, :);     % H(t-1)  
        C_t = C(end-position, :);         % C(t)  
        C_t_1 = C(end-position-1, :);     % C(t-1)  
        O_t = O(end-position, :);  
        F_t = F(end-position, :);  
        G_t = G(end-position, :);  
        I_t = I(end-position, :);  
          
        % output layer difference  
        output_diff = output_deltas(end-position, :);  
          
        % hidden layer difference  
        % note that here we consider one hidden layer is input to both  
        % output layer and next LSTM cell. Thus its difference also comes  
        % from two sources. In some other method, only one source is taken  
        % into consideration.  
        % use the equation: delta(l) = (delta(l+1) * W(l+1)) .* f'(z) to  
        % compute difference in previous layers. look for more about the  
        % proof at http://neuralnetworksanddeeplearning.com/chap2.html  
%         H_t_diff = (future_H_diff * (H_i' + H_o' + H_f' + H_g') + output_diff * out_para') ...  
%                    .* sigmoid_output_to_derivative(H_t);  
  
  
        H_t_diff = output_diff * (out_para');% .* sigmoid_output_to_derivative(H_t);  
%         H_t_diff = output_diff * (out_para') .* sigmoid_output_to_derivative(H_t);  
%         future_H_diff = H_t_diff;  
%         out_para_diff = output_diff * (H_t) * sigmoid_output_to_derivative(out_para);  
        out_para_diff =  (H_t') * output_diff;%Êä³ö²ãÈ¨ÖØ  
  
  
        % out_gate diference  
        O_t_diff = H_t_diff .* tan_h(C_t) .* sigmoid_output_to_derivative(O_t);  
          
        % C_t difference  
        C_t_diff = H_t_diff .* O_t .* tan_h_output_to_derivative(C_t);  
          
%         % C(t-1) difference  
%         C_t_1_diff = C_t_diff .* F_t;  
          
        % forget_gate_diffeence  
        F_t_diff = C_t_diff .* C_t_1 .* sigmoid_output_to_derivative(F_t);  
          
        % in_gate difference  
        I_t_diff = C_t_diff .* G_t .* sigmoid_output_to_derivative(I_t);  
          
        % g_gate difference  
        G_t_diff = C_t_diff .* I_t .* tan_h_output_to_derivative(G_t);  
          
        % differences of X_i and H_i  
        X_i_diff =  X' * I_t_diff;% .* sigmoid_output_to_derivative(X_i);  
        H_i_diff =  (H_t_1)' * I_t_diff;% .* sigmoid_output_to_derivative(H_i);  
          
        % differences of X_o and H_o  
        X_o_diff = X' * O_t_diff;% .* sigmoid_output_to_derivative(X_o);  
        H_o_diff = (H_t_1)' * O_t_diff;% .* sigmoid_output_to_derivative(H_o);  
          
        % differences of X_o and H_o  
        X_f_diff = X' * F_t_diff;% .* sigmoid_output_to_derivative(X_f);  
        H_f_diff = (H_t_1)' * F_t_diff;% .* sigmoid_output_to_derivative(H_f);  
          
        % differences of X_o and H_o  
        X_g_diff = X' * G_t_diff;% .* tan_h_output_to_derivative(X_g);  
        H_g_diff = (H_t_1)' * G_t_diff;% .* tan_h_output_to_derivative(H_g);  
          
        % update  
        X_i_update = X_i_update + X_i_diff;  
        H_i_update = H_i_update + H_i_diff;  
        X_o_update = X_o_update + X_o_diff;  
        H_o_update = H_o_update + H_o_diff;  
        X_f_update = X_f_update + X_f_diff;  
        H_f_update = H_f_update + H_f_diff;  
        X_g_update = X_g_update + X_g_diff;  
        H_g_update = H_g_update + H_g_diff;  
        bi_update = bi_update + I_t_diff;  
        bo_update = bo_update + O_t_diff;  
        bf_update = bf_update + F_t_diff;  
        bg_update = bg_update + G_t_diff;                          
        out_para_update = out_para_update + out_para_diff;  
    end  
      
    X_i = X_i + X_i_update * alpha;   
    H_i = H_i + H_i_update * alpha;  
    X_o = X_o + X_o_update * alpha;   
    H_o = H_o + H_o_update * alpha;  
    X_f = X_f + X_f_update * alpha;   
    H_f = H_f + H_f_update * alpha;  
    X_g = X_g + X_g_update * alpha;   
    H_g = H_g + H_g_update * alpha;  
    bi = bi + bi_update * alpha;  
    bo = bo + bo_update * alpha;  
    bf = bf + bf_update * alpha;  
    bg = bg + bg_update * alpha;  
    out_para = out_para + out_para_update * alpha;  
      
    X_i_update = X_i_update * 0;   
    H_i_update = H_i_update * 0;  
    X_o_update = X_o_update * 0;   
    H_o_update = H_o_update * 0;  
    X_f_update = X_f_update * 0;   
    H_f_update = H_f_update * 0;  
    X_g_update = X_g_update * 0;   
    H_g_update = H_g_update * 0;  
    bi_update = 0;  
    bf_update = 0;  
    bo_update = 0;  
    bg_update = 0;  
    out_para_update = out_para_update * 0;  
      
    if(mod(j,1000) == 0)  
        if 1%overallError > 1  
            err = sprintf('Error:%s\n', num2str(overallError)); fprintf(err);  
        end  
        allErr = [allErr overallError];  
%         try  
            d = bin2dec(num2str(d));  
%         catch  
%             disp(d);  
%         end  
        if 1%overallError>1  
        pred = sprintf('Pred:%s\n',dec2bin(d,8)); fprintf(pred);  
        Tru = sprintf('True:%s\n', num2str(c)); fprintf(Tru);  
        end  
        out = 0;  
        tmp = dec2bin(d,8);  
        for i = 1:8             
            out = out + str2double(tmp(8-i+1)) * power(2,i-1);  
        end  
        if 1%overallError>1  
        fprintf('%d + %d = %d\n',a_int,b_int,out);  
        sep = sprintf('-------%d------\n', j); fprintf(sep);  
        end  
    end  
end  
figure;plot(allErr);  

