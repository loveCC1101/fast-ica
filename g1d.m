% Oswaldo Fratini Filho
% ICA study
%
% Fuction to calculate the approximation of negentropy
% g1d(u) = g1'(u)
function y = g1d(u)
    a1 = 1;
    y = a1*(1-tanh(a1*u)^2);
end
