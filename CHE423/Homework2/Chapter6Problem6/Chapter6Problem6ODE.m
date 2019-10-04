function dFdV = Chapter6Problem6ODE(V,FfunctionVector,reactorType)
%constants
K = 10;
Kc = .01;
Kca = 1;
Kcb = 40;
Fa0 = 100;
v0 = 100;
V = 20;
Ct0 = Fa0/v0;

Fa = FfunctionVector(1);
Fb = FfunctionVector(2);
Fc = FfunctionVector(3);

%explicit equations
Ft = Fa + Fb + Fc;

ra = 0-K*(Ct0*Fa/Ft - ((Ct0/Ft)^3)* (Fb*Fc^2/Kc));
rb = -ra;
rc = -2*ra;

Ra =Kca*Ct0*Fa/Ft;
Rb = Kcb*Ct0*Fb/Ft;

if  strcmp(reactorType,'pfr')
    Ra = 0;
    Rb = 0;
end



%differential equations
dFadV = ra - Ra;
dFbdV = rb - Rb;
dFcdV = rc;

dFdV = [dFadV; dFbdV;dFcdV];
end

