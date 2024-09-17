function [sys,x0,str,ts,simStateCompliance] = chap1_1input(t,x,u,flag)%%函数名要和文件名一致

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
sizes.NumOutputs     = 1;%%几个输出
sizes.NumInputs      = 0;%%几个输入
sizes.DirFeedthrough = 0;%%输入输出是否有直接关系
sizes.NumSampleTimes = 1;% at least one sample time is needed 采样时间有几个

sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0,0];%%采样时刻 采样时间偏移量

simStateCompliance = 'UnknownSimState';

function sys=mdlDerivatives(t,x,u)

sys=[];

function sys=mdlOutputs(t,x,u)
thd = 1.0;
sys(1) = thd ;


function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

function sys=mdlTerminate(t,x,u)

sys = [];

