function dYfuncvecdt = ODEfun_partd(V,Yfuncvec,params)
X = Yfuncvec; 

% Explicit equations
Ca0 = params(1);
CI0 = params(2);
ThetaI = params(3);
T0 =params(4);
Cpa = params(5);
Cpi = params(6);
dHrx = params(7);
Fa0 = params(8);
Kc0 = params(9);
R = params(10);%ideal gas law const
eps = 1/(1+ThetaI);

Ca01 = (Ca0 + CI0)/(ThetaI + 1);
T = (X*(-dHrx) + (Cpa+ThetaI*Cpi)*T0)/(Cpa+ThetaI*Cpi);
k = exp(34.34-34222/T);

Ca = Ca01*(1-X)/(1+eps*X)*(T0/T);
Cb =  Ca01*(X)/(1+eps*X)*(T0/T);
Cc = Cb;
Kc = Kc0*exp((-dHrx/R)*((1/T0)-(1/T)));
ra = -k*(Ca-(Cb*Cc/Kc)); 

% Differential equations
dXdV= -ra/Fa0;

dYfuncvecdt = dXdV;

