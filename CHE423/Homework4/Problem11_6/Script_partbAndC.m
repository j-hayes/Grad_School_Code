clc

VSpan = 0:.5:500;
P = 2;%atm;
R = .082;%atm *L/mol/k
T0 = 1100;%K
Fa0 = 10;
dHrx = 80000;

CA0 = P/(R*T0);
CI0 = CA0; %same temp pressure assume ideal gas law
ThetaI = 0:1:20;
Cpa = 170;
Cpi = 200;
X0 = 0;
i = 1;
V = [];

params = [CA0;CI0;0;T0;Cpa;Cpi;dHrx;Fa0];
%No Inert Case
[VNoInert,OutputNoInert]=ode45(@(V,X)ODEfun(V,X,params),VSpan,X0);
X_NoInert = OutputNoInert(:,1);
Fb_NoInert = Fa0*X_NoInert;
T_NoInert = (X_NoInert*(-dHrx) + (Cpa+params(3)*Cpi)*T0)/(Cpa+params(3)*Cpi);
%Moderate Inert Case
params(3) = 1;
[VModInert,OutputModInert]=ode45(@(V,X)ODEfun(V,X,params),VSpan,X0);
X_ModInert = OutputModInert(:,1);
Fb_ModInert = Fa0*X_ModInert;
T_ModInert = (X_ModInert*(-dHrx) + (Cpa+params(3)*Cpi)*T0)/(Cpa+params(3)*Cpi);

%Large Inert Case
params(3) = 100;
[VModInert,OutputLargeInert]=ode45(@(V,X)ODEfun(V,X,params),VSpan,X0);
X_LargeInert = OutputLargeInert(:,1);
Fb_LargeInert = Fa0*X_LargeInert;
T_LargeInert = (X_LargeInert*(-dHrx) + (Cpa+params(3)*Cpi)*T0)/(Cpa+params(3)*Cpi);


Conversion = zeros(1001,21);
while i <= 21
   params = [CA0;CI0;ThetaI(i);T0;Cpa;Cpi;dHrx;Fa0];
   [Vout,Xoutput]=ode45(@(V,X)ODEfun(V,X,params),VSpan,X0); 
   V = Vout;
   Conversion(:,i) = Xoutput;
   i = i+1;
end

X_outlet =Conversion(1001,:);


subplot(4,1,1)
plot(VSpan,X_NoInert,VSpan,X_ModInert,VSpan,X_LargeInert);
legend('No Inert', 'Moderate Inert', 'Large Inert');
xlabel('Volume');
ylabel('Conversion');
title('Conversion Vs Volume');

subplot(4,1,2)
plot(VSpan,T_NoInert,VSpan,T_ModInert,VSpan,T_LargeInert);
legend('No Inert', 'Moderate Inert', 'Large Inert');
xlabel('Volume');
ylabel('Temp K');
title('Temperature Vs Volume');

subplot(4,1,3)
plot(ThetaI, X_outlet);
legend('Outlet Conversion');
xlabel('Theta I');
ylabel('Conversion');
title('Conversion Vs Theta I');

subplot(4,1,4)
plot(VSpan,Fb_NoInert,VSpan,Fb_ModInert,VSpan,Fb_LargeInert);
legend('No Inert', 'Moderate Inert', 'Large Inert');
xlabel('Volume');
ylabel('Mol/min');
title('Fb Vs Volume');

