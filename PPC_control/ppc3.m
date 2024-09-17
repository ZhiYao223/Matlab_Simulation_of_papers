% 参数设置
a = 1.0;
b = 2.0;
c = 0.5;
k = 5.0;

% 性能函数参数
rho_0 = 1.0;
rho_inf = 0.01;
lambda = 0.5;

% 参考信号
x_d = @(t) sin(t);

% 性能函数
rho = @(t) (rho_0 - rho_inf) * exp(-lambda * t) + rho_inf;

% 控制器
control_law = @(x, t) - (1/b) * (-a * x + c * x^2 + cos(t) + k * (x - sin(t)));

% 定义系统状态方程
system_dynamics = @(t, x) -a * x + b * control_law(x, t) + c * x^2;

% 初始条件和仿真时间
x0 = 0.5;
tspan = [0 10];

% 仿真
[t, x] = ode45(system_dynamics, tspan, x0);

% 计算误差
e = x - x_d(t);

% 绘图
figure;
subplot(2,1,1);
plot(t, x, 'r', 'LineWidth', 2);
hold on;
plot(t, x_d(t), 'b--', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('State x(t)');
legend('x(t)', 'x_d(t)');
title('State Trajectory');

subplot(2,1,2);
plot(t, e, 'g', 'LineWidth', 2);
hold on;
plot(t, rho(t), 'k--', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Error e(t)');
legend('e(t)', '\rho(t)');
title('Error and Performance Bound');