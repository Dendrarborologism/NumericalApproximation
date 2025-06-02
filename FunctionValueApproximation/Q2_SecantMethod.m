% Q2: Secant method for x = 1/2 + sin(x) near x = 1.5
function Q2_SecantMethod()
    %rearrange to standard form f(x) = 0
    f = @(x) x - 0.5 - sin(x);
    
    %initial guesses near 1.5
    x0 = 1.4;
    x1 = 1.6;
    
    %params
    max_iter = 100;
    tol = 1e-7;
    
    %secant method iteration
    fprintf('Q2: Secant Method\n');
    fprintf('Iteration\t x\t\t f(x)\n');
    
    fprintf('0\t\t %.8f\t %.8f\n', x0, f(x0));
    fprintf('1\t\t %.8f\t %.8f\n', x1, f(x1));
    
    for i = 2:max_iter
        fx0 = f(x0);
        fx1 = f(x1);
        
        if abs(fx1) < tol
            break;
        end
        
        % Secant formula
        if abs(fx1 - fx0) < eps
            fprintf('Divided by zero\n');
            break;
        end
        
        x2 = x1 - fx1*(x1 - x0)/(fx1 - fx0);
        
        fprintf('%d\t\t %.8f\t %.8f\n', i, x2, f(x2));
        
        if abs(x2 - x1) < tol
            break;
        end
        
        % Update values for next iteration
        x0 = x1;
        x1 = x2;
    end
    
    fprintf('The root near x = 1.5 is approximately %.8f\n\n', x1);
    fprintf('Verification: f(%.8f) = %.8f\n', x1, f(x1));
    fprintf('Original equation: %.8f = %.8f\n\n', x1, 0.5 + sin(x1));
end