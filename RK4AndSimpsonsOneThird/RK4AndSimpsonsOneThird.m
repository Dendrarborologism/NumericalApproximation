%Q2: RK4 to solve velocity and Simpson's 1/3 Rule to find distance
clc;
clear;
close all;
%given parameters
u0 = 1;            %initial velocity (m/s)
t0 = 0;            %initial time (s)
T = 20;            %final time (s)
dt = 0.01;         %time step (s)
N = (T - t0) / dt; %number of steps
%preallocate arrays
t = linspace(t0, T, N+1);
u = zeros(1, N+1);
u(1) = u0;
%derivative function (du/dt)
f = @(t, u) exp(-0.25*t) * cos(8*t) - exp(-0.25*t) * sin(8*t);
%solve using RK4
for i = 1:N
    k1 = f(t(i), u(i));
    k2 = f(t(i) + dt/2, u(i) + k1*dt/2);
    k3 = f(t(i) + dt/2, u(i) + k2*dt/2);
    k4 = f(t(i) + dt, u(i) + k3*dt);
    
    u(i+1) = u(i) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
end
%use Simpson's 1/3 rule to find distance
%s = integral of |u| over time
%check that N is even 
if mod(N, 2) ~= 0
    error('Number of intervals must be even for Simpson''s 1/3 rule.');
end
%apply Simpson's 1/3 rule to calculate distance
s = zeros(1, N+1);
for i = 3:2:N+1
    s(i) = s(i-2) + (dt/3)*(abs(u(i-2)) + 4*abs(u(i-1)) + abs(u(i)));
end
%fill in the intermediate points (even indices except 1)
for i = 2:2:N
    s(i) = s(i-1) + (dt/2)*(abs(u(i-1)) + abs(u(i)));
end
%plot Velocity vs Time
figure;
plot(t, u, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity vs Time');
grid on;
%plot Distance vs Time
figure;
plot(t, s, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Distance (m)');
title('Distance vs Time');
grid on;
%display final distance traveled
fprintf('Total distance traveled in %.2f seconds: %.4f meters\n', T, s(end));
