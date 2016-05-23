% Oswaldo Fratini Filho
%
% Fuction to calculate the Amari Error
%
% This function measures the error between a matrix and its inverse estimated 
function e = amari_error(W, wm, A)
    if size(A) ~= size(W)
        disp('amari_error function: A and W does not have same size!') 
    elseif size(A,1) ~= size(A,2)
        disp('amari_error function: A is not a square matrix!')
    elseif size(W,1) ~= size(W,2)
        disp('amari_error function: W is not a square matrix!')
    end
  
    sum = 0;
    e = 0;
    P = W'*wm*A;
    P = P/norm(P);
    
    for i = 1:size(P,1)
        sum = 0;
        maxk = max(abs(P(i,:)));
        for j = 1:size(P,2)
            sum = sum + abs(P(i,j))/maxk;
        end
        e = e + (sum - 1);
    end
    
    for j = 1:size(P,1)
        sum = 0;
        maxk = max(abs(P(:,j)));
        for i = 1:size(P,2)
            sum = sum + abs(P(i,j))/maxk;
        end
        e = e + (sum - 1);
    end

end
    
