%DEMGP	Demonstrate simple regression using a Gaussian Process.
%
%	Description
%	The problem consists of one input variable X and one target variable
%	T. The values in X are chosen in two separated clusters and the
%	target data is generated by computing SIN(2*PI*X) and adding Gaussian
%	noise. Two Gaussian Processes, each with different covariance
%	functions are trained by optimising the hyperparameters  using the
%	scaled conjugate gradient algorithm.  The final predictions are
%	plotted together with 2 standard deviation error bars.
%
%	See also
%	GP, GPERR, GPFWD, GPGRAD, GPINIT, SCG
%

%	Copyright (c) Ian T Nabney (1996-2001)


% Find out if flops is available (i.e. pre-version 6 Matlab)
v = version;
if (str2num(strtok(v, '.')) >= 6)
    flops_works = logical(0);
else
    flops_works = logical(1);
end

randn('state', 42);
x = [0.1 0.15 0.2 0.25  0.65 0.7 0.75 0.8 0.85 0.9]';
ndata = length(x);
t = sin(2*pi*x) + 0.05*randn(ndata, 1);

xtest = linspace(0, 1, 50)';

clc
disp('This demonstration illustrates the use of a Gaussian Process')
disp('model for regression problems.  The data is generated from a noisy')
disp('sine function.')
disp(' ')
disp('Press any key to continue.')
pause

flops(0);
% Initialise the parameters.
net = gp(1, 'sqexp');
prior.pr_mean = 0;
prior.pr_var = 1;
net = gpinit(net, x, t, prior);

clc
disp('The first GP uses the squared exponential covariance function.')
disp('The hyperparameters are initialised by sampling from a Gaussian with a')
disp(['mean of ', num2str(prior.pr_mean), ' and variance ', ...
    num2str(prior.pr_var), '.'])
disp('After initializing the network, we train it using the scaled conjugate')
disp('gradients algorithm for 20 cycles.')
disp(' ')
disp('Press any key to continue')
pause

% Now train to find the hyperparameters.
options = foptions;
options(1) = 1;    % Display training error values
options(14) = 20;
flops(0)
[net, options] = netopt(net, options, x, t, 'scg');
if flops_works
    sflops = flops;
end

disp('The second GP uses the rational quadratic covariance function.')
disp('The hyperparameters are initialised by sampling from a Gaussian with a')
disp(['mean of ', num2str(prior.pr_mean), ' and variance ', num2str(prior.pr_var)])
disp('After initializing the network, we train it using the scaled conjugate')
disp('gradients algorithm for 20 cycles.')
disp(' ')
disp('Press any key to continue')
pause
flops(0)
net2 = gp(1, 'ratquad');
net2 = gpinit(net2, x, t, prior);
flops(0)
[net2, options] = netopt(net2, options, x, t, 'scg');
if flops_works
    rflops = flops;
end

disp(' ')
disp('Press any key to continue')
disp(' ')
pause
clc

fprintf(1, 'For squared exponential covariance function,');
if flops_works    
    fprintf(1, 'flops = %d', sflops);
end
fprintf(1, '\nfinal hyperparameters:\n')
format_string = strcat('  bias:\t\t\t%10.6f\n  noise:\t\t%10.6f\n', ...
  '  inverse lengthscale:\t%10.6f\n  vertical scale:\t%10.6f\n');
fprintf(1, format_string, ...
    exp(net.bias), exp(net.noise), exp(net.inweights(1)), exp(net.fpar(1)));
fprintf(1, '\n\nFor rational quadratic covariance function,');
if flops_works
    fprintf(1, 'flops = %d', rflops);
end
fprintf(1, '\nfinal hyperparameters:\n')
format_string = [format_string '  cov decay order:\t%10.6f\n'];
fprintf(1, format_string, ...
      exp(net2.bias), exp(net2.noise), exp(net2.inweights(1)), ...
      exp(net2.fpar(1)), exp(net2.fpar(2)));
disp(' ')
disp('Press any key to continue')
pause

disp(' ')
disp('Now we plot the data, underlying function, model outputs and two')
disp('standard deviation error bars on a single graph to compare the results.')
disp(' ')
disp('Press any key to continue.')
pause
cn = gpcovar(net, x); 
cninv = inv(cn);
[ytest, sigsq] = gpfwd(net, xtest, cninv);
sig = sqrt(sigsq);

fh1 = figure;
hold on
plot(x, t, 'ok');
xlabel('Input')
ylabel('Target')
fplot('sin(2*pi*x)', [0 1], '--m');
plot(xtest, ytest, '-k');
plot(xtest, ytest+(2*sig), '-b', xtest, ytest-(2*sig), '-b');
axis([0 1 -1.5 1.5]);
title('Squared exponential covariance function')
legend('data', 'function', 'GP', 'error bars');
hold off

cninv2 = inv(gpcovar(net2, x));
[ytest2, sigsq2] = gpfwd(net2, xtest, cninv2);
sig2 = sqrt(sigsq2);
fh2 = figure;
hold on
plot(x, t, 'ok');
xlabel('Input')
ylabel('Target')
fplot('sin(2*pi*x)', [0 1], '--m');
plot(xtest, ytest2, '-k');
plot(xtest, ytest2+(2*sig2), '-b', xtest, ytest2-(2*sig2), '-b');
axis([0 1 -1.5 1.5]);
title('Rational quadratic covariance function')
legend('data', 'function', 'GP', 'error bars');
hold off

disp(' ')
disp('Press any key to end.')
pause
close(fh1);
close(fh2);
clear all;