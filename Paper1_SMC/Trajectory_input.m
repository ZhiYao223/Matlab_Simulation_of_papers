function [sys,x0,str,ts,simStateCompliance] = Trajectory_input(t,x,u,flag,pa)


%
% The following outlines the general structure of an S-function.
%
switch flag,

  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;

  case 1,
    sys=mdlDerivatives(t,x,u);

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

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 0;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [];

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

sys = [];

% end mdlDerivatives


function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

function sys=mdlOutputs(t,x,u,pa)

m = pa.m;


xd = 0.5*t+ 1*m;
yd = 0.25*t+0.5*m;


sys = [xd;yd];

% end mdlOutputs


function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit


function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
