function dYfuncvecdt = ODEfun(t,Yfuncvec,k)
Ca = Yfuncvec(1); 
Cr = Yfuncvec(2); 
Cs = Yfuncvec(3); 
% Explicit equations
k1=k(1);
k2=k(2);
k3 = k(3);

% Differential equations
dCadt = -k1*Ca; 
dCrdt = k1*Ca-k2*Cr-k3*Cr*Cs; 
dCsdt = k2*Cr - k3*Cr*Cs; 
dYfuncvecdt = [dCadt; dCrdt; dCsdt]; 

