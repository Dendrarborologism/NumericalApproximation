function x = gauss_elimination_solve(A, b)
    %solve a system of equations using Gauss Elimination
    %A - coefficient matrix
    %b - right-hand side vector
    %x - solution vector
    
    %combine A and b
    Ab = [A b];
    
    %get the size of the matrix
    [n, m] = size(Ab);
    
    %forward elimination (with partial pivoting)
    for k = 1:n-1
        %partial pivot
        [~, max_row] = max(abs(Ab(k:n, k)));
        max_row = max_row + k - 1;
        if max_row ~= k
            Ab([k, max_row], :) = Ab([max_row, k], :);
        end
        
        %elimination
        for i = k+1:n
            multiplier = Ab(i,k) / Ab(k,k);
            Ab(i,k:m) = Ab(i,k:m) - multiplier * Ab(k,k:m);
        end
    end
    
    %back substitution
    x = zeros(n, 1);
    for i = n:-1:1
        x(i) = (Ab(i,end) - Ab(i,i+1:n)*x(i+1:n)) / Ab(i,i);
    end
end