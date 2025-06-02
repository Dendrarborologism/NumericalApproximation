%% Black Box Modeling using Linear Regression
%this script performs black box modeling of an unknown system using linear 
%least squares regression approach.

clear all; close all; clc;

%% Step 1: Load the data file and plot the output vs input
%load the data file
load('lsqfit_data.mat');

%plot the input vs output
figure;
plot(xin, yout, 'b.');
xlabel('Input (xin)');
ylabel('Output (yout)');
title('Output vs Input');
grid on;

%% Step 2: Split the data for train and test purposes

%total number of data points
N = length(xin);

%define the split ratios
split_ratios = [0.2, 0.5, 0.7];
split_names = {'20:80', '50:50', '70:30'};

%initialize variables to store results
best_orders = zeros(length(split_ratios), 1);
min_errors = zeros(length(split_ratios), 1);
max_order = 10; %maximum order to test

%initialize figures for test outputs and errors
figure_test = figure('Position', [100, 100, 1200, 800]);
figure_error = figure('Position', [100, 100, 1200, 800]);

%% Step 3 & 4: Find optimal model order and plot results for each split ratio
for s = 1:length(split_ratios)
    %calculate the number of training samples
    n_train = round(N * split_ratios(s));
    
    %split the data
    %training data
    xin_train = xin(1:n_train);
    yout_train = yout(1:n_train);
    t_train = t(1:n_train);
    
    %testing data
    xin_test = xin(n_train+1:end);
    yout_test = yout(n_train+1:end);
    t_test = t(n_train+1:end);
    
    %initialize variables to store errors for different orders
    test_errors = zeros(max_order, 1);
    best_predictions = [];
    
    %loop through different model orders
    for order = 1:max_order
        %create the Z matrix for training
        Z_train = zeros(n_train, order+1);
        for i = 0:order
            Z_train(:, i+1) = xin_train.^i;
        end
        
        %calculate the weight vector a using least squares
        a = (Z_train' * Z_train) \ (Z_train' * yout_train');
        
        %create the Z matrix for testing
        n_test = length(xin_test);
        Z_test = zeros(n_test, order+1);
        for i = 0:order
            Z_test(:, i+1) = xin_test.^i;
        end
        
        %calculate the predicted output
        yout_test_pred = Z_test * a;
        
        %calculate the testing error (Mean Squared Error)
        test_error = mean((yout_test' - yout_test_pred).^2);
        test_errors(order) = test_error;
        
        %save the best prediction
        if order == 1 || test_error < min_errors(s)
            min_errors(s) = test_error;
            best_orders(s) = order;
            best_predictions = yout_test_pred;
        end
    end
    
    %plot the test errors for different orders
    figure;
    plot(1:max_order, test_errors, 'o-');
    xlabel('Model Order (n)');
    ylabel('Test MSE');
    title(['Test Error vs Model Order for ' split_names{s} ' Split']);
    grid on;
    
    %plot the true output and predicted output for the best model order
    figure(figure_test);
    subplot(length(split_ratios), 1, s);
    plot(t_test, yout_test, 'b-', t_test, best_predictions, 'r--', 'LineWidth', 2);
    xlabel('Time');
    ylabel('Output');
    title(['True vs Predicted Output for ' split_names{s} ' Split (Order = ' num2str(best_orders(s)) ')']);
    legend('True Output', 'Predicted Output');
    grid on;
    
    %plot the error for the best model
    figure(figure_error);
    subplot(length(split_ratios), 1, s);
    plot(t_test, yout_test' - best_predictions, 'g-', 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('Error');
    title(['Prediction Error for ' split_names{s} ' Split (Order = ' num2str(best_orders(s)) ')']);
    grid on;
    
    %display the results
    fprintf('Split %s: Best Order = %d, Minimum Test MSE = %.6e\n', ...
        split_names{s}, best_orders(s), min_errors(s));
end

%% Step 5: Select the best model for 70:30 split and plot the comparison
%use the 70:30 split (which is the last one we processed)
n_train = round(N * split_ratios(end));

%split the data
xin_train = xin(1:n_train);
yout_train = yout(1:n_train);
t_train = t(1:n_train);

xin_test = xin(n_train+1:end);
yout_test = yout(n_train+1:end);
t_test = t(n_train+1:end);

%get the best order for 70:30 split
best_order = best_orders(end);

%create the Z matrix for training
Z_train = zeros(n_train, best_order+1);
for i = 0:best_order
    Z_train(:, i+1) = xin_train.^i;
end

%calculate the weight vector a using least squares
a = (Z_train' * Z_train) \ (Z_train' * yout_train');

%create the Z matrix for testing
n_test = length(xin_test);
Z_test = zeros(n_test, best_order+1);
for i = 0:best_order
    Z_test(:, i+1) = xin_test.^i;
end

%calculate the predicted output
yout_test_pred = Z_test * a;

%final plot for the 70:30 split
figure;
plot(t_test, yout_test, 'b-', t_test, yout_test_pred, 'r--', 'LineWidth', 2);
xlabel('Time');
ylabel('Output');
title(['Final Comparison: True vs Predicted Output for 70:30 Split (Order = ' num2str(best_order) ')']);
legend('True Output', 'Predicted Output');
grid on;

%display the weight vector
fprintf('\nOptimal weight vector for 70:30 split (Order = %d):\n', best_order);
for i = 0:best_order
    fprintf('a_%d = %.6e\n', i, a(i+1));
end

%calculate the final test MSE
final_mse = mean((yout_test' - yout_test_pred).^2);
fprintf('\nFinal Test MSE for 70:30 split: %.6e\n', final_mse);
