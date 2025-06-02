function A_triangular = naive_gauss_elimination(A)
    %Naïve Gauss Elimination without pivoting
    %A - matrix to be triangularized
    %A_triangular - upper triangular matrix
    
    %get the size of the matrix
    [n, m] = size(A);
    
    %make a copy
    A_triangular = A;
    
    %loop through each column (pivot column)
    for k = 1:min(n-1, m)
        %loop through each row below the pivot
        for i = k+1:n
            %calculate the multiplier
            if A_triangular(k,k) ~= 0
                multiplier = A_triangular(i,k) / A_triangular(k,k);
                
                %eliminate the element below the pivot
                A_triangular(i,k:m) = A_triangular(i,k:m) - multiplier * A_triangular(k,k:m);
            else
                fprintf('Warning: Zero pivot encountered at position (%d,%d)\n', k, k);
            end
        end
    end
end
