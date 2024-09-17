close all;
figure(1);
plot(out.t,out.y(:,1),'r',out.t,out.y(:,2),'k:','linewidth',2);
xlabel('time(s)');
ylabel('Step response');

figure(2);
plot(out.tout,out.ut(:,1),'r','linewidth',2);
xlabel('time(s)');
ylabel('Control input');
