function dYfuncvecdt = ODEfunpartc(t,Yfuncvec,params)
C = Yfuncvec; 

% Explicit equations
u0 = params(1);
Cmax = params(2)

u  = u0*(1-C/Cmax);

hourOfDay = mod(t,24);

f = 0
if hourOfDay >= 6 && hourOfDay <= 18 
    f = abs(sin(3.14159*hourOfDay/12))% no negative sunlight;
end

% Differential equations
dCdt=  f*C*u;
dYfuncvecdt = [dCdt;] 

