% Oswaldo Fratini Filho
% ICA study

clear all
close all

disp('Independent Component Analysis');

N = 0;
M = 0;

while N < 2 || N > 12
    N = input('Type number of sources N [2 -12]: ');
end

while M < 100 || M > 1000
    M = input('Type number of samples M [100 - 1000]: ');
end

% Create N number of source with uniform distribution
S = -1 + 2 * rand(M, N)';

t = [1:1:M];

% Create a invertible mixing matrix 
A = rand(N);
A = A'*A

% Mixing the sources
X = A*S; 

% Centering
ex = mean(X, 2);
for i = 1:N
	X(:,i) = X(:,i) - ex(i);
end

% Whitening
ce = cov(X');
[E, D] = eig(ce); 
WM = E * D^(-1/2) * E';
Xhat = WM * X;
cm = cov(Xhat');

% Estimating inverted A matrix
W = fastica(Xhat)

% Temporary estimated sources
TMP = zeros(size(X));
for i = 1:N
	TMP(i,:) = W(:,i)'*Xhat;
end

% Normalized signals divided by standard deviation 
% Signals potency divided by standard deviation are equal 1 becouse signal
% means equal 0. It isn't true if signals mean is diferent zero.
Sn = zeros(size(X));
TMPn = zeros(size(X));
for i = 1:N
	Sn(i,:) = S(i,:)/std(S(i,:));
	TMPn(i,:) = TMP(i,:)/std(TMP(i,:));
end

% Signals energy
Sne = zeros(N,1); 
TMPne = zeros(N,1); 
for i = 1:N
	Sne(i) = sum(abs(Sn(i,:)).^2);
	TMPne(i) = sum(abs(TMPn(i,:)).^2);
end 

% Print source signals energy
for i = 1:N
	disp(sprintf('Normalized Source %d Energy = %f', i, Sne(i)));
end

% Print estimated source signals energy
for i = 1:N
	disp(sprintf('Estimated and Normalized Source %d Energy = %f', i, TMPne(i)));
end

% Set correct signals
Sen = zeros(size(X));

l = 0;
for i = 1:N
    lastDif = 0;
    for j = 1:N
        % Independent Signals 
        covariance = cov(Sn(i,:)',TMPn(j,:)');
		if (covariance(1,2) > lastDif)
			lastDif = covariance(1,2);
			l = j;
		end 
	end 
	Sen(i,:) = TMPn(l, :);
end

W'*WM*A/norm(W'*WM*A)

% Plot signals 
if N <= 4
    fcolumn = 1;
    fline = N;
elseif N > 4 && N <=6 
    fcolumn = 2;
    fline = 3;
elseif N > 6 && N <=8 
    fcolumn = 2;
    fline = 4;
elseif N == 9
    fcolumn = 3;
    fline = 3;
else
    fcolumn = 3;
    fline = 4;
end

% create new figure
figure('Name', 'ICA', 'NumberTitle', 'off', 'units','normalized','outerposition',[0 0 1 1]) 
% create each subplot
for i = 1:N 
	subplot(fline,fcolumn,i); 
	plot(t, Sn(i,:), '-b');
	hold;
	plot(t, Sen(i,:), '-r');
	title('Estimated and Normalized Source')
	xlabel('t');
	ylabel(sprintf('s%d', i));
end

