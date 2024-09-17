% 定义系统参数
rho_0 = 0.7;
rho_inf = 1e-3;
l = 3;
k = 5;

% 时间设置
tspan = [0 10];
y0 = [0 0]; % 初始状态

% 期望输出
yd = @(t) cos(t);
dyd = @(t) -sin(t);
ddyd = @(t) -cos(t);
% 性能函数
rho = @(t) (rho_0 - rho_inf) * exp(-l * t) + rho_inf;

% 状态方程
f = @(t, y) [y(2); ...
    y(1) + 2*sin(y(2)) + dyd(t) + rho(t) * (k*(yd(t) - y(1))/rho(t) + (yd(t) - y(1))*(-l*rho(t))/(rho(t)^2))];

% 求解微分方程
[t, y] = ode45(f, tspan, y0);

% 计算误差
e = yd(t) - y(:,1);
rho_vals = rho(t);

% 画图
figure;
plot(t, e, 'r', 'LineWidth', 1.5);
hold on;
plot(t, rho_vals, 'b--', 'LineWidth', 1.5);
plot(t, -rho_vals, 'b--', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Error e(t)');
legend('Error e(t)', 'Performance Function \rho(t)');
title('Error e(t) and Performance Function \rho(t)');
grid on;
