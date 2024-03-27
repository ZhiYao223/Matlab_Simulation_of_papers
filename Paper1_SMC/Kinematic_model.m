function [sys,x0,str,ts,simStateCompliance] = Kinematic_model(t,x,u,flag)


%
% The following outlines the general structure of an S-function.
%
switch flag
  case 0
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
  case 1
    sys=mdlDerivatives(t,x,u);
  case 2
    sys=mdlUpdate(t,x,u);
  case 3
    sys=mdlOutputs(t,x,u);
  case 4
    sys=mdlGetTimeOfNextVarHit(t,x,u);
  case 9
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
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [0,0,0];

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


function sys=mdlDerivatives(t,x,u)
ua = u(1);
v = u(2);
r = u(3);


psi = x(3);

dxa = ua*cos(psi)-v*sin(psi);
dya = ua*sin(psi)+v*cos(psi);
dpsi = r;


sys = [dxa;dya;dpsi];

% end mdlDerivatives


function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

function sys=mdlOutputs(t,x,u)


sys = [x(1);x(2);x(3)];

% end mdlOutputs


function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit


function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
