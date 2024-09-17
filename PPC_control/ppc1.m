% 预设性能控制仿真

% 系统参数
a = 1;
b = 1;
x0 = 5;  % 初始状态
x_d = 0;  % 期望状态

% 预设性能参数
rho1 = 1;
rho2 = 1;
l = 1;

% 仿真时间
T = 10;
dt = 0.01;
t = 0:dt:T;

% 初始化状态
x = zeros(1, length(t));
u = zeros(1, length(t));
x(1) = x0;

% 仿真主循环
for k = 1:length(t)-1
    e = x(k) - x_d;
    rho = rho1 * exp(-l * t(k)) + rho2 * exp(-l * t(k));
    drho = -l * rho1 * exp(-l * t(k)) - l * rho2 * exp(-l * t(k));
    u(k) = -(1/b) * (a * x(k) + drho/rho * e);
    x(k+1) = x(k) + dt * (-a * x(k) + b * u(k));
end

% 结果绘图
figure;
subplot(2,1,1);
plot(t, x, 'r-', 'LineWidth', 1.5); hold on;
plot(t, x_d * ones(size(t)), 'b--', 'LineWidth', 1.5);
xlabel('时间 t');
ylabel('状态 x(t)');
legend('x(t)', 'x_d(t)');
title('系统状态响应');

subplot(2,1,2);
plot(t, u, 'k-', 'LineWidth', 1.5);
xlabel('时间 t');
ylabel('控制输入 u(t)');
title('控制输入响应');

figure;
e = x - x_d;
rho_upper = rho1 * exp(-l * t);
rho_lower = -rho2 * exp(-l * t);
plot(t, e, 'r-', 'LineWidth', 1.5); hold on;
plot(t, rho_upper, 'b--', 'LineWidth', 1.5);
plot(t, rho_lower, 'b--', 'LineWidth', 1.5);
xlabel('时间 t');
ylabel('误差 e(t)');
legend('跟踪误差 e(t)', '上界 \rho_1 e^{-lt}', '下界 -\rho_2 e^{-lt}');
title('误差与预设性能约束');
