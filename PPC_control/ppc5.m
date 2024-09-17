% 清除环境
clear; clc; close all;

% 定义系统参数
rho_0 = 0.7;
rho_inf = 1e-3;
l = 3;
k = 5;

% 时间设置
t_span = [0, 10];
dt = 0.01;
t = t_span(1):dt:t_span(2);

% 期望输出及其导数
y_d = cos(t);
dy_d = -sin(t);
ddy_d = -cos(t);

% 性能函数及其导数
rho = (rho_0 - rho_inf) * exp(-l * t) + rho_inf;

% 初始化状态变量
x1 = zeros(1, length(t));
x2 = zeros(1, length(t));
x1(1) = 0;
x2(1) = 0;

% 初始化控制输入和误差
u = zeros(1, length(t));
e = zeros(1, length(t));
sigma = zeros(1, length(t));

% 仿真循环
for i = 1:length(t)-1
    % 计算误差和sigma
    e(i) = y_d(i) - x1(i);
    sigma(i) = e(i) / rho(i);
    
    % 计算控制输入
    u(i) = ddy_d(i) + k^2 * sigma(i) * rho(i) + x1(i) - 2 * sin(x2(i));
    
    % 状态更新（欧拉法）
    x1(i+1) = x1(i) + dt * x2(i);
    x2(i+1) = x2(i) + dt * (-x1(i) + 2 * sin(x2(i)) + u(i));
end

% 计算最后一个误差和sigma
e(end) = y_d(end) - x1(end);
sigma(end) = e(end) / rho(end);

% 绘制误差和性能函数
figure;
plot(t, e, 'r', 'LineWidth', 1.5); hold on;
plot(t, rho, 'b--', 'LineWidth', 1.5);
plot(t, -rho, 'b--', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Error e(t)');
legend('Error e(t)', 'Performance Boundary \rho(t)');
title('Error e(t) and Performance Function \rho(t)');
grid on;
