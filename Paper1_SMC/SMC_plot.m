close all;
%创建一个新的图形窗口

xd = xdyd(:,1)';
yd = xdyd(:,2)';
xa = xaya(:,1)';
ya = xaya(:,2)';
u = uvr(:,1);
v = uvr(:,2);
r = uvr(:,3);
t = 1:length(xa);
t = t*0.01;

figure(0);


%xd,yd,xa,ya
figure(1);
phi = xaya(:,3)';
plot(t,xd,t,yd,t,xa,t,ya); 
legend("xd","yd","xa","ya");
xlabel('x(m)');
ylabel('y(m)');
title('compare of x and xd');
grid on;

%期望坐标与实际坐标关于时间t的变化关系
figure(2);
plot(t,xd,'r.',t,xa,'r',t,yd,'b.',t,ya,'b');
legend("xd","xa","yd","ya");
xlabel('t(s)');
ylabel('y(m) / x(m)');
legend("desiredX","actualX","desiredY","actualY");
grid on;

%期望轨迹与跟踪轨迹变化关系
figure(3)
plot(xa,ya,'r.',xd,yd,'b.');
legend("actual","desired");
xlabel('x(m)');
ylabel('y(m)');
grid on;

%u、v、r关于时间t的变化关系
figure(4);
plot(t,u,'-r.',t,v,'-.g.',t,r,'.b');
legend("纵荡速度u","横荡速度v","航向角r");
title('u、v、r仿真对比');
xlabel(t(s));
ylabel('u、v、r');
grid on;




