function [sys,x0,str,ts,simStateCompliance] = Dynamic_controller(t,x,u,flag,pa)

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

function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 10;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

x0  = [];

str = [];

ts  = [0 0];

simStateCompliance = 'UnknownSimState';

function sys=mdlDerivatives(t,x,u)

sys = [];

function sys=mdlUpdate(t,x,u)

sys = [];

function sys=mdlOutputs(t,x,u,pa)
m = pa.m;
Iz = pa.Iz;
Xu = pa.Xu;
Yv = pa.Yv;
Nr = pa.Nr;
Xdu = pa.Xdu;
Ydv = pa.Ydv;
Ndr = pa.Ndr;
ky = pa.ky;
ly = pa.ly;
M1 = 1/(m-Xdu);
M2 = 1/(m-Ydv);
M3 = 1/(Iz-Ndr);
M6 = M3;


beta1 = 150;
beta2 = 1;
q1 = 3; p1 = 5;
q2 = 3; p2 = 5;
W1 = 0.5;
W2 = 0.15;

ud = u(1);
vd = u(2);
ua = u(3);
va = u(4);
r = u(5);
dud =u(6);
dvd = u(7);
ye = u(8);

if(t == 0)
    hat_eu = 0.01;
else
    hat_eu = u(9);
end
dv = u(10);

a12 = Ydv-Xdu;
a16 = Xdu-m;
a26 = m-Ydv;

eu = ua-ud;
ev = va-vd;

dev = M2*(Yv*va+a16*ua*r)-dvd;

S1 = eu + beta1*abs(hat_eu)^(q1/p1)*sign(hat_eu);
S2 = dev + beta2*(abs(ev))^(q2/p2)*sign(ev);
dye = ly*tanh(-ky/ly*ye);
L = ky*dye*(sech(-ky/ly*ye))^2;

Taou = -Xu*ua-a26*va*r+1/M1*(dud-beta1*q1/p1*eu*abs(hat_eu)^(q1/p1-1)*sign(hat_eu))+1/M1*(-W1*sign(S1));
Taor = -Nr*r-a12*ua*va+1/(M6*(M2*a16*ua+ud))*(M2*(-Yv*dv-a16*ua*r)+ L-beta2*q2/p2*dev*(abs(ev))^(-2/5)*sign(ev)-W2*sign(S2));



sys = [Taor;Taou;eu];

function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

function sys=mdlTerminate(t,x,u)

sys = [];