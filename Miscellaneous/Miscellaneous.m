%Q1
t = 0:1/16:100; 
x = sin(t).*(exp(cos(t))-2*cos(4*t)-(sin(t/12)).^5);
y = cos(t).*(exp(cos(t))-2*cos(4*t)-(sin(t/12)).^5);

subplot(2,1,1); 
plot(t, x, '', t, y, '--');
title('x and y vs t'); 
xlabel('x'); 
ylabel('y'); 
legend('x', 'y'); 

subplot(2,1,2); 
plot(x, y);
axis square; 
title('y vs x'); 
xlabel('x'); 
ylabel('y');

figure; 

%Q2
angle = 15:15:75; 
distance = 0:5:80; 
v_0 = 28; 
y_0 = 0; 
g = 9.81; 
results = zeros(length(distance), length(angle)); 
for i = 1:length(distance)
    for j = 1:length(angle)
        dist = distance(i); 
        ang = deg2rad(angle(j));
        results(i, j) = tan(ang)*dist - ( dist^2 * (g/(2*v_0^2*(cos(ang))^2)) ) + y_0;
        fprintf("Results(%d, %d) = %f\n", i, j, results(i, j)); 
        %fprintf("i, j = %d, %d\n", idx1, idx2); 
    end
end

hold on;  %keep all plots on the same figure
for j = 1:length(angle)
    plot(distance, results(:, j), 'DisplayName', sprintf('Angle = %d°', angle(j)));
end
xlabel('Horizontal Distance (m)');
ylabel('Height (m)');
title('Trajectories of an Object at Different Angles');
legend('show');
axis([0 80 0 inf]);

%Q3
%fill in the channel table 
channel_data = zeros(5, 4); 
channel_data(1, 1) = 0.035;
channel_data(1, 2) = 0.0001; 
channel_data(1, 3) = 10; 
channel_data(1, 4) = 2; 
channel_data(2, 1) = 0.020;
channel_data(2, 2) = 0.0002; 
channel_data(2, 3) = 8; 
channel_data(2, 4) = 1; 
channel_data(3, 1) = 0.015;
channel_data(3, 2) = 0.0010; 
channel_data(3, 3) = 20; 
channel_data(3, 4) = 1.5; 
channel_data(4, 1) = 0.030;
channel_data(4, 2) = 0.0007; 
channel_data(4, 3) = 24; 
channel_data(4, 4) = 3; 
channel_data(5, 1) = 0.022;
channel_data(5, 2) = 0.0003; 
channel_data(5, 3) = 15; 
channel_data(5, 4) = 2.5; 

velocities = (sqrt(channel_data(:, 2)) ./ channel_data(:, 1)) .* ( (channel_data(:, 3) .* channel_data(:, 4)) ./ (channel_data(:, 3) + 2*channel_data(:, 4)) ).^(2/3); 
disp(velocities);  

%Q4
f_t = @(t) 8 * exp(-0.25*t) .* sin(t-2);  %define the function for part (a)
[diff_t, plot_t] = func_diff_plot(f_t, [0, 6*pi]); 

%display result
fprintf('Difference between max and min (f_t): %f\n', diff_t);

f_x = @(x) exp(4*x).*sin(1./x);  %define the function for part (b)
[diff_x, plot_x] = func_diff_plot(f_x, [0.01, 0.2]); 

%display result
fprintf('Difference between max and min for (f_x): %f\n', diff_x);

%Q5
t_values = linspace(0, 30, 1000);  %time range from 0 to 30 with 1000 points

%compute the corresponding velocity values
v_values = arrayfun(@rocket_velocity, t_values);  %apply the rocket_velocity function for each t value

%plot
figure;
plot(t_values, v_values);
xlabel('Time (t)');
ylabel('Velocity (v)');
title('Rocket Velocity vs Time');
grid on;
