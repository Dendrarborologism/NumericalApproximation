function [A_triangular, p] = gauss_elimination_partial_pivoting(A)
    %Gauss Elimination with partial pivoting
    %A - matrix to be triangularized
    %A_triangular - upper triangular matrix
    %p - number of row exchanges (for determinant calculation)
    
    %get the size of the matrix 
    [n, m] = size(A);
    
    %make a copy
    A_triangular = A;
    
    p = 0;
    
    %loop through each column (pivot column)
    for k = 1:min(n-1, m)
        %partial pivot
        [A_triangular, row_exchange] = partial_pivot(A_triangular, k, n);
        p = p + row_exchange;
        
        %loop through each row below the pivot
        for i = k+1:n
            %calculate the multiplier
            multiplier = A_triangular(i,k) / A_triangular(k,k);
            
            %eliminate the element below the pivot
            A_triangular(i,k:m) = A_triangular(i,k:m) - multiplier * A_triangular(k,k:m);
        end
    end
end

function [A, row_exchange] = partial_pivot(A, k, n)
    %implement partial pivoting
    %A - current matrix
    %k - current column
    %n - number of rows
    %utput A - matrix after pivoting
    %output row_exchange - 1 if rows were exchanged, 0 otherwise
    
    row_exchange = 0;
    
    %find the position of the maximum absolute value in the current column
    [~, max_row] = max(abs(A(k:n, k)));
    max_row = max_row + k - 1; %adjust index
    
    %swap rows if necessary
    if max_row ~= k
        A([k, max_row], :) = A([max_row, k], :);
        row_exchange = 1;
    end
end
