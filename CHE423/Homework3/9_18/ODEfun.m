function dYfuncvecdt = ODEfun(t,Yfuncvec,params)
Cc = Yfuncvec(1); 
Cs = Yfuncvec(2);

% Explicit equations
uMax = params(1);
Ks = params(2);
Ycs = params(3);
Ysc = 1/ Ycs;
Cc0 = params(4);
Cs0 = params(5);
Ypc = params(6);

rg = (uMax * Cs * Cc)/(Ks + Cs);

% Differential equations
dCsdt=  -1*Ysc*rg;
dCcdt=  rg;
dCpdt=  rg*Ypc

dYfuncvecdt = [dCcdt;dCsdt;dCpdt] 

