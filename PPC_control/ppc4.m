% 初始化参数
a = 1; % 系统参数 a
b = 1; % 系统参数 b
c = 0.1; % 系统参数 c
k = 5; % 控制增益 k
rho_0 = 1.2; % 初始性能函数值
rho_inf = 0.01; % 性能函数的下限
lambda = 1; % 性能函数的衰减速率

% 仿真时间
T = 10; % 仿真总时间
dt = 0.01; % 仿真时间步长
t = 0:dt:T; % 时间向量

% 初始条件
x0 = 1; % 初始状态 x(0)
x_d0 = 0; % 参考信号初始值
x = zeros(1, length(t)); % 状态 x 的存储向量
x_d = sin(t); % 参考信号，设为正弦信号
x(1) = x0;

% 控制输入 u 的存储向量
u = zeros(1, length(t));

% 性能函数 rho(t) 的存储向量
rho = (rho_0 - rho_inf) * exp(-lambda * t) + rho_inf;

% 仿真过程
for i = 1:length(t)-1
    % 计算误差
    e = x(i) - x_d(i);
    
    % 计算标准化误差
    xi = e / rho(i);
    
    % 计算控制输入 u
    u(i) = (1/b) * (-k * e + a * x(i) - c * x(i)^2 + diff(x_d(i:i+1))/dt + (e * diff(rho(i:i+1))/dt) / rho(i)^2);
    
    % 状态更新（使用欧拉法）
    x(i+1) = x(i) + dt * (-a * x(i) + b * u(i) + c * x(i)^2);
end

% 绘图
figure;
plot(t,x,'r','lineWidth',2);
hold on;
plot(t, x_d, 'b--','lineWidth',2);
xlabel('时间 t');
ylabel('状态 x(t) 和 参考信号 x_d(t)');
legend('状态 x(t)', '参考信号 x_d(t)');

figure;
plot(t,rho,'black','lineWidth',2);
hold on;
plot(t,-0.1*rho,'black','lineWidth',2);
hold on;
plot(t, x - x_d,'red','lineWidth',2);
xlabel('时间 t');
ylabel('状态 x(t) 和 参考信号 x_d(t)');
legend('ρ(t)','-delta ρ(t)', '实际误差e(t)');
title('性能函数与实际误差');

figure;
plot(t, u,'g','lineWidth',2);
xlabel('时间 t');
ylabel('控制输入 u(t)');
title('控制输入 u(t)');




