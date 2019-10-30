function dYfuncvecdt = ODEfun(t,Yfuncvec,params)
C = Yfuncvec; 

% Explicit equations
u = params;

hourOfDay = mod(t,24);

f = 0
if hourOfDay >= 6 && hourOfDay <= 18 
    f = sin(3.14159*hourOfDay/12);
end

% Differential equations
dCdt=  f*C*u;

dYfuncvecdt = [dCdt;] 

