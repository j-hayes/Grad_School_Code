function dYfuncvecdt = ODEfun_C12P8_partf(W,Yfuncvec,params)
X = Yfuncvec(1); 
T = Yfuncvec(2);
P = Yfuncvec(3);

%paramters
Fa0 = 5;
Ca0 = 2;
CI0 = Ca0*8;
FI0 = 8*Fa0;
CpI = 18;
CpA = 160;
CpB = 160;
E = 10000;
dHrx = -20000;
Kc0 = 1;
roB = 1.2;
T0 = 300;
k1 = 0.1;
Ua = 150;
Ta0 = 300;
V = 40;
alpha = 0.02;
mDotc = 50;
CpCoolant = 20;

thetaA = Fa0/Fa0;
thetaB = 0/Fa0;
thetaI=FI0/Fa0;

sumThetaiCpi = thetaA*CpA+thetaB*CpB+thetaI*CpI ;
deltaCp = CpB - CpA;


R = 1.987;%cal/mol*K
% Explicit equations



eps = 0;%delta*yA0; delta = 0;

Ca = Ca0*(1-X)/(1+eps*X)*(T0/T);
Cb = Ca0*(X)/(1+eps*X)*(T0/T);
Kc = Kc0*exp((-dHrx/R)*((1/T0)-(1/T)));
k = k1*exp((E/R)*((1/T0)-(1/T)));
ra_prime = -k*Ca0*(1-(1+1/Kc)*X); 



% Differential equations
dXdW= -ra_prime/Fa0;
dTdW = 0;
dPdW = -alpha/(2*P)*(1+eps*X)*(T/T0);
dYfuncvecdt = [dXdW; dTdW; dPdW];

