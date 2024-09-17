function [sys,x0,str,ts,simStateCompliance] = Mode_system(t,x,u,flag)
switch flag,
  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
  case 1,
    sys=mdlDerivatives(t,x,u);
  case 2,
    sys=mdlUpdate(t,x,u);
  case 3,
    sys=mdlOutputs(t,x,u);
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);
  case 9,
    sys=mdlTerminate(t,x,u);
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;   %x_u1,x_u2,x_u3,uc1,uc2,uc3
sizes.NumInputs      = 0;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed
sys = simsizes(sizes);
x0  = [10;10;10];
str = [];
ts  = [0 0];

simStateCompliance = 'UnknownSimState';

function sys=mdlDerivatives(t,x,u)
x1 = x(1);
x2 = x(2);
x3 = x(3);

uc1 = - x1^2 + x1^3 - x1;
uc2 = - x2^2 - x2;
uc3 = - x3^2;

dx1 = x1^2 - x1^3 + uc1;
dx2 = x2^2 - x2^3 + uc2;
dx3 = x3^2 - x3^3 + uc3;

sys = [dx1;dx2;dx3];

function sys=mdlUpdate(t,x,u)

sys = [];

function sys=mdlOutputs(t,x,u)
x1 = x(1);
x2 = x(2);
x3 = x(3);
uc1 = - x1^2 + x1^3 - x1;
uc2 = - x2^2 - x2;
uc3 = - x3^2;
sys = [x1;x2;x3;uc1;uc2;uc3];

function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

function sys=mdlTerminate(t,x,u)

sys = [];

