%parameters
p = 0.8; q = 0.04; r = 0.12; s = 0.45;
x0 = 105; y0 = 8;
t0 = 0; tf = 200;
h = 0.1;
t = t0:h:tf;
N = length(t);

x_heun = zeros(1, N); y_heun = zeros(1, N);
x_rk4 = zeros(1, N); y_rk4 = zeros(1, N);

%initial conditions
x_heun(1) = x0; y_heun(1) = y0;
x_rk4(1) = x0; y_rk4(1) = y0;

%define functions
fx = @(x,y) p*x - q*x*y;
fy = @(x,y) -s*y + r*x*y;

%Heun's Method
for i = 1:N-1
    x1 = x_heun(i); y1 = y_heun(i);

    k1x = fx(x1, y1);
    k1y = fy(x1, y1);

    x_temp = x1 + h * k1x;
    y_temp = y1 + h * k1y;

    k2x = fx(x_temp, y_temp);
    k2y = fy(x_temp, y_temp);

    x_heun(i+1) = x1 + h * (k1x + k2x)/2;
    y_heun(i+1) = y1 + h * (k1y + k2y)/2;
end

%Runge-Kutta 4 Method
for i = 1:N-1
    x1 = x_rk4(i); y1 = y_rk4(i);

    k1x = fx(x1, y1);
    k1y = fy(x1, y1);

    k2x = fx(x1 + h*k1x/2, y1 + h*k1y/2);
    k2y = fy(x1 + h*k1x/2, y1 + h*k1y/2);

    k3x = fx(x1 + h*k2x/2, y1 + h*k2y/2);
    k3y = fy(x1 + h*k2x/2, y1 + h*k2y/2);

    k4x = fx(x1 + h*k3x, y1 + h*k3y);
    k4y = fy(x1 + h*k3x, y1 + h*k3y);

    x_rk4(i+1) = x1 + h * (k1x + 2*k2x + 2*k3x + k4x)/6;
    y_rk4(i+1) = y1 + h * (k1y + 2*k2y + 2*k3y + k4y)/6;
end

%Plotting
figure;
subplot(2,1,1);
plot(t, x_heun, 'b', t, x_rk4, 'r--');
legend('Heun x(t)', 'RK4 x(t)');
xlabel('Time'); ylabel('Prey Population');
title('Prey Dynamics');

subplot(2,1,2);
plot(t, y_heun, 'b', t, y_rk4, 'r--');
legend('Heun y(t)', 'RK4 y(t)');
xlabel('Time'); ylabel('Predator Population');
title('Predator Dynamics');

%%Comparison 

%system of ODEs
lotka = @(t, Y) [p*Y(1) - q*Y(1)*Y(2);
                 -s*Y(2) + r*Y(1)*Y(2)];

tspan = [0 200];
Y0 = [105; 8];

%solve with ode45
[t_45, Y_45] = ode45(lotka, tspan, Y0);

%solve with ode23
opts = odeset('MaxStep', 0.1);
[t_23, Y_23] = ode23(lotka, tspan, Y0, opts);

%plot Comparison
figure;
subplot(2,1,1);
plot(t_45, Y_45(:,1), 'g', t_23, Y_23(:,1), 'k--');
legend('ode45 x(t)', 'ode23 x(t)');
xlabel('Time'); ylabel('Prey Population');

subplot(2,1,2);
plot(t_45, Y_45(:,2), 'g', t_23, Y_23(:,2), 'k--');
legend('ode45 y(t)', 'ode23 y(t)');
xlabel('Time'); ylabel('Predator Population');
