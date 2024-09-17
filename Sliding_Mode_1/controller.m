function [sys,x0,str,ts,simStateCompliance] = controller(t,x,u,flag,pa)
switch flag,
  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
  case 1,
    sys=mdlDerivatives(t,x,u,pa);
  case 2,
    sys=mdlUpdate(t,x,u);
  case 3,
    sys=mdlOutputs(t,x,u,pa);
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);
  case 9,
    sys=mdlTerminate(t,x,u);
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag))
end
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
sizes = simsizes;

sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0; %input只有输出，没有输入，即没有自身状态
sizes.NumOutputs     = 4; %输出为：dx1,dx2,dx3,control_u
sizes.NumInputs      = 0; %输入个数为1
sizes.DirFeedthrough = 0; %输入不会直接影响输出。输出是仅仅由状态变量决定的
sizes.NumSampleTimes = 1;   % at least one sample time is needed
%状态方程的更新通过输入u 来计算新的状态值，然后输出这些状态值。
%这意味着输入u 不直接影响输出，而是通过状态更新来间接影响输出。
%所以 DirFeedthrough 应该设置为 0。
sys = simsizes(sizes);

% 初始化状态变量
x0  = [3;0;0]; 
str = [];
% initialize the array of sample times
ts  = [0 0];
simStateCompliance = 'UnknownSimState';

function sys=mdlDerivatives(t,x,u,pa)
c1 = pa.c1;
c2 = pa.c2;
x1 = x(1);
x2 = x(2);
x3 = x(3);
%滑模面
s = x3+c2*x2+c1*x1;
%控制输入
control_u = -sign(s)-s-x1-x2-2*x3-x2*x3;
%系统状态方程
dx1 = x2;
dx2 = x3;
dx3 = x1+x2*x3+control_u;
sys = [dx1;dx2;dx3];

function sys=mdlUpdate(t,x,u)
sys = [];

function sys=mdlOutputs(t,x,u,pa)
c1 = pa.c1;
c2 = pa.c2;
x1 = x(1);
x2 = x(2);
x3 = x(3);
%滑模面
s = x3+c2*x2+c1*x1;
%控制输入
%control_u = -sign(s)-s-x1-x2-2*x3-x2*x3;   %使用符号函数sign(s)
control_u = -sat(s)-s-x1-x2-2*x3-x2*x3;     %使用饱和函数消除抖振

% 输出状态变量 x1, x2, x3 以及 control_u
sys = [x;control_u]; %或者sys = [x(1);x(2);x(3);control_u];

function sys=mdlGetTimeOfNextVarHit(t,x,u)
sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

function sys=mdlTerminate(t,x,u)
sys = [];
% end mdlTerminate

%% 饱和函数方法一
%function y = sat(s)
%y = max(-1,min(1,s));

% y = sat(s) 将输入 s 限制在 [-1, 1] 范围内
% 首先将 s 的值与 1 比较，取其中较小的值
% 如果 s 大于 1，则返回 1；否则返回 s
%y = min(1, s);
% 然后将上一步的结果与 -1 比较，取其中较大的值
% 如果上一步结果小于 -1，则返回 -1；否则返回上一步的结果
%y = max(-1, y);
%%

%% 饱和函数方法二
% y = sat(s) 将输入 s 限制在 [-1, 1] 范围内，其中 k = 1 / D
function y = sat(s)   
D = 1; %设置阈值 D
k = 1 / D; %设置比例常数 k
if s > D
    y = 1;
elseif s < -D
    y = -1;
else
    y = k * s;
end

