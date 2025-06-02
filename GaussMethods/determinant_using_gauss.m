function det_A = determinant_using_gauss(A)
    %calculate determinant using Gauss Elimination with partial pivoting
    %A - square matrix
    %det_A - determinant of A
    
    %check if matrix is square
    [n, m] = size(A);
    if n ~= m
        error('Matrix must be square to calculate determinant');
    end
    %copy the matrix
    A_copy = A;
    det_A = 1;
    p = 0;
    
    %forward elimination with partial pivoting
    for k = 1:n-1
        %partial pivoting
        [~, max_row] = max(abs(A_copy(k:n, k)));
        max_row = max_row + k - 1;
        if max_row ~= k
            A_copy([k, max_row], :) = A_copy([max_row, k], :);
            p = p + 1;
        end
        
        %if pivot is zero, determinant is zero
        if abs(A_copy(k,k)) < eps
            det_A = 0;
            return;
        end
        
        %update determinant with pivot
        det_A = det_A * A_copy(k,k);
        
        %elimination
        for i = k+1:n
            multiplier = A_copy(i,k) / A_copy(k,k);
            A_copy(i,k:n) = A_copy(i,k:n) - multiplier * A_copy(k,k:n);
        end
    end
    
    % Multiply by the last diagonal element
    det_A = det_A * A_copy(n,n);
    
    % Adjust for row exchanges (each exchange changes sign)
    det_A = det_A * (-1)^p;
end
