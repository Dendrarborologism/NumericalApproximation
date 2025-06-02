%Q1: Newton-Raphson method for x^3 - 5x + 3 = 0
function Q1_NewtonRaphson()
    %define the function and its derivative
    f = @(x) x^3 - 5*x + 3;
    df = @(x) 3*x^2 - 5;
    
    %initial guess
    x0 = 0.5;  % Starting near the origin to find smallest positive root
    
    %params
    max_iter = 100;
    tol = 1e-6;
    
    %Newton-Raphson iteration
    fprintf('Q1: Newton-Raphson Method\n');
    fprintf('Iteration\t x\t\t f(x)\n');
    
    x = x0;
    for i = 1:max_iter
        fx = f(x);
        fprintf('%d\t\t %.8f\t %.8f\n', i, x, fx);
        
        if abs(fx) < tol
            break;
        end
        
        dfx = df(x);
        if abs(dfx) < eps
            fprintf('Derivative too small, method fails\n');
            break;
        end
        
        x_new = x - fx/dfx;
        if abs(x_new - x) < tol
            x = x_new;
            fprintf('%d\t\t %.8f\t %.8f\n', i+1, x, f(x));
            break;
        end
        
        x = x_new;
    end
    
    fprintf('The smallest positive root is approximately %.8f\n\n', x);    
    fprintf('Verification: f(%.8f) = %.8f\n\n', x, f(x));
end