clear all;
%adiabatic case
%paramters
X0 = 0;
Fa0 = 5;
Ca0 = 2;
CI0 = Ca0*8;
CpI = 18;
CpA = 160;
CpB = 160;
E = 10000;
dHrx = -20000;
Kc0 = 1;
roB = 1.2;
%T1 = T0 = Ta0 all calculatiosn will use T0;
T0 = 300;
T1 = 300;
Ta0 = 300;

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
[WOut,Output]=ode45(@(W,X)ODEfun_C12P8_partf(W,X,params),WSpan,[X0,T0,P0]);
XOut = Output(:,1);
TOut = Output(:,2);
POut = Output(:,3);

R = 1.987;%cal/mol*K;

KcExponentTerm = (-dHrx/R)*((1/T0)-(1./TOut));
Kc = Kc0*exp(KcExponentTerm);
Xe = Kc./(1+Kc);
k = k0*exp((E/R)*((1/T0)-(1./TOut)));
ra_prime = (-k*Ca0).*(1-(1+1./Kc).*XOut); 
rateOfDisappearance = -ra_prime;
Qr = (ra_prime*dHrx); %Qr = Qg for isothermal 
TaOut = (TOut)-((ra_prime.*dHrx)/(Ua/roB));

VOut = WOut./roB;

subplot(4,1,1);
plot(VOut, XOut,VOut, Xe);
xlabel('Volume');
ylabel('Conversion');
legend('X','Xe');
title('Pressure vs Volume down the reactor isothermal');

subplot(4,1,2);
plot(VOut, Qr);
xlabel('Volume');
ylabel('Heat Removed cal');
title('Heat removed vs Volume down the reactor isothermal');

subplot(4,1,3);
plot(VOut, TOut, VOut, TaOut);
xlabel('Volume');
ylabel('Temperature K');
legend('T','Ta');
title('Temperature vs Volume down the reactor isothermal');

subplot(4,1,4);
plot(VOut, rateOfDisappearance);
xlabel('Volume');
ylabel('Rate of disappearance');
title('Rate of dissapearce vs Volume down the reactor isothermal');

