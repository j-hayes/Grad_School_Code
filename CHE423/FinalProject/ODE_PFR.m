function dYfuncvecdt = ODE_PFR(V,Yfuncvec,params)
X_pfr1 = Yfuncvec(1); 
T_pfr1 = Yfuncvec(2);
Ta_pfr1 = Yfuncvec(3);

Ca0 = params(1);
Cb0= params(2) ;
volumetricFlowRateFeed= params(3);
Fa0= params(4);
Cps= params(5);
Ua= params(6);
mDotCp= params(7) ;
Cpcool= params(8);
T0_k = params(9);
T0_Kc= params(10) ;
k0= params(11);
Kc0= params(12);
dHrxn = params(13);
E = params(14);
R =  params(15);
isCounterCurrent = params(16);

CounterOrCocurrentTerm = 1;
if isCounterCurrent 
    CounterOrCocurrentTerm = -1;
end


Ca_pfr1 = Ca0*(1-X_pfr1);
Cb_pfr1 = Ca_pfr1;
Cc_pfr1 = Ca0*X_pfr1;

k_pfr_1 = getkAtTemperature(T0_k, T_pfr1, k0, E, R);
Kc_pfr_1 = getKcAtTemperature(T0_Kc, T_pfr1, Kc0, dHrxn, R);

ra = -k_pfr_1*((Ca_pfr1*Cb_pfr1)-(Cc_pfr1/Kc_pfr_1));

% Differential equations
dX_pfr1dV= -ra/Fa0;
dT_pfr1dV = ((-ra*dHrxn) - Ua*(T_pfr1-Ta_pfr1))/(Fa0*Cps);
dTa_pfr1dV = (CounterOrCocurrentTerm)*Ua*(T_pfr1-Ta_pfr1)/(mDotCp*Cpcool);
dYfuncvecdt = [dX_pfr1dV; dT_pfr1dV; dTa_pfr1dV];

end 
