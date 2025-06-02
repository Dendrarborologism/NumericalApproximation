%Q3: Find root of x = e^(-x) using multiple methods
function Q3_MultiMethods()
    %define the function in standard form f(x) = 0
    f = @(x) x - exp(-x);
    df = @(x) 1 + exp(-x);  %derivative for Newton-Raphson
    
    fprintf('Q3: Finding root of x = e^(-x)\n\n');
    
    % (i)bisection method
    fprintf('(i) Bisection Method:\n');
    
    a = 0.4;  %values close to 0.5 that bracket the root
    b = 0.6;
    
    if f(a)*f(b) > 0
        fprintf('Error: Function values at a and b must have opposite signs\n');
    else
        %params
        max_iter = 100;
        tol = 1e-6;
        
        fprintf('Iteration\t a\t\t b\t\t mid\t\t f(mid)\n');
        
        for i = 1:max_iter
            c = (a + b)/2;
            fc = f(c);
            
            fprintf('%d\t\t %.8f\t %.8f\t %.8f\t %.8f\n', i, a, b, c, fc);
            
            if abs(fc) < tol || (b - a)/2 < tol
                break;
            end
            
            if f(a)*fc < 0
                b = c;
            else
                a = c;
            end
        end
        
        fprintf('Bisection result: %.8f with f(x) = %.8f\n\n', c, fc);
    end
    
    %(ii) Newton-Raphson method
    fprintf('(ii) Newton-Raphson Method:\n');
    
    %initial guess
    x0 = 0.5;
    
    %parameters
    max_iter = 100;
    tol = 1e-6;
    
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
    
    fprintf('Newton-Raphson result: %.8f with f(x) = %.8f\n\n', x, f(x));
    
    %(iii) Modified Secant method
    fprintf('(iii) Modified Secant Method:\n');
    
    %initial guess
    x0 = 0.5;
    delta = 0.01;  %small perturbation
    
    %params
    max_iter = 100;
    tol = 1e-6;
    
    fprintf('Iteration\t x\t\t f(x)\n');
    
    x = x0;
    fprintf('0\t\t %.8f\t %.8f\n', x, f(x));
    
    for i = 1:max_iter
        fx = f(x);
        
        if abs(fx) < tol
            break;
        end
        
        %calculate perturbed value
        x_delta = x + delta;
        fx_delta = f(x_delta);
        
        %check if perturbation is too small
        if abs(fx_delta - fx) < eps
            fprintf('Difference too small, method fails\n');
            break;
        end
        
        %modified secant formula
        x_new = x - delta * fx / (fx_delta - fx);
        
        fprintf('%d\t\t %.8f\t %.8f\n', i, x_new, f(x_new));
        
        if abs(x_new - x) < tol
            x = x_new;
            break;
        end
        
        x = x_new;
    end
    
    fprintf('Modified Secant result: %.8f with f(x) = %.8f\n\n', x, f(x));
end