% 提取timeseries对象中的数据
t = out.t;  % 假设out.y是timeseries对象
y1 = out.y.Data(:, 1);  % Ideal position signal
y2 = out.y.Data(:, 2);  % Position tracking
y3 = out.y.Data(:, 3);  % Speed tracking
ut = out.ut.Data(:, 1);  % Control input

% 图1: 位置信号与位置跟踪
figure(1);
plot(t, y1, 'k', 'linewidth', 2);  % Ideal position signal
hold on;
plot(t, y2, 'r:', 'linewidth', 2);  % Position tracking
hold off;
legend('Ideal position signal', 'Position tracking');
xlabel('time(s)');
ylabel('Angle response');
title('Position Tracking');

% 图2: 速度信号与速度跟踪
% figure(2);
% plot(t, cos(t), 'k', 'linewidth', 2);  % Ideal speed signal
% hold on;
% plot(t, y3, 'r:', 'linewidth', 2);  % Speed tracking
% hold off;
% legend('Ideal speed signal', 'Speed tracking');
% xlabel('time(s)');
% ylabel('Angle speed response');
% title('Speed Tracking');
% 
% 图3: 控制输入
% figure(3);
% plot(t, ut, 'k', 'linewidth', 2);  % Control input
% xlabel('time(s)');
% ylabel('Control input');
% title('Control Input');
% 
% 图4: 相轨迹
% c = 0.5;
% figure(4);
% plot(e, de, 'r', 'linewidth', 2);  % s change
% hold on;
% plot(e, -c.*e, 'k', 'linewidth', 2);  % s = 0
% hold off;
% xlabel('e');
% ylabel('de');
% legend('s change', 's = 0');
% title('Phase Trajectory');
