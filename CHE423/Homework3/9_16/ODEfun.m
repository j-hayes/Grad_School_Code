function dYfuncvecdt = ODEfun(t,Yfuncvec,params)
Cs = Yfuncvec; 

% Explicit equations
uMax = params(1);
Ks = params(2);
Ycs = params(3);
Ysc = 1/ Ycs;
Cc0 = params(4);
Cs0 = params(5);

Cc = Cc0 + Ycs*(Cs0 - Cs); 

rg = (uMax * Cs * Cc)/(Ks + Cs);


% Differential equations
dCsdt=  -1*Ysc*rg;

dYfuncvecdt = [dCsdt;] 

