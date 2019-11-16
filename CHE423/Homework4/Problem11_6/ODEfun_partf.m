function dYfuncvecdt = ODEfun_partf(V,Yfuncvec,params)
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

%eps = 1/(1+ThetaI); No Inert passed

Ca01 = Ca0;%no iniert passed%(Ca0 + CI0)/(ThetaI + 1);
T = T0;%assuming iso thermal
k = exp(34.34-34222/T);
Ca = Ca01*(1-X)/(1+X);
ra = -k*Ca; 

% Differential equations
dXdV= -ra/Fa0;
dYfuncvecdt = dXdV;

