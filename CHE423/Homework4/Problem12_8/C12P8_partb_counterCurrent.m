    clear all;
%adiabatic case
%paramters
X0 = 0;
Fa0 = 5;
Ca0 = 2;
CI0 = Ca0*2;
CpI = 18;
CpA = 160;
CpB = 160;
E = 10000;
dHrx = -20000;
Kc0 = 1000;
roB = 1.2;
T0 = 300;
T1 = 300;
TaCounterCurrent = 386.928; %this value was arrived at by guessing and checking

k0 = 0.1;
Ua = 150;
V = 40;
alpha = 0.02;
mDotc = 50;
CpCoolant = 20;

R = 8.314;
P0 = (Ca0+CI0)*R*T0;%kPa

W = V*roB;
WSpan = 0:.1:W;


params = [0];
[WOut,Output]=ode45(@(W,X)ODEfun_C12P8_partb(W,X,params),WSpan,[X0,T0,TaCounterCurrent,P0]);
XOut = Output(:,1);
TOut = Output(:,2);
TaOut = Output(:,3)
POut = Output(:,4);

R = 1.987;%cal/mol*K;

KcExponentTerm = (-dHrx/R)*((1/T0)-(1./TOut));
Kc = Kc0*exp(KcExponentTerm);
Xe = Kc./(1+Kc);
k = k0*exp((E/R)*((1/T0)-(1./TOut)));
ra_prime = (-k*Ca0).*(1-(1+1./Kc).*XOut); 
rateOfDisappearance = -ra_prime;
VOut = WOut./roB;

subplot(4,1,1);
plot(VOut, XOut,VOut, Xe);
xlabel('Volume');
ylabel('Conversion');
legend('X','Xe');
title('Pressure vs Volume down the reactor counter current');

subplot(4,1,2);
plot(VOut, POut);
xlabel('Volume');
ylabel('Pressure kPa');
title('Pressure vs Volume down the reactor counter current');

subplot(4,1,3);
plot(VOut, TOut, VOut, TaOut);
xlabel('Volume');
ylabel('Temperature K');
legend('T','Ta');
title('Temperature vs Volume down the reactor counter current');

subplot(4,1,4);
plot(VOut, rateOfDisappearance);
xlabel('Volume');
ylabel('Rate of disappearance');
title('Rate of dissapearce vs Volume down the reactor counter current');

