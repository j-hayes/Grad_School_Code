function dYfuncvecdt = ODEfun(t,Yfuncvec,params)
Fa = Yfuncvec(1); 
Fb = Yfuncvec(2); 
Fc = Yfuncvec(3); 
Fd = Yfuncvec(4); 
Fe = Yfuncvec(5); 
y = Yfuncvec(6); 

% Explicit equations

k1c=params(1);
k2d= params(2);
k3e = params(3);
Wf = params(4);
alpha = params(5);
K1c = params(6);
kc = params(7);
Ct0 = params(8);
kb = params(9);
Ft0 = params(10);

Ft = Fa + Fb + Fc + Fd + Fe;

Ca = Ct0*(Fa/Ft)*y;
Cb = Ct0*(Fb/Ft)*y;
Cc = Ct0*(Fc/Ft)*y;
Cd = Ct0*(Fd/Ft)*y;
Ce = Ct0*(Fe/Ft)*y;

r2d = k2d*Ca;
r1c = k1c*(Ca-(Cb*Cc/K1c));
r3e = k3e*(Cc^2)*Cd;

ra = 0-r1c-r2d;
rb = r1c;
rc=r1c-r3e;
rd = r2d-(r3e/2);
re = r3e;


% Differential equations
dFadW = ra;
dFbdW=  rb;
dFcdW = rc -(kb*Cc);
dFddW = rd;
dFedW = re;
dydW = -alpha*Ft/(2*Ft0*y);

dYfuncvecdt = [dFadW; dFbdW; dFcdW;dFddW;dFedW;dydW]; 

