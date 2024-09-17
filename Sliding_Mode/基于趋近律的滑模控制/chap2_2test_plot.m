close all;
%% 提取timeseries对象中的数据
t = out.tout;               % 时间数据
y = out.y.Data;             % y的值
de = out.de.Data;           % de的值
e = out.e.Data;             % e的值
u = out.ut.Data;            % ut的值

%% 绘制 误差e,de 的曲线
figure;
plot(t,e,'r',t,de,'b', 'linewidth', 2);
xlabel('Time (s)');
ylabel('Angle tracking');
legend('Ideal position signal','Position tracking');
title('误差曲线');
grid;
%% 绘制 位置跟踪 的曲线
figure;
plot(t, y(:,2), 'r',t,y(:,1),'b', 'linewidth', 2);
xlabel('Time (s)');
ylabel('Angle tracking');
title('位置跟踪');
legend('Ideal position signal','Position tracking');
grid;

%% 绘制 速度跟踪 的曲线
figure;
plot(t,cos(t),'r',t,y(:,3),'b','linewidth', 2);
xlabel('Time (s)');
ylabel('Speed tracking');
title('速度跟踪');
legend('Ideal speed signal','Speed tracking');
grid;

%% 绘制控制输入的曲线
figure;
plot(t,u,'b','linewidth',2);
xlabel('time(s)');
ylabel('Control input');
legend('控制输入ut');
grid;

%%
figure;
plot(e,de,'b',e,-c'.*e,'k','linewidth',2);
xlabel('Time (s)');
ylabel('e value');
title('不同k值下指数趋近律相轨迹趋近过程');

%% figure;
% load testfile1;
% plot(e,de,'y',e,-c'.*e,'k','linewidth',2);
% hold on;
% load testfile2;
% plot(e,de,'b',e,-c'.*e,'k','linewidth',2);
% hold on;
% load testfile3;
% plot(e,de,'g',e,-c'.*e,'k','linewidth',2);
% hold on;
% load testfile4;
% plot(e,de,'r',e,-c'.*e,'k','linewidth',2);
% xlabel('e');ylabel('de');
% title('yellow:k=0, blue:k = 10, green:k = 20,red:k = 30');