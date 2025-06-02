function x = gauss_jordan_elimination(A, b)
    %solve a system of equations using Gauss-Jordan Elimination
    %A - coefficient matrix
    %b - right-hand side vector
    %x - solution vector
    
    %combine A and b
    Ab = [A b];
    
    %get the size of the matrix
    [n, m] = size(Ab);
    
    %forward elimination with partial pivoting
    for k = 1:n
        %partial pivot
        [~, max_row] = max(abs(Ab(k:n, k)));
        max_row = max_row + k - 1;
        if max_row ~= k
            Ab([k, max_row], :) = Ab([max_row, k], :);
        end
        
        %normalize the pivot row
        pivot = Ab(k,k);
        Ab(k,:) = Ab(k,:) / pivot;
        
        %eliminate all other rows
        for i = 1:n
            if i ~= k
                multiplier = Ab(i,k);
                Ab(i,:) = Ab(i,:) - multiplier * Ab(k,:);
            end
        end
    end
    
    %get the solution
    x = Ab(:,end);
end