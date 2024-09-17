function [sys,x0,str,ts,simStateCompliance] = chap2_1ctrl(t,x,u,flag)%%函数名要和文件名一致

switch flag
  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;%%初始化函数
  case 1,
    sys=mdlDerivatives(t,x,u);
  case {2,4,9}
    sys=[];
  case 3,
    sys=mdlOutputs(t,x,u);%%系统输出 y  
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes

sizes = simsizes;

sizes.NumContStates  = 0;%%是否是连续
sizes.NumDiscStates  = 0;%%是否是离散
sizes.NumOutputs     = 3;%%几个输出
sizes.NumInputs      = 3;%%几个输入
sizes.DirFeedthrough = 1;%%输入输出是否有直接关系
sizes.NumSampleTimes = 0;% at least one sample time is needed 采样时间有几个

sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];%%采样时刻 采样时间偏移量

simStateCompliance = 'UnknownSimState';

function sys=mdlDerivatives(t,x,u)

sys=[];

function sys=mdlOutputs(t,x,u)
thd = u(1);
dthd = cos(t);
ddthd = -sin(t);

th = u(2);
dth = u(3);

J = 10;
c = 0.50;
eta = 0.50;
e = th - thd;
de = dth - dthd;
s = c*e+de;

ut = J*(-c*de + ddthd - eta*sign(s));

sys = [ut,e,de];

function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

function sys=mdlTerminate(t,x,u)

sys = [];

