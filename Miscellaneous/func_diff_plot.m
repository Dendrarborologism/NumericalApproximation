function [diff, plotHandle] = func_diff_plot(func, x_range)
    %calculate the maximum and minimum values over the range
    t_values = linspace(x_range(1), x_range(2), 1000);  % Evaluate over a finely spaced range
    y_values = func(t_values);  %get the function values
    
    %find the difference between max and min
    diff = max(y_values) - min(y_values);
    
    %generate the plot
    figure;  % Create a new figure
    plotHandle = plot(t_values, y_values);
    xlabel('t');  
    ylabel('f(t)');  
    title('Plot of f(t)');  
    grid on; 
end