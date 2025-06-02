%Q1
fprintf('Testing Naïve Gauss Elimination:\n');

A1 = [-1, 2, 0.5; 
      0.3, -3, -1; 
      -3, 0.4, -2];
      
fprintf('First test matrix:\n');
disp(A1);

A1_triangular = naive_gauss_elimination(A1);
fprintf('Result after Naïve Gauss Elimination:\n');
disp(A1_triangular);

A2 = [1, -3, 0.2, 4, 8;
      0.6, 2, -2, 1, 5;
      4, 3, 0.4, -8, 7;
      2, -0.4, 3, -2, 10;
      -2, 3, -0.5, 3, 6];
      
fprintf('Second test matrix:\n');
disp(A2);

A2_triangular = naive_gauss_elimination(A2);
fprintf('Result after Naïve Gauss Elimination:\n');
disp(A2_triangular);

%Q2

fprintf('Testing Gauss Elimination with Partial Pivoting:\n');

A1 = [-0.1, 0.3, 0.5; 
      3, 2, -1; 
      -3, 4, -2];
      
fprintf('First test matrix:\n');
disp(A1);

[A1_triangular, p1] = gauss_elimination_partial_pivoting(A1);
fprintf('Result after Gauss Elimination with Partial Pivoting:\n');
disp(A1_triangular);
fprintf('Number of row exchanges: %d\n', p1);

A2 = [0.01, 0, 0.2, 4, 8;
      0.6, 2, -2, 1, 5;
      0.14, 0.3, 0.4, -8, 7;
      -1.2, -0.4, 3, -2, -2;
      -2.1, 3, -0.5, 3, 6];
      
fprintf('Second test matrix:\n');
disp(A2);

[A2_triangular, p2] = gauss_elimination_partial_pivoting(A2);
fprintf('Result after Gauss Elimination with Partial Pivoting:\n');
disp(A2_triangular);
fprintf('Number of row exchanges: %d\n', p2);

%Q3

%set up the system matrix and right-hand side vector
% wehre i12, i52, i32, i65, i43, i54 are the variables
A = [1, 1, 1, 0, 0, 0;
     0, -1, 0, 1, 0, -1;
     0, 0, -1, 0, 1, 0;
     0, 0, 0, 0, -1, 1;
     0, 10, -10, 0, -5, -15;
     5, -10, 0, -20, 0, 0];
     
b = [0; 0; 0; 0; 0; 200];

fprintf('Q3: Solving System of Equations\n');
fprintf('Coefficient matrix A:\n');
disp(A);
fprintf('Right-hand side vector b:\n');
disp(b);

solution = gauss_elimination_solve(A, b);
fprintf('Solution using Gauss Elimination:\n');
fprintf('i12 = %.4f\n', solution(1));
fprintf('i52 = %.4f\n', solution(2));
fprintf('i32 = %.4f\n', solution(3));
fprintf('i65 = %.4f\n', solution(4));
fprintf('i43 = %.4f\n', solution(5));
fprintf('i54 = %.4f\n', solution(6));

%check using MATLAB left division
matlab_solution = A\b;
fprintf('\nSolution using MATLAB left division:\n');
fprintf('i12 = %.4f\n', matlab_solution(1));
fprintf('i52 = %.4f\n', matlab_solution(2));
fprintf('i32 = %.4f\n', matlab_solution(3));
fprintf('i65 = %.4f\n', matlab_solution(4));
fprintf('i43 = %.4f\n', matlab_solution(5));
fprintf('i54 = %.4f\n', matlab_solution(6));

%Q4

A = [0.02, -0.3, 0.2, 4, 8;
     0.6, 0.2, -2, 10, 5;
     -2.2, 0.3, 0.4, -8, 7;
     2, -0.4, 10, -2, -2;
     -2, 3, -0.5, 3, 6];
     
fprintf('Q4: Calculate Determinant\n');
fprintf('Matrix A:\n');
disp(A);

my_det = determinant_using_gauss(A);
fprintf('Determinant using Gauss Elimination: %.6f\n', my_det);

%calculate determinant using MATLAB built-in function
matlab_det = det(A);
fprintf('Determinant using MATLAB det(): %.6f\n', matlab_det);

%Q5

A = [-8, 1, -2;
     2, -6, -1;
     -3, -1, 7];
     
b = [-20; -38; -34];

fprintf('Q5: Gauss-Jordan Elimination\n');
fprintf('Coefficient matrix A:\n');
disp(A);
fprintf('Right-hand side vector b:\n');
disp(b);

solution = gauss_jordan_elimination(A, b);
fprintf('Solution using Gauss-Jordan Elimination:\n');
fprintf('x1 = %.4f\n', solution(1));
fprintf('x2 = %.4f\n', solution(2));
fprintf('x3 = %.4f\n', solution(3));

%heck using MATLAB left division
matlab_solution = A\b;
fprintf('\nSolution using MATLAB left division:\n');
fprintf('x1 = %.4f\n', matlab_solution(1));
fprintf('x2 = %.4f\n', matlab_solution(2));
fprintf('x3 = %.4f\n', matlab_solution(3));