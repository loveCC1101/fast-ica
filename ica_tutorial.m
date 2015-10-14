% Oswaldo Fratini Filho
% ICA study
% Article: Independent Component Analysis: A Tutorial
% Autor: Aapo Hyvrinen and Erkki Oja

clear all
close all

% Create source 1 with uniform distribution
s1 = -1 + 2 * rand(100, 1)';

% Create source 2 with uniform distribution
s2 = -1 + 2 * rand(100, 1)';

t = [1:1:size(s2, 2)];

% create new figure
figure('Name', 'ICA Tutorial', 'NumberTitle', 'off', 'units','normalized','outerposition',[0 0 1 1]) 

% first subplot
subplot(2,4,1);
plot(t, s1, '-');
title('First step - Sources Signal - s1');
xlabel('s1');
ylabel('t');

% Second subplot
subplot(2,4,2);
plot(t, s2, '-');
title('Second step - Sources Signal - s2');
xlabel('s2');
ylabel('t');

% Third subplot
subplot(2,4,3);
plot(s1, s2, '.');
title('Third step - Sources Signal - s2 / s1');
xlabel('s1');
ylabel('s2');
axis([-2 2 -2 2]);

% Create source matrix
s = [s1;s2];

% Create mixing matrix
A = [2, 3; 2, 1];

% Create microfone 1 and 2 signals
x = A*s; 

% Fourth subplot
subplot(2,4,4); 
plot(x(1,:), x(2,:), '.');
title('Fourth step - Mixed signals - x2 / x1');
xlabel('x1');
ylabel('x2');
axis([-5 5 -5 5]);

% Centering
ex = mean(x, 2);
x(:,1) = x(:,1) - ex(1);
x(:,2) = x(:,2) - ex(2);

%Whitening
ce = cov(x');
[E, D] = eig(ce); 
wm = E * D^(-1/2) * E';
xhat = wm * x;
cm = cov(xhat');

% Fifth subplot
subplot(2,4,5); 
plot(xhat(1,:), xhat(2,:), '.');
title('Fifth step - Whitening - x2 / x1')
xlabel('x1');
ylabel('x2');
axis([-3 3 -3 3]);

W = fastica(xhat)

tmp1 = W(:,1)'*xhat;
tmp2 = W(:,2)'*xhat;

% Normalized signals divided by standard deviation 
% Signals potency divided by standard deviation are equal 1 becouse signal
% means equal 0. It isn't true if signals mean is diferent zero.
s1n = s1/std(s1);
s2n = s2/std(s2);
tmp1n = tmp1/std(tmp1);
tmp2n = tmp2/std(tmp2);

% Signals energy
s1ne = sum(abs(s1n).^2);
s2ne = sum(abs(s2n).^2);
tmp1ne = sum(abs(tmp1n).^2);
tmp2ne = sum(abs(tmp2n).^2);

disp(fprintf('Normalized Source 1 Energy = %f', s1ne));
disp(fprintf('Normalized Source 2 Energy = %f', s2ne));
disp(fprintf('Estimated and Normalized Source 1 Energy = %f', tmp1ne));
disp(fprintf('Estimated and Normalized Source 2 Energy = %f', tmp2ne));

W(:,1)' * wm * A / norm(W(:,1)' * wm * A)
W(:,2)' * wm * A / norm(W(:,2)' * wm * A)

if abs(s1ne - tmp1ne) < abs(s1ne - tmp2ne)
    se1n = tmp1n;
    se2n = tmp2n;
else
    se1n = tmp2n;
    se2n = tmp1n;
end

% Sixth subplot
subplot(2,4,6); 
plot(t, se1n, '-r');
hold;
plot(t, s1n, '-b');
title('Sixth step - Estimeted and Normalized Source')
xlabel('t');
ylabel('Normalized S1');

% Seventh subplot
subplot(2,4,7); 
plot(t, se2n, '-r');
hold;
plot(t, s2n, '-b');
title('Seventh step - Estimeted and Normalized Source')
xlabel('t');
ylabel('Normalized S2');
