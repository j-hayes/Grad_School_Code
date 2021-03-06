function dYfuncvecdt = ODEfun(t,Yfuncvec,params)
Cs = Yfuncvec; 

% Explicit equations
uMax = params(1);
Ks = params(2);
Ycs = params(3);
Ysc = 1/ Ycs;
Cc0 = params(4);
Cs0 = params(5);
Cinf = params(6);
Cc = Cc0 + Ycs*(Cs0 - Cs); 
rg = uMax *(1- Cc/Cinf)*Cc;

% Differential equations
dCsdt=  -1*Ysc*rg;
dYfuncvecdt = [dCsdt;] 

