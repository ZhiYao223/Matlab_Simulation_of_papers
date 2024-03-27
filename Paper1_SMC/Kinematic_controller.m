function [sys,x0,str,ts,simStateCompliance] = Kinematic_controller(t,x,u,flag,pa)


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
sizes.NumOutputs     = 4;
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
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

xd = u(1);
yd = u(2);
x = u(3);
y = u(4);
psi = u(5);

lx = pa.lx;
ly = pa.ly;
kx = pa.kx;
ky = pa.ky;

xe = x-xd;
ye = y-yd;
dxd = 0.5;
dyd = 0.25;
ud = cos(psi)*(dxd+lx*(tanh(-kx/lx*xe)))+sin(psi)*(dyd+ly*tanh(-ky/ly*ye));
vd = -sin(psi)*(dxd+lx*(tanh(-kx/lx*xe)))+cos(psi)*(dyd+ly*tanh(-ky/ly*ye));

sys = [ud;vd;ye;xe];

% end mdlOutputs


function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit


function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
