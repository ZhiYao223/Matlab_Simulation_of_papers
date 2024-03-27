function [sys,x0,str,ts,simStateCompliance] = Dynamic_model(t,x,u,flag,pa)


%
% The following outlines the general structure of an S-function.
%
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
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

% end sfuntmpl


function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes

sizes = simsizes;

sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [0.01;0.01;0.01];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];


simStateCompliance = 'UnknownSimState';

% end mdlInitializeSizes


function sys=mdlDerivatives(t,x,u,pa)

Taou = u(2);
Taor = u(1);

u = x(1);
v = x(2);
r = x(3);

m = pa.m;
Iz = pa.Iz;
Xu = pa.Xu;
Xdu = pa.Xdu;
Yv = pa.Yv;
Ydv = pa.Ydv;
Nr = pa.Nr;
Ndr = pa.Ndr;

a12 = Ydv-Xdu;
a13 = Xdu-m;
a23 = m-Ydv;
M1 = 1/(m-Xdu);
M2 = 1/(m-Ydv);
M3 = 1/(Iz-Ndr);

du = M1*(Xu*u+a23*v*r+Taou);
dv = M2*(Yv*v+a13*u*r);
dr = M3*(Nr*r+a12*u*v+Taor);

sys = [du;dv;dr]; 

% end mdlDerivatives


function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

function sys=mdlOutputs(t,x,u,pa)




sys = x;

% end mdlOutputs


function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit


function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
