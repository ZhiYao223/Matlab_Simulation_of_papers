% 定义初始条件和参数
rho0 = 0.5;
rho_inf = 0.01;
l = 2;
k = 10;  % 增加控制增益 k 以改善跟踪性能
tspan = [0 10];
x0 = [1; 0];  % 初始条件 x1(0) = 1, x2(0) = 0

% 进行仿真
[T, X] = ode45(@system_eq, tspan, x0);

% 绘制系统状态 x1 和参考信号 yd 的对比图
figure;
yd = @(t) 1.5 * (1 - exp(-2 * t));  % 直接在绘图部分定义参考信号
plot(T, X(:,1), 'b-', 'LineWidth', 1.5); hold on;
plot(T, yd(T), 'r--', 'LineWidth', 1.5);
legend('x1(t)', 'yd(t)');
xlabel('时间 t');
ylabel('状态 x1 和参考信号 yd');
title('系统状态 x1 与参考信号 yd 的对比');
grid on;

% 定义系统的动力学方程
function dx = system_eq(t, x)
    rho0 = 0.5;
    rho_inf = 0.01;
    l = 2;
    k = 10;  % 控制增益

    f = -x(1) + x(2)^2;
    g = 1 + 0.5 * sin(x(1));
    rho = (rho0 - rho_inf) * exp(-l * t) + rho_inf;
    
    % 计算参考信号及其导数
    yd_t = 1.5 * (1 - exp(-2 * t));
    dyd_t = 3 * exp(-2 * t);  % y_d 的导数
    
    % 计算误差和控制律
    e = x(1) - yd_t;
    xi = e / rho;
    u = (-f - k * xi * rho + dyd_t) / g;
    
    % 定义状态方程
    dx = [x(2); f + g * u];
end
