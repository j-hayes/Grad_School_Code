clc

VSpan = 0:.5:500;
P = 2;%atm;
R = .082;%atm *L/mol/k
T0 = 1100;%K
Fa0 = 10;
dHrx = -80000;%exothermic

CA0 = P/(R*T0);
CI0 = CA0; %same temp pressure assume ideal gas law
ThetaI = 0;
Cpa = 170;
Cpi = 200;
X0 = 0;
i = 1;
V = [];

params = [CA0;CI0;0;T0;Cpa;Cpi;dHrx;Fa0];
%No Inert Case
[VNoInert,OutputNoInert]=ode45(@(V,X)ODEfun_partf(V,X,params),VSpan,X0);
X_NoInert = OutputNoInert(:,1);
Ca = CA0*((1-X_NoInert)./(1+X_NoInert));
k = exp(34.34-34222/T0);
ra = -k*Ca; 
Q = ra*dHrx;



subplot(1,1,1)
plot(VNoInert, Q);
xlabel('J/L');
ylabel('Conversion');
title('Q Vs Volume');



