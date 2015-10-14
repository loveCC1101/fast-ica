% Aluno: Oswaldo Fratini Filho
% ICA study
% 
% Function to calculate the approximation of negentropy
%
% g2d(u) = g2'(u)
%
function y = g2d(u)
    y = 1 * exp((-u^2)/2) + u^2 * exp((-u^2)/2);
end