%Q5: Find values of t where I = 3.5 in I = 9e^(-t)sin(2πt)
function Q5_CurrentEquation()
    %I(t) - 3.5 = 0
    f = @(t) 9*exp(-t)*sin(2*pi*t) - 3.5;
    
    fprintf('\n\nQ5: Finding values of t such that I = 3.5 in I = 9e^(-t)sin(2πt)\n\n');
    
    %incremental search to find intervals containing roots
    fprintf('\nIncremental Search for Root Bracketing:\n');
    a = 0;  %ower search bound
    b = 5;  %upper search bound
    step = 0.05;  %step size
    
    intervals = [];
    
    t = a;
    f_prev = f(t);
    
    fprintf('Searching for sign changes in [%.1f, %.1f] with step %.2f\n', a, b, step);
    fprintf('Intervals containing roots:\n');
    
    while t < b
        t_next = t + step;
        f_next = f(t_next);
        
        if f_prev * f_next <= 0
            fprintf('[%.2f, %.2f] - f(%.2f) = %.6f, f(%.2f) = %.6f\n', t, t_next, t, f_prev, t_next, f_next);
            intervals = [intervals; t, t_next];
        end
        
        t = t_next;
        f_prev = f_next;
    end
    
    fprintf('Found %d intervals containing roots\n\n', size(intervals, 1));
    
    %bisection method for each interval to refine roots
    fprintf('Bisection Method for Each Interval:\n');
    roots_t = [];
    
    for i = 1:size(intervals, 1)
        a = intervals(i, 1);
        b = intervals(i, 2);
        
        %params
        max_iter = 100;
        tol = 1e-8;
        
        fprintf('Interval %d: [%.2f, %.2f]\n', i, a, b);
        
        for j = 1:max_iter
            c = (a + b)/2;
            fc = f(c);
            
            if abs(fc) < tol || (b - a)/2 < tol
                roots_t = [roots_t; c];
                fprintf('Solution found: t = %.8f with I = %.8f\n', c, 9*exp(-c)*sin(2*pi*c));
                break;
            end
            
            if f(a)*fc < 0
                b = c;
            else
                a = c;
            end
        end
    end
    
    fprintf('\nFinal solutions for I = 3.5:\n');
    for i = 1:length(roots_t)
        fprintf('t_%d = %.8f with I = %.8f\n', i, roots_t(i), 9*exp(-roots_t(i))*sin(2*pi*roots_t(i)));
    end
    
end