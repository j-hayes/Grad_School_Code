function dYfuncvecdt = ODEfun(t,Yfuncvec, reversible,k)
Ca = Yfuncvec(1); 
Cb = Yfuncvec(2); 
Cc = Yfuncvec(3); 
% Explicit equations

k1=k(1);
k2=k(2);
negk1 = k(3);
negk2 = k(4);
ra = 0-k1*Ca;
rb =k1*Ca-k2*Cb;
rc=k2*Cb;
 
if strcmp(reversible,'first')
    ra = ra + negk1*Cb;
    rb = rb - negk1*Cb;
elseif strcmp(reversible,'both')
    ra = ra + negk1*Cb;
    rb = rb - negk1*Cb + negk2*Cc;
    rc= rc - negk2*Cc;
end

% Differential equations
dCadt = ra; 
dCbdt = rb; 
dCcdt = rc; 
dYfuncvecdt = [dCadt; dCbdt; dCcdt]; 

