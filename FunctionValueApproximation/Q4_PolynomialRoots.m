%Q4: Find all roots of the polynomial
function Q4_PolynomialRoots()
    %define the polynomial function
    f = @(x) x^5 - 2.4*x^4 - 16.04*x^3 + 12.096*x^2 + 17.056*x - 7.68;
    
    fprintf('Q4: Finding all roots of x^5 - 2.4x^4 - 16.04x^3 + 12.096x^2 + 17.056x - 7.68 = 0\n\n');
    
    %incremental search to find intervals containing roots
    fprintf('Incremental Search for Root Bracketing:\n');
    a = -5;  %lower search bound
    b = 5;   %upper search bound
    step = 0.1;  %atep size
    
    intervals = [];
    
    x = a;
    f_prev = f(x);
    
    fprintf('Searching for sign changes in [%.1f, %.1f] with step %.1f\n', a, b, step);
    fprintf('Intervals containing roots:\n');
    
    while x < b
        x_next = x + step;
        f_next = f(x_next);
        
        if f_prev * f_next <= 0
            fprintf('[%.2f, %.2f] - f(%.2f) = %.6f, f(%.2f) = %.6f\n', x, x_next, x, f_prev, x_next, f_next);
            intervals = [intervals; x, x_next];
        end
        
        x = x_next;
        f_prev = f_next;
    end
    
    fprintf('Found %d intervals containing roots\n\n', size(intervals, 1));
    
    %(i) Bisection method for each interval
    fprintf('(i) Bisection Method for each interval:\n');
    bisection_roots = [];
    
    for i = 1:size(intervals, 1)
        a = intervals(i, 1);
        b = intervals(i, 2);
        
        % Parameters
        max_iter = 100;
        tol = 1e-6;
        
        fprintf('Interval %d: [%.2f, %.2f]\n', i, a, b);
        
        for j = 1:max_iter
            c = (a + b)/2;
            fc = f(c);
            
            if abs(fc) < tol || (b - a)/2 < tol
                bisection_roots = [bisection_roots; c];
                fprintf('Root found: %.8f with f(x) = %.8f\n', c, fc);
                break;
            end
            
            if f(a)*fc < 0
                b = c;
            else
                a = c;
            end
        end
    end
    
    fprintf('\nBisection method found %d roots:\n', length(bisection_roots));
    for i = 1:length(bisection_roots)
        fprintf('Root %d: %.8f with f(x) = %.8e\n', i, bisection_roots(i), f(bisection_roots(i)));
    end
    fprintf('\n');
    
    %(ii) secant method for each interval
    fprintf('(ii)Secant Method for each interval:\n');
    secant_roots = [];
    
    for i = 1:size(intervals, 1)
        a = intervals(i, 1);
        b = intervals(i, 2);
        
        %params
        max_iter = 100;
        tol = 1e-6;
        
        fprintf('Interval %d: [%.2f, %.2f]\n', i, a, b);
        
        x0 = a;
        x1 = b;
        
        for j = 1:max_iter
            fx0 = f(x0);
            fx1 = f(x1);
            
            if abs(fx1) < tol
                secant_roots = [secant_roots; x1];
                fprintf('Root found: %.8f with f(x) = %.8e\n', x1, fx1);
                break;
            end
            
            %secant formula
            if abs(fx1 - fx0) < eps
                fprintf('Divided by zero\n');
                break;
            end
            
            x2 = x1 - fx1*(x1 - x0)/(fx1 - fx0);
            
            % Check if converged
            if abs(x2 - x1) < tol
                secant_roots = [secant_roots; x2];
                fprintf('Root found: %.8f with f(x) = %.8e\n', x2, f(x2));
                break;
            end
            
            %update values for next iteration
            x0 = x1;
            x1 = x2;
        end
    end
    
    fprintf('\nSecant method found %d roots:\n', length(secant_roots));
    for i = 1:length(secant_roots)
        fprintf('Root %d: %.8f with f(x) = %.8e\n', i, secant_roots(i), f(secant_roots(i)));
    end
    fprintf('\n');
    
    %verification using MATLAB's built-in roots function
    fprintf('Verification using MATLAB built-in roots function:\n');
    p = [1 -2.4 -16.04 12.096 17.056 -7.68];
    r = roots(p);
    
    fprintf('MATLAB roots function found:\n');
    for i = 1:length(r)
        fprintf('Root %d: %.8f + %.8fi with |f(x)| = %.8e\n', i, real(r(i)), imag(r(i)), abs(polyval(p, r(i))));
    end
end