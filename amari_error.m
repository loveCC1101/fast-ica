% Oswaldo Fratini Filho
% ICA study
%
% Fuction to calculate the Amari Error
%
% This function measures the error between a matrix and its inverse estimated 
function e = amari_error(A, W)
    if size(A) ~= size(W)
        disp('amari_error function: A and W does not have same size!') 
    elseif size(A,1) ~= size(A,2)
        disp('amari_error function: A is not a square matrix!')
    elseif size(W,1) ~= size(W,2)
        disp('amari_error function: W is not a square matrix!')
    end
   
    e = 0;
    sum = 0;
    P = A*W;
    
    for i = 1:size(P,1)
        maxk = max(P(i,:));
        for j = 1:size(P,2)
            sum = sum + P(i,j)/maxk;
        end
        sum = sum - 1;
    end
    
    e = sum;
    sum = 0;
    
    for j = 1:size(P,1)
        maxk = max(P(:,j));
        for i = 1:size(P,2)
            sum = sum + P(i,j)/maxk;
        end
        sum = sum - 1;
    end
    
    e = e + sum;
end
    
    
        